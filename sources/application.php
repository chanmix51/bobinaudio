<?php // sources/application.php

use \Symfony\Component\HttpFoundation\Request;
use \Symfony\Component\HttpFoundation\Response;

$app = require "bootstrap.php";
$app->mount('/', new Controller\MainController());

$app->error(function(Exception $e, $code) use ($app) {

    if ($app['debug'])
    {
        //return;
    }

    switch($code)
    {
    case "404": 
        $error = array("fr" => "Ressource introuvable.", "en" => "Page not found.");
        $message = array("fr" => "La ressource que vous avez demandée ne peut être trouvée.", "en" => "The page you asked for can not be found.");
        break;
    case "500":
    default:
        $error = array("fr" => "Erreur serveur.", "en" => "Server error.");
        $message = array("fr" => "Une erreur interne a eu lieu. Nous ne pouvons donner suite à votre demande.", "en" => "An internal error occured, we can not fullfil your request, sorry.");
    }

    $culture = $app['session']->get('culture', 'fr');

    return new Response($app['twig']->render('error.html.twig', array('message' => $message[$culture], 'error' => $error[$culture])), $code);
});
return $app;
