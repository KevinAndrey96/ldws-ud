<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous">{{ link_to("book", "Go Back") }}</li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h1>
        Edit book
    </h1>
</div>

{{ content() }}

{{ form("book/save", "method":"post", "autocomplete" : "off", "class" : "form-horizontal") }}

<div class="form-group">
    <label for="fieldId" class="col-sm-2 control-label">Id</label>
    <div class="col-sm-10">
        {{ text_field("id", "type" : "numeric", "class" : "form-control", "id" : "fieldId") }}
    </div>
</div>

<div class="form-group">
    <label for="fieldTitulo" class="col-sm-2 control-label">Titulo</label>
    <div class="col-sm-10">
        {{ text_field("titulo", "size" : 30, "class" : "form-control", "id" : "fieldTitulo") }}
    </div>
</div>

<div class="form-group">
    <label for="fieldAutor" class="col-sm-2 control-label">Autor</label>
    <div class="col-sm-10">
        {{ text_field("autor", "size" : 30, "class" : "form-control", "id" : "fieldAutor") }}
    </div>
</div>


{{ hidden_field("id") }}

<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        {{ submit_button('Send', 'class': 'btn btn-default') }}
    </div>
</div>

</form>
