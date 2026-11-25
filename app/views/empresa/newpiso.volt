<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous">{{ link_to("gestionsolicitud", "Volver a Solicitudes") }}</li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h2>Diseño Físico de Red <small>Paso 3: Parámetros Arquitectónicos por Nivel</small></h2>
</div>

{{ content() }}

<div class="panel panel-default">
    <div class="panel-body">
        <p class="lead">
            Ingrese las dimensiones físicas y densidad de equipos por cada nivel. Puede registrar múltiples pisos consecutivos.
        </p>

        {{ form("empresa/newpiso", "method":"post", "class":"form-horizontal") }}
            <div class="form-group">
                <label class="col-sm-3 control-label">Largo del Nivel (metros)</label>
                <div class="col-sm-9">
                    <input class="form-control" type="number" step="0.1" placeholder="Ej: 35.0" name="largo" required>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">Ancho del Nivel (metros)</label>
                <div class="col-sm-9">
                    <input type="number" step="0.1" placeholder="Ej: 25.0" class="form-control" name="ancho" required>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">Altura de Planta a Techo (metros)</label>
                <div class="col-sm-9">
                    <input class="form-control" type="number" step="0.1" placeholder="Ej: 3.2" name="alto" required>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">Puestos de Trabajo (Equipos)</label>
                <div class="col-sm-9">
                    <input class="form-control" type="number" placeholder="Ej: 40" name="equipos" required>
                    <p class="help-block">Número de terminales, computadores fijos y teléfonos IP que requieren toma de red.</p>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">Cuarto de Equipos Principal</label>
                <div class="col-sm-9">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="sala"> <strong>Marcar si este piso aloja el MDF (Main Distribution Frame)</strong>
                        </label>
                    </div>
                    <p class="help-block">Normalmente en el Piso 1 o planta baja donde ingresa la acometida del proveedor de servicios.</p>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-3 col-sm-9">
                    {{ submit_button("Agregar Nivel / Piso", "class": "btn btn-primary") }}
                    <a href="{{ url('empresa/newlogico') }}" class="btn btn-success">Continuar al Diseño Lógico &raquo;</a>
                </div>
            </div>
        {{ end_form() }}
    </div>
</div>
