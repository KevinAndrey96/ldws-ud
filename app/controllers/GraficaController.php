<?php
use Phalcon\Flash;
use Phalcon\Session;

class GraficaController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('Gráfica');
        parent::initialize();
    }

    /**
     * Shows the index action
     */
    public function indexAction()
    {

    }

}
