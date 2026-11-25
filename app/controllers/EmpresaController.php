<?php

use Phalcon\Flash;
use Phalcon\Session;

/**
 * Controlador de Gestion de Empresa, Pisos y Diseno Logico
 * Universidad Distrital Francisco Jose de Caldas - LDWS
 */
class EmpresaController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('Empresa');
        parent::initialize();
    }

    public function indexAction()
    {
        $usuarioId = $this->session->get("id");
        $empresa = Empresas::find([
            "conditions" => "IdUsuario = ?1",
            "bind" => [1 => $usuarioId],
        ]);
        
        $data = [];

        foreach ($empresa as $item) {
            $data[] = (object) [
                "nombre" => $item->Nombre,
                "mision" => $item->Mision,
                "vision" => $item->Vision,
                "nit" => $item->Nit,
                "id" => $item->IdEmpresa
            ];
        }
        
        $this->view->datos = $data;
    }

    public function newAction()
    {
        $form = new RegisterForm;

        if ($this->request->isPost()) {
            $Nombre = $this->request->getPost('Nombre', 'striptags');
            $Nit = $this->request->getPost('Nit', 'striptags');
            $Mision = $this->request->getPost('Mision', 'striptags');
            $Vision = $this->request->getPost('Vision', 'striptags');
            $Usuario = $this->session->get("id");

            $Empresa = new Empresas();
            $Empresa->Nombre = $Nombre;
            $Empresa->IdUsuario = $Usuario;
            $Empresa->Nit = $Nit;
            $Empresa->Mision = $Mision;
            $Empresa->Vision = $Vision;
            $Empresa->created_at = date('Y-m-d H:i:s');
            
            if ($Empresa->save() == false) {
                foreach ($Empresa->getMessages() as $message) {
                    $this->flash->error((string) $message);
                }
            } else {
                $this->session->set("id_empresa", $Empresa->IdEmpresa);
                $this->flash->success('La empresa se ha registrado satisfactoriamente');
                return $this->response->redirect("gestionsolicitud/new");
            }
        }

        $this->view->form = $form;
    }

    public function newPisoAction()
    {
        $this->view->empresa = Empresas::find();

        if ($this->request->isPost()) {
            $Empresa = $this->session->get("id_empresa");

            if (empty($Empresa)) {
                $emp = Empresas::findFirst([
                    "conditions" => "IdUsuario = ?1",
                    "bind" => [1 => $this->session->get("id")],
                    "order" => "IdEmpresa DESC"
                ]);
                if ($emp) {
                    $Empresa = $emp->IdEmpresa;
                    $this->session->set("id_empresa", $Empresa);
                }
            }

            $Alto = $this->request->getPost('alto');
            $Ancho = $this->request->getPost('ancho');
            $Largo = $this->request->getPost('largo');
            $Equipo = $this->request->getPost('equipos');
            $Sala = $this->request->getPost('sala');

            $num = Pisos::findFirst([
                "conditions" => "id_empresa = ?1",
                "bind" => [1 => $Empresa],
                "order" => "id_piso DESC"
            ]);

            $piso = new Pisos();
            $piso->id_empresa = $Empresa;
            $piso->alto = $Alto;
            $piso->ancho = $Ancho;
            $piso->largo = $Largo;
            $piso->equipos = $Equipo;
            $piso->sala = ($Sala == 'on' || $Sala == '1') ? 1 : 0;
            $piso->numero = $num ? ($num->numero + 1) : 1;
            $piso->created_at = date('Y-m-d H:i:s');

            if ($piso->save() == false) {
                $this->flash->error('No se ha podido guardar el piso');
            } else {
                $this->flash->success('Se ha registrado el Piso ' . $piso->numero . ' satisfactoriamente');
                return $this->response->redirect("empresa/newpiso");
            }
        }
    }

    public function newLogicoAction()
    {
        if ($this->request->isPost()) {
            $idEmpresa = $this->session->get("id_empresa");

            if (empty($idEmpresa)) {
                $emp = Empresas::findFirst([
                    "conditions" => "IdUsuario = ?1",
                    "bind" => [1 => $this->session->get("id")],
                    "order" => "IdEmpresa DESC"
                ]);
                if ($emp) {
                    $idEmpresa = $emp->IdEmpresa;
                    $this->session->set("id_empresa", $idEmpresa);
                }
            }

            $Redundancia = $this->request->getPost('redundancia');
            $Escalabilidad = $this->request->getPost('escalabilidad');
            $Subredes = $this->request->getPost('subredes');
            $Descripcion = $this->request->getPost('desc');
            $Scripts = $this->request->getPost('script');
            $TablaIP = $this->request->getPost('ip');

            $request = Solicitudes::findFirst([
                "conditions" => "IdEmpresa = ?1",
                "bind" => [1 => $idEmpresa],
                "order" => "IdSolicitud DESC"
            ]);

            if (!$request) {
                $this->flash->error('No se encontro una solicitud activa para asociar el diseno logico');
                return $this->response->redirect("gestionsolicitud/new");
            }

            $Solicitud = $request->IdSolicitud;
            $logico = new Logico();
            $logico->id_solicitud = $Solicitud;
            $logico->escalabilidad = !empty($Escalabilidad) ? $Escalabilidad : "30%";
            $logico->subredes = !empty($Subredes) ? (int)$Subredes : 4;
            $logico->desc_subred = $Descripcion;
            $logico->redundancia = ($Redundancia == 'on' || $Redundancia == '1') ? 1 : 0;
            $logico->scripts = ($Scripts == 'on' || $Scripts == '1') ? 1 : 0;
            $logico->tabla_dirip = ($TablaIP == 'on' || $TablaIP == '1') ? 1 : 0;
            $logico->created_at = date('Y-m-d H:i:s');
            
            if ($logico->save() == false) {
                $this->flash->error('No se ha podido guardar la informacion logica');
            } else {
                $this->flash->success('Diseno logico guardado exitosamente. Visualice la topologia de pisos y equipos.');
                return $this->response->redirect("grafica/index");
            }
        }
    }
}
