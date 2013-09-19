<?php // sources/application.php

use \Symfony\Component\HttpFoundation\Request;
use \Symfony\Component\HttpFoundation\Response;

$app = require "bootstrap.php";

// GET "/" index 
$app->get('/', function() use ($app) {
    $app['pomm.connection']
        ->executeAnonymousQuery('SELECT true');

    return $app['twig']->render('index.html.twig');
})->bind('index');

return $app;
