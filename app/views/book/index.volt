<div class="page-header">
    <h1>
        LIBROS REGISTRADOS
    </h1>
</div>
{{ content() }}

<div class="row">
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Id</th>
            <th>Titulo</th>
            <th>Autor</th>

                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
        {% if page.items is defined %}
            {% for book in page.items %}
                <tr>
                    <td>{{ book.getId() }}</td>
                <td>{{ book.getTitulo() }}</td>
                <td>{{ book.getAutor() }}</td>

                    <td>{{ link_to("book/edit/"~book.getId(), "Edit") }}</td>
                    <td>{{ link_to("book/delete/"~book.getId(), "Delete") }}</td>
                </tr>
            {% endfor %}
        {% endif %}
        </tbody>
    </table>
</div>




<div class="page-header">
    <h1>
        CREAR LIBRO
    </h1>
</div>

{{ content() }}

{{ form("book/create", "method":"post", "autocomplete" : "off", "class" : "form-horizontal") }}

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


<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        {{ submit_button('Guardar', 'class': 'btn btn-default') }}
    </div>
</div>

</form>

