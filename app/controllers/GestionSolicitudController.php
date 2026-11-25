<?php

use Phalcon\Mvc\Model;
use Phalcon\Paginator\Adapter\Model as Paginator;

/**
 * Controlador de Gestion de Solicitudes de Diseno de Red
 * Universidad Distrital Francisco Jose de Caldas - LDWS
 */
class GestionsolicitudController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('Gestion de Solicitudes');
        parent::initialize();
    }

    public function indexAction()
    {
        $data = [];
        $usuarioId = $this->session->get("id");

        $empresas = Empresas::find([
            "conditions" => "IdUsuario = ?1",
            "bind" => [1 => $usuarioId],
        ]);

        foreach ($empresas as $emp) {
            $solicitudes = Solicitudes::find([
                "conditions" => "IdEmpresa = ?1",
                "bind" => [1 => $emp->IdEmpresa],
                "order" => "IdSolicitud DESC"
            ]);

            foreach ($solicitudes as $solicitud) {
                $data[] = (object) [
                    "Solicitud" => $solicitud->IdSolicitud,
                    "Empresa" => $emp->Nombre,
                    "Titulo" => $solicitud->titulo,
                    "Descripcion" => $solicitud->Descripcion,
                    "Observaciones" => $solicitud->Observaciones,
                    "Servicio" => $solicitud->Servicio,
                    "Fecha" => $solicitud->created_at
                ];
            }
        }

        $this->view->datos = $data;
    }

    public function newAction()
    {
        $usuarioId = $this->session->get("id");
        $this->view->empresa = Empresas::find([
            "conditions" => "IdUsuario = ?1",
            "bind" => [1 => $usuarioId]
        ]);
        
        if ($this->request->isPost()) {
            $post = $this->request->getPost();
            $idEmpresa = isset($post['IdEmpresa']) ? $post['IdEmpresa'] : null;

            if (empty($idEmpresa)) {
                $emp = Empresas::findFirst([
                    "conditions" => "IdUsuario = ?1",
                    "bind" => [1 => $usuarioId],
                    "order" => "IdEmpresa DESC"
                ]);
                if ($emp) $idEmpresa = $emp->IdEmpresa;
            }

            if (!isset($post['validar']) || $post['validar'] != true) {
                $titulo = isset($post['titulo']) ? $post['titulo'] : '';
                $descripcion = isset($post['desc']) ? $post['desc'] : '';
                $objetivos = isset($post['obj']) ? $post['obj'] : '';
                $observaciones = isset($post['obs']) ? $post['obs'] : '';
                $servicioRaw = isset($post['serv']) ? $post['serv'] : 'Datos';

                $servicio = is_array($servicioRaw) ? implode(', ', $servicioRaw) : (string)$servicioRaw;

                $request = new Solicitudes();
                $request->IdEmpresa = $idEmpresa;
                $request->Descripcion = $descripcion;
                $request->Objetivos = $objetivos;
                $request->Observaciones = $observaciones;
                $request->Servicio = $servicio;
                $request->titulo = $titulo;
                $request->created_at = date('Y-m-d H:i:s');
                
                if ($request->save() == false) {
                    $this->flash->error("No se pudo guardar la solicitud");
                } else {
                    $this->flash->success('Se guardo la solicitud exitosamente. Proceda a configurar los niveles fisicos.');
                    $this->session->set("id_empresa", $idEmpresa);
                    return $this->response->redirect("empresa/newpiso");
                }
            } else {
                $this->view->idempresa = $idEmpresa;
            } 
        }
    }
}
