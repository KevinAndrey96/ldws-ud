<?php

$loader = new \Phalcon\Loader();

/**
 * We're a registering a set of directories taken from the configuration file
 */
$loader->registerDirs([
    APP_PATH . $config->application->controllersDir,
    APP_PATH . $config->application->pluginsDir,
    APP_PATH . $config->application->libraryDir,
    APP_PATH . $config->application->modelsDir,
    APP_PATH . $config->application->formsDir
])->register();

$loader->registerClasses([
    'Services' => APP_PATH . 'app/Services.php',
    'GestionusuarioController' => APP_PATH . $config->application->controllersDir . 'GestionUsuarioController.php',
    'GestionUsuarioController' => APP_PATH . $config->application->controllersDir . 'GestionUsuarioController.php',
    'GestionsolicitudController' => APP_PATH . $config->application->controllersDir . 'GestionSolicitudController.php',
    'GestionSolicitudController' => APP_PATH . $config->application->controllersDir . 'GestionSolicitudController.php',
]);

