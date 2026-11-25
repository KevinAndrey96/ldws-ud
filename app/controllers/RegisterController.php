<?php

/**
 * SessionController
 *
 * Allows to register new users
 */
class RegisterController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('Registro');
        parent::initialize();
    }

    /**
     * Action to register a new user
     */
    public function indexAction()
    {
        $form = new RegisterForm;

        if ($this->request->isPost()) {

            $name = $this->request->getPost('name', ['string', 'striptags']);
            $username = $this->request->getPost('username', 'alphanum');
            $email = $this->request->getPost('email', 'email');
            $password = $this->request->getPost('password');
            $repeatPassword = $this->request->getPost('repeatPassword');
            $phone_number = $this->request->getPost('phone_number');

            if ($password != $repeatPassword) {
                $this->flash->error('Passwords are different');
                return false;
            }

            $user = new Users();
            $user->username = $username;
            $user->password = sha1($password);
            $user->name = $name;
            $user->email = $email;
            $user->created_at = new Phalcon\Db\RawValue('now()');
            $user->updated_at = new Phalcon\Db\RawValue('now()');
            $user->telefono = $phone_number;
            $user->rol_idrol = 2;
            $user->active = 'Y';
            if ($user->save() == false) {
                foreach ($user->getMessages() as $message) {
                    $this->flash->error((string) $message);
                }
            } else {
                $this->tag->setDefault('email', '');
                $this->tag->setDefault('password', '');
                $this->flash->success('Gracias por registrarse, por favor inicie sesión');

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
