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
        /*$num = Pisos::findFirst(array(
                "conditions" => "id_empresa = ?1",
                "bind" => array(1 => $Empresa),
                "order" => "id DESC"
            ));*/
        $num=1;
        //$this->view->datos = $data;
    }

}
