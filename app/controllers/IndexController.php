<?php

class IndexController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('Bienvenido');
        parent::initialize();
    }

    public function indexAction()
    {
        if (!$this->request->isPost()) {
            $this->flash->notice('Bienvenido al sistema LDWS');
        }
          /*
        if ($this->session->has("auth")->user->name) {
            $name = $this->session->get("auth")->user->name;
            $this->view->name = $name;
        }else
        {
            $name="Yaper";
            $this->view->name = $name;
        }*/
    }
}
