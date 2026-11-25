{{ content() }}
{% if session.get('auth') == null %} 
    
<div class="jumbotron">
    <h1>LDWS</h1>
    <p>MODELO PARA EL DISEÑO DE REDES EN ENTORNOS LAN BASADO EN UN SISTEMA MULTINIVEL</p>
    <p>Universidad Distrital Francisco Jose de Caldas - Facultad de Ingenieria</p>

    <p>{{ link_to('session', 'Iniciar Sesión &raquo;', 'class': 'btn btn-primary btn-large btn-success') }} {{ link_to('register', 'Registrarse &raquo;', 'class': 'btn btn-default btn-large') }}</p>
</div>

<div class="row">
    <div class="col-md-4">
        <h2>Acerca de LDWS</h2>
        <p>Software para el desarrollo de un modelo para el diseño de redes en entornos LAN basado en un sistema multinivel que permitirá disponer de una herramienta de apoyo al enfoque metodológico Top-down para el diseño de redes.</p>
    </div>
    <div class="col-md-4">
        <h2>¿Qué es Top-Down?</h2>
        <p>La metodología top-down está conformada por cuatro partes integrales las cuales son: Identificar las necesidades y metas del cliente, diseño lógico de red, diseño físico de red, pruebas, optimización, y documentación del diseño de red.</p>
    </div>
    <div class="col-md-4">
        <h2>Metodología Multinivel</h2>
        <p>Integra el dimensionamiento físico por pisos (largo, ancho, altura, puestos, salas MDF e IDF), cableado estructurado horizontal UTP Cat 6, segmentación lógica en VLANs (datos, VoIP, servidores, invitados) y generación automática de configuraciones Cisco IOS.</p>
    </div>
</div>

{% else %}
<div class="jumbotron">
    <h1>Bienvenido a LDWS</h1>
    <p class="lead">Sistema de Apoyo al Enfoque Metodológico Top-Down para el Diseño de Redes LAN Multinivel</p>
    <hr>
    <p>
        {{ link_to('empresa', 'Gestionar Empresa &raquo;', 'class': 'btn btn-primary') }}
        {{ link_to('gestionsolicitud', 'Gestionar Solicitudes &raquo;', 'class': 'btn btn-success') }}
        {{ link_to('empresa/newpiso', 'Registrar Pisos &raquo;', 'class': 'btn btn-info') }}
        {{ link_to('grafica', 'Topología Gráfica &raquo;', 'class': 'btn btn-warning') }}
        {{ link_to('gestionequipos', 'Equipos de Red &raquo;', 'class': 'btn btn-default') }}
        {{ link_to('verreportes', 'Reporte Técnico &raquo;', 'class': 'btn btn-danger') }}
    </p>
</div>
{% endif %}
