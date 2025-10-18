<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Iniciar Sesión - Policlínico Wiener Sistem</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary: #1a7cc9;
                --secondary: #2c3e50;
                --accent: #2ecc71;
                --light: #f8f9fa;
                --dark: #343a40;
                --danger: #e74c3c;
            }
            
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: 'Open Sans', sans-serif;
                color: #333;
                line-height: 1.6;
                background-color: #f0f7fd;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }
            
            h1, h2, h3, h4, h5, h6 {
                font-family: 'Montserrat', sans-serif;
                font-weight: 700;
                color: var(--secondary);
            }
            
            /* Navbar Styles */
            nav {
                background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
                padding: 0.8rem 1rem;
                position: sticky;
                top: 0;
                z-index: 1000;
            }
            
            .navbar-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                max-width: 1200px;
                margin: 0 auto;
            }
            
            .navbar-brand {
                display: flex;
                align-items: center;
                color: white !important;
                text-decoration: none;
                font-size: 1.5rem;
                font-weight: 700;
            }
            
            .navbar-brand i {
                font-size: 1.8rem;
                margin-right: 0.5rem;
                color: #fff;
            }
            
            .navbar-toggler {
                display: none;
                background: none;
                border: none;
                color: white;
                font-size: 1.5rem;
                cursor: pointer;
            }
            
            .navbar-menu {
                display: flex;
            }
            
            .navbar-nav {
                display: flex;
                list-style: none;
                align-items: center;
            }
            
            .nav-item {
                margin: 0 0.5rem;
            }
            
            .nav-link {
                color: rgba(255, 255, 255, 0.85);
                text-decoration: none;
                padding: 0.5rem 0.8rem;
                border-radius: 4px;
                transition: all 0.3s;
                font-weight: 500;
            }
            
            .nav-link:hover, .nav-link.active {
                color: white;
                background-color: rgba(255, 255, 255, 0.1);
            }
            
            .btn-login {
                background-color: var(--accent);
                color: white !important;
                padding: 0.5rem 1.2rem;
                border-radius: 30px;
                font-weight: 600;
            }
            
            .btn-login:hover {
                background-color: #27ae60;
                transform: translateY(-2px);
            }
            
            /* Login Section */
            .login-section {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem 1rem;
            }
            
            .login-container {
                display: grid;
                grid-template-columns: 1fr 1fr;
                max-width: 1000px;
                width: 100%;
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            }
            
            .login-image {
                background: linear-gradient(rgba(26, 124, 201, 0.8), rgba(44, 62, 80, 0.8)), url('https://images.unsplash.com/photo-1579684385127-1ef15d508118?auto=format&fit=crop&w=600&q=80');
                background-size: cover;
                background-position: center;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
                color: white;
            }
            
            .login-image-content {
                text-align: center;
                max-width: 400px;
            }
            
            .login-image-content h2 {
                color: white;
                margin-bottom: 1.5rem;
                font-size: 2rem;
            }
            
            .login-image-content p {
                opacity: 0.9;
                line-height: 1.6;
            }
            
            .login-form-container {
                padding: 3rem 2rem;
            }
            
            .login-header {
                text-align: center;
                margin-bottom: 2rem;
            }
            
            .login-header h2 {
                font-size: 2rem;
                margin-bottom: 0.5rem;
                color: var(--primary);
            }
            
            .login-header p {
                color: #666;
            }
            
            .form-group {
                margin-bottom: 1.5rem;
            }
            
            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 600;
                color: var(--secondary);
            }
            
            .form-control {
                width: 100%;
                padding: 0.8rem 1rem;
                border: 2px solid #ddd;
                border-radius: 5px;
                font-family: 'Open Sans', sans-serif;
                font-size: 1rem;
                transition: border-color 0.3s;
            }
            
            .form-control:focus {
                outline: none;
                border-color: var(--primary);
            }
            
            .password-container {
                position: relative;
            }
            
            .toggle-password {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                color: #666;
                cursor: pointer;
            }
            
            .form-options {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
            }
            
            .remember-me {
                display: flex;
                align-items: center;
            }
            
            .remember-me input {
                margin-right: 0.5rem;
            }
            
            .forgot-password {
                color: var(--primary);
                text-decoration: none;
                font-weight: 600;
            }
            
            .forgot-password:hover {
                text-decoration: underline;
            }
            
            .btn {
                padding: 0.8rem 1.8rem;
                border-radius: 30px;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s;
                display: inline-block;
                border: none;
                cursor: pointer;
                font-family: 'Montserrat', sans-serif;
                font-size: 1rem;
                text-align: center;
            }
            
            .btn-primary {
                background-color: var(--accent);
                color: white;
                width: 100%;
            }
            
            .btn-primary:hover {
                background-color: #27ae60;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }
            
            .login-divider {
                text-align: center;
                margin: 1.5rem 0;
                position: relative;
            }
            
            .login-divider::before {
                content: '';
                position: absolute;
                top: 50%;
                left: 0;
                right: 0;
                height: 1px;
                background: #ddd;
                z-index: 1;
            }
            
            .login-divider span {
                background: white;
                padding: 0 1rem;
                position: relative;
                z-index: 2;
                color: #666;
            }
            
            .social-login {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
                margin-bottom: 1.5rem;
            }
            
            .btn-social {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                padding: 0.7rem 1rem;
                border: 2px solid #ddd;
                background: white;
                border-radius: 30px;
                color: #333;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s;
            }
            
            .btn-social:hover {
                border-color: var(--primary);
                color: var(--primary);
            }
            
            .register-link {
                text-align: center;
                margin-top: 1.5rem;
                color: #666;
            }
            
            .register-link a {
                color: var(--primary);
                text-decoration: none;
                font-weight: 600;
            }
            
            .register-link a:hover {
                text-decoration: underline;
            }
            
            /* Footer */
            footer {
                background-color: var(--secondary);
                color: white;
                padding: 2rem 1rem;
                margin-top: auto;
            }
            
            .footer-content {
                max-width: 1200px;
                margin: 0 auto;
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 2rem;
            }
            
            .footer-logo {
                margin-bottom: 1rem;
                font-size: 1.5rem;
                font-weight: 700;
            }
            
            .footer-links h5 {
                color: white;
                margin-bottom: 1rem;
                font-size: 1.1rem;
            }
            
            .footer-links ul {
                list-style: none;
            }
            
            .footer-links li {
                margin-bottom: 0.5rem;
            }
            
            .footer-links a {
                color: rgba(255, 255, 255, 0.7);
                text-decoration: none;
                transition: color 0.3s;
            }
            
            .footer-links a:hover {
                color: white;
            }
            
            .footer-contact li {
                display: flex;
                align-items: center;
                margin-bottom: 1rem;
            }
            
            .footer-contact i {
                margin-right: 0.5rem;
                color: var(--accent);
            }
            
            .footer-bottom {
                text-align: center;
                margin-top: 2rem;
                padding-top: 1.5rem;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
            }
            
            /* Responsive Design */
            @media (max-width: 768px) {
                .navbar-toggler {
                    display: block;
                }
                
                .navbar-menu {
                    display: none;
                    position: absolute;
                    top: 100%;
                    left: 0;
                    width: 100%;
                    background-color: var(--secondary);
                    flex-direction: column;
                    padding: 1rem;
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                }
                
                .navbar-menu.active {
                    display: flex;
                }
                
                .navbar-nav {
                    flex-direction: column;
                    width: 100%;
                }
                
                .nav-item {
                    width: 100%;
                    margin: 0.3rem 0;
                }
                
                .nav-link {
                    display: block;
                    padding: 0.8rem;
                }
                
                .login-container {
                    grid-template-columns: 1fr;
                }
                
                .login-image {
                    display: none;
                }
                
                .social-login {
                    grid-template-columns: 1fr;
                }
                
                .form-options {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 1rem;
                }
            }
        </style>
    </head>
    <body>
        <nav>
            <div class="navbar-container">
                <a class="navbar-brand" href="index.html">
                    <i class="bi bi-heart-pulse"></i> TELEMEDICINA
                </a>
                <button class="navbar-toggler"><i class="bi bi-list"></i></button>
                <div class="navbar-menu">
                    <ul class="navbar-nav">
                        <li class="nav-item"><a class="nav-link" href="../web_principal/index.html">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="../web_principal/nosotros.html">Nosotros</a></li>
                        <li class="nav-item"><a class="nav-link" href="../web_principal/servicios.html">Servicios</a></li>
                        <li class="nav-item"><a class="nav-link" href="../web_principal/medicos.html">Médicos</a></li>
                        <li class="nav-item"><a class="nav-link" href="../web_principal/registro.jsp">Registro</a></li>
                        <li class="nav-item"><a class="nav-link" href="../web_principal/contacto.jsp">Contacto</a></li>
                        <li class="nav-item"><a class="nav-link btn-login active" href="../logeo/iniciarSesion.jsp">Iniciar Sesión</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        
        <!-- Login Section -->
        <section class="login-section">
            <div class="login-container">
                <div class="login-image">
                    <div class="login-image-content">
                        <h2>Bienvenido de nuevo</h2>
                        <p>Accede a tu cuenta para gestionar tus citas médicas, ver tu historial y contactar con nuestros especialistas.</p>
                    </div>
                </div>
                
                <div class="login-form-container">
                    <div class="login-header">
                        <h2>Iniciar Sesión</h2>
                        <p>Ingresa a tu cuenta para continuar</p>
                    </div>
                    
                    <form action="<%= request.getContextPath() %>/loginServlet" method="POST">
                        <!-- Usuario -->
                        <div class="form-group mb-3">
                            <label for="username">Usuario o Correo Electrónico</label>
                            <input type="text" id="username" name="username" class="form-control" required placeholder="Ingresa tu usuario o email">
                        </div>

                        <!-- Contraseña -->
                        <div class="form-group mb-3">
                            <label for="password">Contraseña</label>
                            <div class="input-group">
                                <input type="password" id="password" name="password" class="form-control" required placeholder="Ingresa tu contraseña">
                                <button type="button" class="btn btn-outline-secondary" id="togglePassword"><i class="bi bi-eye"></i>
                                    
                                </button>
                            </div>
                        </div>

                        <!-- Tipo de Usuario -->
                        <div class="form-group mb-3">
                            <label for="tipoUsuario">Tipo de Usuario</label>
                            <select id="tipoUsuario" name="tipoUsuario" class="form-control" required>
                                <option value="" selected disabled>Seleccione...</option>
                                <option value="medico">Médico</option>
                                <option value="paciente">Paciente</option>
                                <option value="administrativo">Administrativo</option>
                            </select>
                        </div>

                        <!-- Opciones -->
                        <div class="form-options d-flex justify-content-between align-items-center mb-3">
                            <div class="form-check">
                                <input type="checkbox" id="remember" name="remember" class="form-check-input">
                                <label for="remember" class="form-check-label">Recordarme</label>
                            </div>
                            <a href="recuperar-password.html" class="forgot-password text-primary">¿Olvidaste tu contraseña?</a>
                        </div>

                        <!-- Botón -->
                        <button type="submit" class="btn btn-primary w-100">Iniciar Sesión</button>
                    </form>

                    
                    <div class="register-link">
                        <p>¿No tienes una cuenta? <a href="../web_principal/registro.html">Regístrate aquí</a></p>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Footer -->
        <footer>
            <div class="footer-content">
                <div class="footer-about">
                    <div class="footer-logo"><i class="bi bi-heart-pulse"></i> POLICLÍNICO WIENER SISTEM</div>
                    <p>Comprometidos con tu salud y bienestar, ofreciendo servicios médicos de calidad con calidez humana.</p>
                </div>
                
                <div class="footer-links">
                    <h5>Servicios</h5>
                    <ul>
                        <li><a href="../web_principal/servicios.html">Consultas</a></li>
                        <li><a href="../web_principal/servicios.html">Exámenes</a></li>
                        <li><a href="../web_principal/servicios.html">Urgencias</a></li>
                        <li><a href="../web_principal/servicios.html">Vacunas</a></li>
                    </ul>
                </div>
                
                <div class="footer-links">
                    <h5>Información</h5>
                    <ul>
                        <li><a href="../web_principal/nosotros.html">Nosotros</a></li>
                        <li><a href="../web_principal/medicos.html">Médicos</a></li>
                        <li><a href="../web_principal/servicios.html">Precios</a></li>
                        <li><a href="https://www.facebook.com/jeferson.jaimes.2025">Facebook</a></li>
                    </ul>
                </div>
                
                <div class="footer-contact">
                    <h5>Contacto</h5>
                    <ul>
                        <li><i class="bi bi-geo-alt"></i> Av. Los Pinos 711, Independencia</li>
                        <li><i class="bi bi-telephone"></i> (01) 234-5678</li>
                        <li><i class="bi bi-envelope"></i> info@policlinico.com</li>
                        <li><i class="bi bi-clock"></i> Lun-Vie: 8am - 8pm</li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>© 2025 Policlínico Wiener Sistem. Todos los derechos reservados.</p>
                <p><a href="../legal/terminos.jsp">Términos y condiciones</a> | <a href="../legal/privacidad.jsp">Política de privacidad</a></p>
            </div>
        </footer>
        
        <script>
            // Toggle menu for mobile
            document.querySelector('.navbar-toggler').addEventListener('click', function() {
                const navbarMenu = document.querySelector('.navbar-menu');
                navbarMenu.classList.toggle('active');
                
                // Cambiar ícono
                const icon = this.querySelector('i');
                if (navbarMenu.classList.contains('active')) {
                    icon.classList.remove('bi-list');
                    icon.classList.add('bi-x-lg');
                } else {
                    icon.classList.remove('bi-x-lg');
                    icon.classList.add('bi-list');
                }
            });
            
            // Cerrar menú al hacer clic en un enlace
            document.querySelectorAll('.nav-link').forEach(link => {
                link.addEventListener('click', function() {
                    const navbarMenu = document.querySelector('.navbar-menu');
                    navbarMenu.classList.remove('active');
                    const icon = document.querySelector('.navbar-toggler i');
                    icon.classList.remove('bi-x-lg');
                    icon.classList.add('bi-list');
                });
            });
            
            // Toggle password visibility
            document.getElementById('togglePassword').addEventListener('click', function() {
                const passwordInput = document.getElementById('password');
                const icon = this.querySelector('i');
                
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                } else {
                    passwordInput.type = 'password';
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                }
            });
            
            // Validación básica del formulario
            document.querySelector('form').addEventListener('submit', function(e) {
                const username = document.getElementById('username').value.trim();
                const password = document.getElementById('password').value.trim();
                
                if (!username || !password) {
                    e.preventDefault();
                    alert('Por favor, complete todos los campos obligatorios.');
                }
            });
        </script>
    </body>
</html>