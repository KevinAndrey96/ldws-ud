<div class="page-header">
    <h2 align="center">CREAR SOLICITUD</h2>
</div>

<p>
Bienvenido al módulo de solicitudes, aquí podrá iniciar el proceso de solicitud para su empresa
</p>
{{ form("gestionsolicitud/new", "method":"post") }}
	<label>Empresa</label><br>
	{{ select("empresa", empresa, "using":["IdEmpresa", "Nombre"]) }}
	<br>

	<label>Descripción</label>
	<textarea class="form-control" placeholder="Descripción" name="desc"></textarea>

	<label>Objetivos</label>
	<textarea class="form-control" placeholder="Objetivos" name="obj" ></textarea>

	<label>Observaciones</label>
	<textarea class="form-control" placeholder="Observaciones" name="obs"></textarea>

	<label>Servicios necesarios</label>
	<select class="form-control" placeholder="Servicios Necesarios" name="serv" >
		<option>test</option>
	</select>
	
	<br>
	<center>{{ submit_button("Guardar", "class": "btn btn-success") }}</center>
{{ end_form() }}