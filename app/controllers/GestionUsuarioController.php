<?php

use Phalcon\Flash;
use Phalcon\Session;

/**
 * Controlador de Gestion de Usuarios de la Plataforma
 * Universidad Distrital Francisco Jose de Caldas - LDWS
 */
class GestionusuarioController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('Gestion de Usuarios');
        parent::initialize();
    }

    public function indexAction()
    {
        $this->view->users = Users::find([
            "order" => "id ASC"
        ]);
    }

    public function newAction()
    {
        if ($this->request->isPost()) {
            $name = $this->request->getPost('name', 'striptags');
            $username = $this->request->getPost('username', 'alphanumeric');
            $email = $this->request->getPost('email', 'email');
            $password = $this->request->getPost('password');
            $role = $this->request->getPost('role', 'striptags');

            if (empty($name) || empty($username) || empty($email) || empty($password)) {
                $this->flash->error("Todos los campos obligatorios deben ser diligenciados.");
                return;
            }

            // Validar unicidad
            $existeUser = Users::findFirst([
                "conditions" => "username = ?1 OR email = ?2",
                "bind" => [1 => $username, 2 => $email]
            ]);

            if ($existeUser) {
                $this->flash->error("El nombre de usuario o correo electronico ya se encuentra registrado.");
                return;
            }

            $user = new Users();
            $user->name = $name;
            $user->username = $username;
            $user->email = $email;
            $user->password = sha1($password);
            $user->role = !empty($role) ? $role : 'Investigador';
            $user->active = 'Y';
            $user->created_at = date('Y-m-d H:i:s');

            if ($user->save() == false) {
                foreach ($user->getMessages() as $message) {
                    $this->flash->error((string) $message);
                }
            } else {
                $this->flash->success("Usuario '" . $user->username . "' registrado exitosamente.");
                return $this->response->redirect("gestionusuario/index");
            }
        }
    }
}
