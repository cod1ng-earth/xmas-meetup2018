<?php
namespace App\Controller;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class EnvController
{
    /** @Route("/", name="home") */
    public function number(string $envCBXmas = 'floo')
    {
        return new Response("env: $envCBXmas");
    }
}