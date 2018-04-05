<?php
use Phalcon\Mvc\Model;
use Phalcon\Paginator\Adapter\Model as Paginator;

class GestionusuarioController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('Gestión de Usuario');
        parent::initialize();
    }

    public function indexAction()
    {
        $users = Users::find();

        $this->view->datos = $users;
    }

    public function newAction()
    {
    }

        /**
     * Saves the user from the 'edit' action
     */
    public function editAction($id)
    {
        if (!$this->request->isPost()) {

            $user = Users::findFirstById($id);
            if (!$user) {
                $this->flash->error("Usuario no encontrado");

                return $this->dispatcher->forward(
                    [
                        "controller" => "gestionusuario",
                        "action"     => "index",
                    ]
                );
            } else {
                $this->view->user = $user;
                $this->view->roles = Rol::find();
                $this->tag->setDefault('id_rol', $user->rol_idrol); 
                $this->tag->setDefault('active', $user->active); 
            }
        } elseif ($this->request->isPost()) {
            $post = $this->request->getPost();

            $user = Users::findFirst($post['id']);
            $user->name = $post['name'];
            $user->email = $post['email'];
            $user->telefono = $post['phone'];
            $user->rol_idrol = $post['id_rol'];
            $user->active = $post['active'];
            $user->save();

            $this->flash->success("Usuario Actualizado con exito.");

            return $this->dispatcher->forward(
                [
                    "controller" => "gestionusuario",
                    "action"     => "index",
                ]
            );
        }
    }

        /**
     * Deletes a user
     *
     * @param string $id
     */
    public function deleteAction($id)
    {

        $user = Users::findFirstById($id);
        if (!$user) {
            $this->flash->error("Usuario no encontradp");

            return $this->dispatcher->forward(
                [
                    "controller" => "gestionusuario",
                    "action"     => "index",
                ]
            );
        }

        if (!$user->delete()) {
            $this->flash->error("Usuario no eliminado");
            return $this->dispatcher->forward(
                [
                    "controller" => "gestionusuario",
                    "action"     => "index",
                ]
            );
        }
}
