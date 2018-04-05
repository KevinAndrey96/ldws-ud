<?php

use Phalcon\Mvc\Controller;

class ControllerBase extends Controller
{

    protected function initialize()
    {
        $this->tag->prependTitle('IDWS UD');
        $this->view->setTemplateAfter('main');
    }
}
