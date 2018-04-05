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
        $empresa = Empresas::find();
        
        $data = array();

        foreach ($empresa as $item){
            $data[] = (object) array(
                "nombre" => $item->Nombre,
                "mision" => $item->Mision,
                "vision" => $item->Vision,
                "nit" => $item->Nit,
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
            $Usuario = "1";

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

                return $this->dispatcher->forward(
                    [
                        "controller" => "session",
                        "action"     => "index",
                    ]
                );
            }
            
        }

        $this->view->form = $form;
    }

    public function newPisoAction()
    {
        $this->view->empresa = Empresas::find();
        if ($this->request->isPost()) {

            $Empresa = $this->request->getPost('empresa');
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
}
