<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous">{{ link_to("gestionusuario", "Volver al Listado") }}</li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h2>Registrar Nuevo Usuario</h2>
</div>

{{ content() }}

<div class="panel panel-default">
    <div class="panel-body">
        {{ form("gestionusuario/new", "method":"post", "class":"form-horizontal") }}

            <div class="form-group">
                <label for="fieldName" class="col-sm-2 control-label">Nombre Completo</label>
                <div class="col-sm-10">
                    <input type="text" name="name" id="fieldName" class="form-control" placeholder="Ej: Kevin Andrey Martinez" required>
                </div>
            </div>

            <div class="form-group">
                <label for="fieldUsername" class="col-sm-2 control-label">Nombre de Usuario</label>
                <div class="col-sm-10">
                    <input type="text" name="username" id="fieldUsername" class="form-control" placeholder="Ej: kmartinez" required>
                </div>
            </div>

            <div class="form-group">
                <label for="fieldEmail" class="col-sm-2 control-label">Correo Electrónico</label>
                <div class="col-sm-10">
                    <input type="email" name="email" id="fieldEmail" class="form-control" placeholder="Ej: kmartinez@udistrital.edu.co" required>
                </div>
            </div>

            <div class="form-group">
                <label for="fieldPassword" class="col-sm-2 control-label">Contraseña</label>
                <div class="col-sm-10">
                    <input type="password" name="password" id="fieldPassword" class="form-control" placeholder="Contraseña segura" required>
                </div>
            </div>

            <div class="form-group">
                <label for="fieldRole" class="col-sm-2 control-label">Rol del Sistema</label>
                <div class="col-sm-10">
                    <select name="role" id="fieldRole" class="form-control">
                        <option value="Investigador">Investigador / Diseñador de Red</option>
                        <option value="Admin">Administrador General</option>
                        <option value="Auditor">Auditor de Calidad</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    {{ submit_button("Guardar Usuario", "class": "btn btn-success") }}
                    {{ link_to("gestionusuario", "Cancelar", "class": "btn btn-default") }}
                </div>
            </div>

        {{ end_form() }}
    </div>
</div>
