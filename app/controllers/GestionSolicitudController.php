<?php

use Phalcon\Mvc\Model;
use Phalcon\Paginator\Adapter\Model as Paginator;

class GestionsolicitudController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('Gestión de Usuario');
        parent::initialize();
    }

    public function indexAction()
    {
    	$request = Solicitudes::find();
    	
    	$data = array();

        foreach ($request as $item){
            $data[] = (object) array(
                "Solicitud" => $item->IdSolicitud,
                "Descripcion" => $item->Descripcion,
                "Observaciones" => $item->Observaciones,
            );
        }
        
        //print_r($data);die;
        $this->view->datos = $data;
    }

    public function newAction()
    {
        $this->view->empresa = Empresas::find();
        
        if ($this->request->isPost()) {
        	$post = $this->request->getPost();

            $idEmpresa = $post['empresa'];
            $descripcion = $post['desc'];
            $objetivos = $post['obj'];
            $observaciones = $post['obs'];
            $servicio = $post['serv'];

            //print_r($idEmpresa);die;

            $request = new Solicitudes();
            $request->IdEmpresa = $idEmpresa;
            $request->Descripcion = $descripcion;
            $request->Objetivos = $objetivos;
            $request->Observaciones = $observaciones;
            $request->Servicio = $servicio;

            $request->save();
            
            if ($request->save() == false) {
                $this->flash->error("No se pudo guardar la solicitud");
            } else {
                $this->flash->success('Se guardo la solicitud exitosamente');
                return $this->dispatcher->forward(
                    [
                        "controller" => "gestionsolicitud",
                        "action"     => "index",
                    ]
                );
            }
        }

        $this->view->form = $form;
    }
}
