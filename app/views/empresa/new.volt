<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous">{{ link_to("empresa", "Volver al Listado") }}</li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h2>Registrar Empresa <small>Paso 1: Identificación de Metas de Negocio</small></h2>
</div>

{{ content() }}

<div class="panel panel-default">
    <div class="panel-body">
        <p class="lead">
            Ingrese los datos organizacionales de la empresa para contextualizar el diseño de red LAN.
        </p>

        {{ form("empresa/new", "method":"post", "class":"form-horizontal") }}
            <div class="form-group">
                <label class="col-sm-2 control-label">Nombre de Empresa</label>
                <div class="col-sm-10">
                    <input class="form-control" type="text" placeholder="Ej: TechCorp Soluciones SAS" name="Nombre" required>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">NIT / Identificación Fiscal</label>
                <div class="col-sm-10">
                    <input type="text" placeholder="Ej: 900.123.456-7" class="form-control" name="Nit" required>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">Misión Organizacional</label>
                <div class="col-sm-10">
                    <textarea class="form-control" rows="3" placeholder="Misión de la empresa y objetivos comerciales" name="Mision" required></textarea>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">Visión Organizacional</label>
                <div class="col-sm-10">
                    <textarea class="form-control" rows="3" placeholder="Visión de crecimiento tecnológico a mediano y largo plazo" name="Vision" required></textarea>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    {{ submit_button("Guardar y Continuar a Solicitud &raquo;", "class": "btn btn-success") }}
                    {{ link_to("empresa", "Cancelar", "class": "btn btn-default") }}
                </div>
            </div>
        {{ end_form() }}
    </div>
</div>
