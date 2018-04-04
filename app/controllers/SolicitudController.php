<?php
use Phalcon\Flash;
use Phalcon\Session;
class SolicitudController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('Solicitud');
        parent::initialize();
    }

    public function indexAction()
    {
    }
}
