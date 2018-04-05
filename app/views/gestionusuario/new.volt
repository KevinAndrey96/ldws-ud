<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous">{{ link_to("book", "Go Back") }}</li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h1 align="center">
        Crear Usuario
    </h1>
</div>

{{ content() }}

{{ form("book/create", "method":"post", "autocomplete" : "off", "class" : "form-horizontal") }}

<div class="form-group">
    <label for="fieldId" class="col-sm-2 control-label">Cedula</label>
    <div class="col-sm-10">
        {{ text_field("id", "type" : "numeric", "class" : "form-control", "id" : "fieldId") }}
    </div>
</div>

<div class="form-group">
    <label for="fieldTitulo" class="col-sm-2 control-label">Nombre</label>
    <div class="col-sm-10">
        {{ text_field("titulo", "size" : 30, "class" : "form-control", "id" : "fieldTitulo") }}
    </div>
</div>

<div class="form-group">
    <label for="fieldAutor" class="col-sm-2 control-label">Apellido</label>
    <div class="col-sm-10">
        {{ text_field("autor", "size" : 30, "class" : "form-control", "id" : "fieldAutor") }}
    </div>
</div>

<div class="form-group">
    <label for="fieldAutor" class="col-sm-2 control-label">Usuario</label>
    <div class="col-sm-10">
        {{ text_field("autor", "size" : 30, "class" : "form-control", "id" : "fieldAutor") }}
    </div>
</div>

<div class="form-group">
    <label for="fieldAutor" class="col-sm-2 control-label">Clave</label>
    <div class="col-sm-10">
        {{ text_field("autor", "size" : 30, "class" : "form-control", "id" : "fieldAutor") }}
    </div>
</div>

<div class="form-group">
    <label for="fieldAutor" class="col-sm-2 control-label">Correo</label>
    <div class="col-sm-10">
        {{ text_field("autor", "size" : 30, "class" : "form-control", "id" : "fieldAutor") }}
    </div>
</div>

<div class="form-group">
    <label for="fieldAutor" class="col-sm-2 control-label">Telefono</label>
    <div class="col-sm-10">
        {{ text_field("autor", "size" : 30, "class" : "form-control", "id" : "fieldAutor") }}
    </div>
</div>

<div class="form-group">
    <label for="fieldAutor" class="col-sm-2 control-label">Rol</label>
    <div class="col-sm-10">
        {{ text_field("autor", "size" : 30, "class" : "form-control", "id" : "fieldAutor") }}
    </div>
</div>

<div align="center"class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        {{ submit_button('Guardar', 'class': 'btn btn-default') }}
    </div>
</div>

</form>