<?php
use Phalcon\Flash;
use Phalcon\Session;
class EmpresaController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('Empresa');
        parent::initialize();
    }

    public function indexAction()
    {
        //$empresa = Empresas::find();
        $empresa = Empresas::find(array(
                "conditions" => "IdUsuario = ?1",
                "bind" => array(1 => $this->session->get("id")),
            ));
        
        $data = array();

        foreach ($empresa as $item){
            $data[] = (object) array(
                "nombre" => $item->Nombre,
                "mision" => $item->Mision,
                "vision" => $item->Vision,
                "nit" => $item->Nit,
                "id" => $item->IdEmpresa
            );
        }
        
        $this->view->datos = $data;
    }

    public function newAction()
    {
        $form = new RegisterForm;

        if ($this->request->isPost()) {

            $Nombre = $this->request->getPost('Nombre');
            $Nit = $this->request->getPost('Nit');
            $Mision = $this->request->getPost('Mision');
            $Vision = $this->request->getPost('Vision');
            $Usuario = $this->session->get("id");

            $Empresa = new Empresas();
            $Empresa->Nombre = $Nombre;
            $Empresa->IdUsuario = $Usuario;
            $Empresa->Nit = $Nit;
            $Empresa->Mision = $Mision;
            $Empresa->Vision = $Vision;
            
            if ($Empresa->save() == false) {
                foreach ($Empresa->getMessages() as $message) {
                    $this->flash->error((string) $message);
                }
            } else {
                $this->flash->success('La empresa se ha registrado satisfactoriamente');
                return $this->response->redirect("empresa/index");
            }
            
        }

        $this->view->form = $form;
    }

    public function newPisoAction()
    {
        $this->view->empresa = Empresas::find();
        if ($this->request->isPost()) {

            $Empresa = $this->session->get("id_empresa");
            $Alto = $this->request->getPost('alto');
            $Ancho = $this->request->getPost('ancho');
            $Largo = $this->request->getPost('largo');
            $Equipo = $this->request->getPost('equipos');
            $Sala = $this->request->getPost('sala');

            $num = Pisos::findFirst(array(
                "conditions" => "id_empresa = ?1",
                "bind" => array(1 => $Empresa),
                "order" => "id_piso DESC"
            ));

            $piso = new Pisos();
            $piso->id_empresa = $Empresa;
            $piso->alto = $Alto;
            $piso->ancho = $Ancho;
            $piso->largo = $Largo;
            $piso->equipos = $Equipo;

            if ($Sala == 'on') {
                $piso->sala = 1;
            } else {
                $piso->sala = 0;
            }
            
            if ($num) {
                $piso->numero = $num->numero+1;
            } else {
                $piso->numero = 1;
            }

            if ($piso->save() == false) {
                $this->flash->error('No se ha podido el piso satisfactoriamente');
            } else {
                $this->flash->success('Se ha registrado el piso satisfactoriamente');

                return $this->response->redirect("empresa/newpiso");
            }
        }
    }

    public function newLogicoAction()
    {
        if ($this->request->isPost()) {

            $Redundancia = $this->request->getPost('redundancia');
            $Escalabilidad = $this->request->getPost('escalabilidad');
            $Subredes = $this->request->getPost('subredes');
            $Descripcion = $this->request->getPost('desc');
            $Scripts = $this->request->getPost('script');
            $TablaIP = $this->request->getPost('ip');

            $request = Solicitudes::findFirst(array(
                "conditions" => "IdEmpresa = ?1",
                "bind" => array(1 => $this->session->get("id_empresa")),
                "order" => "IdSolicitud DESC"
            ));

            $Solicitud = $request->IdSolicitud;
            $logico = new Logico();
            $logico->id_solicitud = $Solicitud;
            $logico->escalabilidad = $Escalabilidad;
            $logico->subredes = $Subredes;
            $logico->desc_subred = $Descripcion;

            if ($Redundancia == 'on') {
                $logico->redundancia = 1;
            } else {
                $logico->redundancia = 0;
            }
            if ($Scripts == 'on') {
                $logico->scripts = 1;
            } else {
                $logico->scripts = 0;
            }
            if ($TablaIP == 'on') {
                $logico->tabla_dirip = 1;
            } else {
                $logico->tabla_dirip = 0;
            }
            
            if ($logico->save() == false) {
                $this->flash->error('No se ha podido la informacion satisfactoriamente');
            } else {
                $this->flash->success('Se ha registrado la informacion satisfactoriamente');
                $this->session->set("id_empresa", "");
                return $this->response->redirect("empresa/newlogico");
            }
        }
    }
}
