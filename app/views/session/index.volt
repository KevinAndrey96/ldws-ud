
{{ content() }}

<div class="row">

    <div class="col-md-6">
        <div class="page-header">
            <h2>Iniciar Sesión</h2>
        </div>
        {{ form('session/start', 'role': 'form') }}
            <fieldset>
                <div class="form-group">
                    <label for="email">Email</label>
                    <div class="controls">
                        {{ text_field('email', 'class': "form-control") }}
                    </div>
                </div>
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <div class="controls">
                        {{ password_field('password', 'class': "form-control") }}
                    </div>
                </div>
                <div class="form-group">
                    {{ submit_button('Ingresar', 'class': 'btn btn-primary btn-large') }}
                </div>
            </fieldset>
        </form>
    </div>

    <div class="col-md-6">

        <div class="page-header">
            <h2>¿Aún no tienes una cuenta?</h2>
        </div>

        <p>Crea una cuenta para tener acceso a nuestra plataforma:</p>
        <ul>
            <li>Registra tu empresa y solicita asesoramiento</li>
            <li>Visualiza PDF's sobre la organización ideal de tu empresa</li>
            <li>Observa gráficas de distribución de componentes e infraestructura</li>
        </ul>

        <div class="clearfix center">
            {{ link_to('Registro', 'Sign Up', 'class': 'btn btn-primary btn-large btn-success') }}
        </div>
    </div>

</div>
