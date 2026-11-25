<?php

use Phalcon\Flash;
use Phalcon\Session;

/**
 * Controlador de Generacion y Exportacion del Reporte Tecnico Top-Down
 * Universidad Distrital Francisco Jose de Caldas - LDWS
 */
class VerreportesController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('Reporte Tecnico Top-Down');
        parent::initialize();
    }

    public function indexAction()
    {
        $usuarioId = $this->session->get("id");

        // 1. Obtener Empresa
        $empresa = Empresas::findFirst([
            "conditions" => "IdUsuario = ?1",
            "bind" => [1 => $usuarioId],
            "order" => "IdEmpresa DESC"
        ]);

        if (!$empresa) {
            $this->flash->notice("Registre los datos de su empresa para generar el reporte tecnico.");
            return $this->response->redirect("empresa/new");
        }

        // 2. Obtener Solicitud
        $solicitud = Solicitudes::findFirst([
            "conditions" => "IdEmpresa = ?1",
            "bind" => [1 => $empresa->IdEmpresa],
            "order" => "IdSolicitud DESC"
        ]);

        // 3. Obtener Pisos
        $pisos = Pisos::find([
            "conditions" => "id_empresa = ?1",
            "bind" => [1 => $empresa->IdEmpresa],
            "order" => "numero ASC"
        ]);

        // 4. Obtener Diseno Logico
        $logico = null;
        if ($solicitud) {
            $logico = Logico::findFirst([
                "conditions" => "id_solicitud = ?1",
                "bind" => [1 => $solicitud->IdSolicitud]
            ]);
        }

        if (!$logico) {
            $logico = new Logico();
            $logico->redundancia = 1;
            $logico->escalabilidad = "35%";
            $logico->subredes = 4;
            $logico->desc_subred = "VLAN 10 Datos, VLAN 20 VoIP, VLAN 30 Servidores, VLAN 99 Invitados";
            $logico->scripts = 1;
            $logico->tabla_dirip = 1;
        }

        // 5. Obtener Equipos
        $equipos = [];
        if ($solicitud) {
            $equipos = Equipos::find([
                "conditions" => "id_solicitud = ?1",
                "bind" => [1 => $solicitud->IdSolicitud]
            ]);
        }

        // Totales consolidados
        $totalPuestos = 0;
        $totalArea = 0.0;
        $totalMetrosCable = 0.0;
        $totalCajasUtp = 0;
        $totalAPs = 0;

        foreach ($pisos as $p) {
            $totalPuestos += (int)$p->equipos;
            $totalArea += $p->getArea();
            $totalMetrosCable += $p->getCableMetros();
            $totalCajasUtp += $p->getCajasUtp();
            $totalAPs += $p->getAccessPoints();
        }

        $this->view->empresa = $empresa;
        $this->view->solicitud = $solicitud;
        $this->view->pisos = $pisos;
        $this->view->logico = $logico;
        $this->view->equipos = $equipos;
        $this->view->vlans = $logico->getVlansCalculadas();
        $this->view->scriptSwitch = $logico->getCiscoSwitchConfig();
        $this->view->scriptRouter = $logico->getCiscoRouterConfig();
        $this->view->totalPuestos = $totalPuestos;
        $this->view->totalArea = $totalArea;
        $this->view->totalMetrosCable = $totalMetrosCable;
        $this->view->totalCajasUtp = $totalCajasUtp;
        $this->view->totalAPs = $totalAPs;
    }
}
