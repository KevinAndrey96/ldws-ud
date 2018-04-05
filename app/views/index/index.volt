
{{ content() }}
{% if session.get('auth') == null %} 
    
<div class="jumbotron">
    <h1>LDWS</h1>
    <p>MODELO PARA EL DISEÑO DE REDES EN ENTORNOS LAN BASADO EN UN SISTEMA MULTINIVEL</p>

    <p>{{ link_to('register', 'Regístrate &raquo;', 'class': 'btn btn-primary btn-large btn-success') }}</p>

</div>

<div class="row">
    <div class="col-md-4">
        <h2>Acerca de LDWS</h2>
        <p>Software para el desarrollo de un modelo para el diseño de redes en entornos LAN basado en un sistema multinivel que permitirá disponer de una herramienta de apoyo al enfoque metodológico Top-down para el diseño de redes.. </p>
    </div>
    <div class="col-md-4">
        <h2>¿Qué es Top-Down?</h2>
        <p>La metodología top-down está conformada por cuatro partes integrales las cuales son: Identificar las necesidades y metas del cliente, diseño lógico de red, diseño físico de red, pruebas, optimización, y documentación del diseño de red.
</p>
    </div>
    <div class="col-md-4">
        <h2>Problematica</h2>
        <p>¿El desarrollo de un modelo para el diseño de redes en entornos LAN basado en un sistema multinivel permitirá apoyar el proceso metodológico de diseño e implementación de redes LAN? </p>
    </div>
</div>

{% else %}
<div class="jumbotron">
    <h1>Bienvenido</h1>
<hr>
    <p>{{ link_to('empresa', 'Registrar empresa &raquo;', 'class': 'btn btn-warning btn-large btn-success') }}</p>
    <p>{{ link_to('gestionsolicitud', 'Crear solicitud &raquo;', 'class': 'btn btn-warning btn-large btn-success') }}</p>

</div>
{% endif %}

