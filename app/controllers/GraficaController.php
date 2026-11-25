<?php

use Phalcon\Flash;
use Phalcon\Session;

/**
 * Controlador de Visualizacion Grafica Multinivel de Pisos
 * Universidad Distrital Francisco Jose de Caldas - LDWS
 */
class GraficaController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('Visualizacion de Pisos');
        parent::initialize();
    }

    public function indexAction()
    {
        $usuarioId = $this->session->get("id");

        $empresa = Empresas::findFirst([
            "conditions" => "IdUsuario = ?1",
            "bind" => [1 => $usuarioId],
            "order" => "IdEmpresa DESC"
        ]);

        $pisos = [];
        if ($empresa) {
            $pisos = Pisos::find([
                "conditions" => "id_empresa = ?1",
                "bind" => [1 => $empresa->IdEmpresa],
                "order" => "numero DESC"
            ]);
        }

        if (count($pisos) == 0) {
            // Pisos por defecto para demostracion visual
            $piso1 = new Pisos();
            $piso1->numero = 1;
            $piso1->largo = 35.0;
            $piso1->ancho = 25.0;
            $piso1->alto = 3.5;
            $piso1->equipos = 45;
            $piso1->sala = 1;

            $piso2 = new Pisos();
            $piso2->numero = 2;
            $piso2->largo = 35.0;
            $piso2->ancho = 25.0;
            $piso2->alto = 3.2;
            $piso2->equipos = 38;
            $piso2->sala = 0;

            $piso3 = new Pisos();
            $piso3->numero = 3;
            $piso3->largo = 35.0;
            $piso3->ancho = 25.0;
            $piso3->alto = 3.2;
            $piso3->equipos = 24;
            $piso3->sala = 0;

            $pisos = [$piso3, $piso2, $piso1];
        }

        $this->view->empresa = $empresa;
        $this->view->pisos = $pisos;
    }
}
