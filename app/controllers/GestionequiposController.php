<?php

use Phalcon\Flash;
use Phalcon\Session;

/**
 * Controlador de Gestion de Equipos de Red y Calculo de Materiales (BOM)
 * Universidad Distrital Francisco Jose de Caldas - LDWS
 */
class GestionequiposController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('Gestion de Equipos');
        parent::initialize();
    }

    public function indexAction()
    {
        $usuarioId = $this->session->get("id");

        // 1. Obtener la empresa del usuario
        $empresa = Empresas::findFirst([
            "conditions" => "IdUsuario = ?1",
            "bind" => [1 => $usuarioId],
            "order" => "IdEmpresa DESC"
        ]);

        if (!$empresa) {
            $this->flash->notice("Por favor registre primero los datos de su empresa para calcular el inventario de equipos.");
            return $this->response->redirect("empresa/new");
        }

        // 2. Obtener la solicitud activa
        $solicitud = Solicitudes::findFirst([
            "conditions" => "IdEmpresa = ?1",
            "bind" => [1 => $empresa->IdEmpresa],
            "order" => "IdSolicitud DESC"
        ]);

        if (!$solicitud) {
            $this->flash->notice("Registre una solicitud de diseno de red antes de gestionar los equipos.");
            return $this->response->redirect("gestionsolicitud/new");
        }

        // 3. Obtener pisos asociados
        $pisos = Pisos::find([
            "conditions" => "id_empresa = ?1",
            "bind" => [1 => $empresa->IdEmpresa],
            "order" => "numero ASC"
        ]);

        // 4. Obtener diseno logico
        $logico = Logico::findFirst([
            "conditions" => "id_solicitud = ?1",
            "bind" => [1 => $solicitud->IdSolicitud]
        ]);

        // 5. Verificar si ya existen equipos calculados; si no, calcularlos
        $equiposExistentes = Equipos::find([
            "conditions" => "id_solicitud = ?1",
            "bind" => [1 => $solicitud->IdSolicitud]
        ]);

        if (count($equiposExistentes) == 0 && count($pisos) > 0) {
            $this->autoCalcularEquipos($solicitud->IdSolicitud, $pisos, $logico);
            $equiposExistentes = Equipos::find([
                "conditions" => "id_solicitud = ?1",
                "bind" => [1 => $solicitud->IdSolicitud]
            ]);
        }

        // Calcular metricas de resumen para la vista
        $totalPuestos = 0;
        $totalMetrosCable = 0.0;
        $totalCajasUtp = 0;
        $totalAPs = 0;

        foreach ($pisos as $p) {
            $totalPuestos += (int)$p->equipos;
            $totalMetrosCable += $p->getCableMetros();
            $totalCajasUtp += $p->getCajasUtp();
            $totalAPs += $p->getAccessPoints();
        }

        $this->view->empresa = $empresa;
        $this->view->solicitud = $solicitud;
        $this->view->pisos = $pisos;
        $this->view->equipos = $equiposExistentes;
        $this->view->logico = $logico;
        $this->view->totalPuestos = $totalPuestos;
        $this->view->totalMetrosCable = $totalMetrosCable;
        $this->view->totalCajasUtp = $totalCajasUtp;
        $this->view->totalAPs = $totalAPs;
    }

    /**
     * Calculo y aprovisionamiento automatico de hardware segun Top-Down Network Design
     */
    private function autoCalcularEquipos($idSolicitud, $pisos, $logico)
    {
        // A. Switch de Nucleo (Core L3)
        $swCore = new Equipos();
        $swCore->id_solicitud = $idSolicitud;
        $swCore->tipo_equipo = "Switch de Nucleo (Core L3)";
        $swCore->modelo = "Cisco Catalyst 3850-24XU Capa 3";
        $swCore->capa_osi = 3;
        $swCore->cantidad = 1;
        $swCore->puertos = 24;
        $swCore->ubicacion = "MDF Piso 1 (Sala de Telecomunicaciones)";
        $swCore->descripcion = "Enrutamiento Inter-VLAN, soporte 10GbE uplink y alta velocidad de conmutacion.";
        $swCore->save();

        // B. Router de Borde / Gateway
        $router = new Equipos();
        $router->id_solicitud = $idSolicitud;
        $router->tipo_equipo = "Router de Borde / Gateway";
        $router->modelo = "Cisco ISR 4331 Security Bundle";
        $router->capa_osi = 3;
        $router->cantidad = 1;
        $router->puertos = 3;
        $router->ubicacion = "MDF Piso 1";
        $router->descripcion = "Acceso a WAN/Internet, firewall de inspeccion de estado (Zone-Based) y NAT/PAT.";
        $router->save();

        // C. Switches de Acceso por cada piso
        foreach ($pisos as $piso) {
            $swAcceso = new Equipos();
            $swAcceso->id_solicitud = $idSolicitud;
            $swAcceso->tipo_equipo = "Switch de Acceso PoE+";
            $swAcceso->modelo = "Cisco Catalyst 2960-X 48 GigE PoE+";
            $swAcceso->capa_osi = 2;
            $swAcceso->cantidad = $piso->getSwitchesAcceso();
            $swAcceso->puertos = 48;
            $swAcceso->ubicacion = $piso->sala ? "MDF Piso " . $piso->numero : "IDF Piso " . $piso->numero;
            $swAcceso->descripcion = "Conectividad Gigabit para " . $piso->equipos . " puestos y " . $piso->getAccessPoints() . " puntos de acceso en Piso " . $piso->numero . ".";
            $swAcceso->save();

            // Puntos de Acceso Wi-Fi
            $wap = new Equipos();
            $wap->id_solicitud = $idSolicitud;
            $wap->tipo_equipo = "Punto de Acceso Inalambrico (WAP)";
            $wap->modelo = "Cisco Aironet 2802i Dual Band 802.11ac Wave 2";
            $wap->capa_osi = 2;
            $wap->cantidad = $piso->getAccessPoints();
            $wap->puertos = 2;
            $wap->ubicacion = "Techo / Pasillo Piso " . $piso->numero;
            $wap->descripcion = "Cobertura Wi-Fi para puestos moviles y red de invitados en Piso " . $piso->numero . ".";
            $wap->save();
        }
    }
}
