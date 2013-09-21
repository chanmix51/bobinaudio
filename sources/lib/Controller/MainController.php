<?php
namespace Controller;

use Silex\Application;
use Silex\ControllerProviderInterface;

use \Symfony\Component\HttpFoundation\Request;
use \Symfony\Component\HttpFoundation\Response;

class MainController implements ControllerProviderInterface
{
    protected $app;

    public function connect(Application $app)
    {
        $this->app = $app;
        $controller_collection = $app['controllers_factory'];
        $controller_collection->get('/', array($this, 'index'))->bind('index');
        $controller_collection->get('/about', array($this, 'about'))->bind('about');
        $controller_collection->get('/culture/{culture}', array($this, 'culture'))->bind('culture');

        return $controller_collection;
    }

    public function culture($culture)
    {
        $referrer = $this->app['request']->headers->get('referrer');

        if (array_search($culture, array('en', 'fr')) === false)
        {
            $culture = 'fr';
        }

        $this->app['session']->set('culture', $culture);

        return $this->app->redirect($referrer);
    }

    public function index()
    {
        return $this->app['twig']->render(sprintf("%s/index.html.twig", $this->app['session']->get('culture', 'fr')));
    }

    public function about()
    {
        return $this->app['twig']->render(sprintf("%s/about.html.twig", $this->app['session']->get('culture', 'fr')));
    }
}
