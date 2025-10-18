<%-- 
    Document   : iniciarSesion
    Created on : 03/09/2025, 11:23:55 AM
    Author     : JEJALUOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - Proyecto Telemedicina</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to right, #0066cc, #0099ff);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
        }

        .login-container {
            background: #ffffff;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0px 8px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 420px;
        }

        .login-container h2 {
            text-align: center;
            font-weight: bold;
            color: #0066cc;
            margin-bottom: 25px;
        }

        .form-control, .form-select {
            border-radius: 10px;
            padding: 12px;
            font-size: 15px;
        }

        .btn-login {
            background: #0066cc;
            color: white;
            border-radius: 10px;
            padding: 12px;
            width: 100%;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn-login:hover {
            background: #004c99;
        }

        .extra-links {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .extra-links a {
            color: #0066cc;
            text-decoration: none;
        }

        .extra-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2><i class="bi bi-person-circle"></i> Iniciar Sesión</h2>
        <form action="validarLogin.jsp" method="post">
            
            <!-- Usuario -->
            <div class="mb-3">
                <label for="usuario" class="form-label">Usuario</label>
                <input type="text" id="usuario" name="usuario" class="form-control" placeholder="Ingrese su usuario" required>
            </div>

            <!-- Contraseña -->
            <div class="mb-3">
                <label for="password" class="form-label">Contraseña</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="Ingrese su contraseña" required>
            </div>

            <!-- Tipo de Usuario -->
            <div class="mb-3">
                <label for="tipoUsuario" class="form-label">Tipo de Usuario</label>
                <select id="tipoUsuario" name="tipoUsuario" class="form-select" required>
                    <option value="" selected disabled>Seleccione...</option>
                    <option value="administrador">Administrador</option>
                    <option value="medico">Médico</option>
                    <option value="paciente">Paciente</option>
                    <option value="administrativo">Administrativo</option>
                </select>
            </div>

            <!-- Botón -->
            <button type="submit" class="btn btn-login">Ingresar</button>

            <!-- Links extra -->
            <div class="extra-links mt-3">
                <p>¿Olvidó su contraseña? <a href="#">Recupérela aquí</a></p>
                <p>¿No tiene cuenta? <a href="#">Regístrese</a></p>
            </div>
        </form>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
