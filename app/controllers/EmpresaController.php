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
            $Empresa->Usuario = $Usuario;
            $Empresa->Nit = $Nit;
            $Empresa->Mision = $Mision;
            $Empresa->Vision = $Vision;
            
            if ($Empresa->save() == false) {
                foreach ($Empresa->getMessages() as $message) {
                    $this->flash->error((string) $message);
                }
            } else {
               
                $this->flash->success('La emrpesa se ha registrado satisfactoriamente');

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
}
