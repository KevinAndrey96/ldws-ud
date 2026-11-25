<?php

use Phalcon\Mvc\User\Component;

/**
 * Elements
 *
 * Generador de elementos UI y barras de navegacion
 * Universidad Distrital Francisco Jose de Caldas - LDWS
 */
class Elements extends Component
{
    private $_headerMenu = [
        'navbar-left' => [
            'index' => [
                'caption' => 'Inicio',
                'action' => 'index'
            ],
            'empresa' => [
                'caption' => 'Empresa',
                'action' => 'index'
            ],
            'gestionsolicitud' => [
                'caption' => 'Solicitudes',
                'action' => 'index'
            ],
            'grafica' => [
                'caption' => 'Pisos y Topologia',
                'action' => 'index'
            ],
            'gestionequipos' => [
                'caption' => 'Equipos',
                'action' => 'index'
            ],
            'verreportes' => [
                'caption' => 'Reporte Tecnico',
                'action' => 'index'
            ],
            'gestionusuario' => [
                'caption' => 'Usuarios',
                'action' => 'index'
            ],
        ],
        'navbar-right' => [
            'session' => [
                'caption' => 'Ingresar / Registro',
                'action' => 'index'
            ],
        ]
    ];

    private $_tabs = [
        'Empresa' => [
            'controller' => 'empresa',
            'action' => 'index',
            'any' => false
        ],
        'Solicitudes' => [
            'controller' => 'gestionsolicitud',
            'action' => 'index',
            'any' => false
        ],
        'Pisos' => [
            'controller' => 'empresa',
            'action' => 'newpiso',
            'any' => false
        ],
        'Logico' => [
            'controller' => 'empresa',
            'action' => 'newlogico',
            'any' => false
        ],
        'Topologia' => [
            'controller' => 'grafica',
            'action' => 'index',
            'any' => false
        ],
        'Equipos' => [
            'controller' => 'gestionequipos',
            'action' => 'index',
            'any' => false
        ],
        'Reporte' => [
            'controller' => 'verreportes',
            'action' => 'index',
            'any' => false
        ],
        'Usuarios' => [
            'controller' => 'gestionusuario',
            'action' => 'index',
            'any' => false
        ]
    ];

    /**
     * Construye el menu de cabecera con opciones publicas y privadas
     */
    public function getMenu()
    {
        $auth = $this->session->get('auth');
        if ($auth) {
            $this->_headerMenu['navbar-right']['session'] = [
                'caption' => 'Cerrar Sesion (' . $this->session->get('name') . ')',
                'action' => 'end'
            ];
        } else {
            unset($this->_headerMenu['navbar-left']['empresa']);
            unset($this->_headerMenu['navbar-left']['gestionsolicitud']);
            unset($this->_headerMenu['navbar-left']['grafica']);
            unset($this->_headerMenu['navbar-left']['gestionequipos']);
            unset($this->_headerMenu['navbar-left']['verreportes']);
            unset($this->_headerMenu['navbar-left']['gestionusuario']);
        }

        $controllerName = $this->view->getControllerName();
        foreach ($this->_headerMenu as $position => $menu) {
            echo '<div class="nav-collapse">';
            echo '<ul class="nav navbar-nav ', $position, '">';
            foreach ($menu as $controller => $option) {
                if ($controllerName == $controller) {
                    echo '<li class="active">';
                } else {
                    echo '<li>';
                }
                echo $this->tag->linkTo($controller . '/' . $option['action'], $option['caption']);
                echo '</li>';
            }
            echo '</ul>';
            echo '</div>';
        }
    }

    /**
     * Retorna las pestañas de navegacion
     */
    public function getTabs()
    {
        $controllerName = $this->view->getControllerName();
        $actionName = $this->view->getActionName();
        echo '<ul class="nav nav-tabs">';

        foreach ($this->_tabs as $caption => $option) {
            if ($option['controller'] == $controllerName && ($option['action'] == $actionName || $option['any'])) {
                echo '<li class="active">';
            } else {
                echo '<li>';
            }
            echo $this->tag->linkTo($option['controller'] . '/' . $option['action'], $caption), '</li>';
        }
        echo '</ul>';
    }
}
