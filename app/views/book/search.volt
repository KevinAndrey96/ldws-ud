<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous">{{ link_to("book/index", "Go Back") }}</li>
            <li class="next">{{ link_to("book/new", "Create ") }}</li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h1>Libros Registrados</h1>
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

<div class="row">
    <div class="col-sm-1">
        <p class="pagination" style="line-height: 1.42857;padding: 6px 12px;">
            {{ page.current~"/"~page.total_pages }}
        </p>
    </div>
    <div class="col-sm-11">
        <nav>
            <ul class="pagination">
                <li>{{ link_to("book/search", "First") }}</li>
                <li>{{ link_to("book/search?page="~page.before, "Previous") }}</li>
                <li>{{ link_to("book/search?page="~page.next, "Next") }}</li>
                <li>{{ link_to("book/search?page="~page.last, "Last") }}</li>
            </ul>
        </nav>
    </div>
</div>
