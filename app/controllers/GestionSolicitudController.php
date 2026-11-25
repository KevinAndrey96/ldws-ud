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
        $data = array();
        $solicitudes = array();
        $empresa = Empresas::find(array(
                "conditions" => "IdUsuario = ?1",
                "bind" => array(1 => $this->session->get("id")),
            ));

        foreach ($empresa as $key){
            $request = Solicitudes::findFirst(array(
                "conditions" => "IdEmpresa = ?1",
                "bind" => array(1 => $key->IdEmpresa),
            ));

            if ($request) {
                array_push($solicitudes, $request->IdSolicitud);
            }
        }

        //print_r($solicitudes);die;
        foreach ($solicitudes as $s){
            $solicitud = Solicitudes::findFirst(array(
                "conditions" => "IdSolicitud = ?1",
                "bind" => array(1 => $s),
            ));

            $data[] = (object) array(
                "Solicitud" => $solicitud->IdSolicitud,
                "Titulo" => $solicitud->titulo,
                "Descripcion" => $solicitud->Descripcion,
                "Observaciones" => $solicitud->Observaciones,
            );
        }

        $this->view->datos = $data;
    }

    public function newAction()
    {
        $this->view->empresa = Empresas::find();
        
        if ($this->request->isPost()) {

        	$post = $this->request->getPost();
            $idEmpresa = $post['IdEmpresa'];


            if ($post['validar'] != true) {
                $titulo = $post['titulo'];
                $descripcion = $post['desc'];
                $objetivos = $post['obj'];
                $observaciones = $post['obs'];
                $servicio = $post['serv'];

                $request = new Solicitudes();
                $request->IdEmpresa = $idEmpresa;
                $request->Descripcion = $descripcion;
                $request->Objetivos = $objetivos;
                $request->Observaciones = $observaciones;
                $request->Servicio = $servicio;
                $request->titulo = $titulo;
                
                if ($request->save() == false) {
                    $this->flash->error("No se pudo guardar la solicitud");
                } else {
                    $this->flash->success('Se guardo la solicitud exitosamente');
                    $this->session->set("id_empresa", $idEmpresa);
                    return $this->response->redirect("empresa/newpiso");
                }
            } else {
                $this->view->idempresa = $idEmpresa;
            } 
        }
    }
}
