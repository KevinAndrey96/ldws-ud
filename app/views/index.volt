<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        {{ get_title() }}
        {{ stylesheet_link('css/bootstrap.min.css') }}
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Software para el desarrollo de un modelo para el diseño de redes en entornos LAN basado en un sistema multinivel que permitirá disponer de una herramienta de apoyo al enfoque metodológico Top-down para el diseño de redes.">
        <meta name="author" content="LDWS-UD">
    </head>
    <body>
        {{ content() }}
        {{ javascript_include('js/jquery.min.js') }}
        {{ javascript_include('js/bootstrap.min.js') }}
        {{ javascript_include('js/utils.js') }}
    </body>
</html>
