<div class="page-header">
    <h2>Empresa</h2>
</div>

<p>
Por favor ingrese los datos para el registro de su empresa
</p>
{{ form("empresa/new", "method":"post") }}
	
	<label>Nombre</label>
	<input class="form-control" type="text" placeholder="Empresa" name="Nombre">

	<label>Nit</label>
	<input type="number" placeholder="Nit" class="form-control" name="Nit">

	<label>Misión</label>
	<textarea class="form-control" placeholder="Misión" name="Mision"></textarea>

	<label>Visión</label>
	<textarea class="form-control" placeholder="Visión" name="Vision" ></textarea>

	<br>
	<center><input type="submit" class="btn btn-default"></center>
{{ end_form() }}