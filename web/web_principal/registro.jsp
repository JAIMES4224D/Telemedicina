<%-- 
    Document   : registro
    Created on : 03/09/2025, 05:26:30 PM
    Author     : JEJALUOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro - Policlínico Wiener Sistem</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
        <style>
            :root{
                --primary: #1a7cc9;
                --secondary: #2c3e50;
                --accent: #2ecc71;
                --light: #f8f9fa;
                --dark: #343a40;
                --danger: #e74c3c;
            }
            *{
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body{
                font-family: 'Open Sans', sans-serif;
                color: #333;
                line-height: 1.6;
                background-color: #f0f7fd;
            }
            h1, h2, h3, h4, h5, h6{
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
            
            /* Hero Section */
            .hero {
                background: linear-gradient(rgba(26, 124, 201, 0.8), rgba(44, 62, 80, 0.8)), url('https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?auto=format&fit=crop&w=1480&q=80');
                background-size: cover;
                background-position: center;
                color: white;
                padding: 5rem 1rem;
                text-align: center;
            }

            .hero-content {
                max-width: 800px;
                margin: 0 auto;
            }

            .hero h1 {
                font-size: 2.5rem;
                margin-bottom: 1.5rem;
                color: white;
            }

            .hero p {
                font-size: 1.2rem;
                margin-bottom: 2rem;
                opacity: 0.9;
            }
            
            /* Registration Section */
            .registration {
                padding: 5rem 1rem;
                background-color: white;
            }
            
            .section-title {
                text-align: center;
                margin-bottom: 3rem;
            }

            .section-title h2 {
                font-size: 2.2rem;
                margin-bottom: 1rem;
                position: relative;
                display: inline-block;
            }

            .section-title h2:after {
                content: '';
                position: absolute;
                width: 60px;
                height: 3px;
                background-color: var(--primary);
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
            }
            
            .registration-container {
                max-width: 1000px;
                margin: 0 auto;
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 3rem;
            }
            
            .benefits {
                background: var(--light);
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            }
            
            .benefits h3 {
                color: var(--primary);
                margin-bottom: 1.5rem;
                text-align: center;
            }
            
            .benefit-item {
                display: flex;
                align-items: flex-start;
                margin-bottom: 1.5rem;
            }
            
            .benefit-icon {
                color: var(--accent);
                font-size: 1.5rem;
                margin-right: 1rem;
                min-width: 30px;
            }
            
            .benefit-content h4 {
                margin-bottom: 0.3rem;
                color: var(--secondary);
            }
            
            .registration-form {
                background: var(--light);
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
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
            
            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
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
            
            .login-redirect {
                text-align: center;
                margin-top: 1.5rem;
                color: #666;
            }
            
            .login-redirect a {
                color: var(--primary);
                text-decoration: none;
                font-weight: 600;
            }
            
            .login-redirect a:hover {
                text-decoration: underline;
            }
            
            /* Footer */
            footer {
                background-color: var(--secondary);
                color: white;
                padding: 3rem 1rem;
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
                margin-top: 3rem;
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

                .hero {
                    padding: 4rem 1rem;
                }

                .hero h1 {
                    font-size: 2rem;
                }
                
                .registration-container {
                    grid-template-columns: 1fr;
                    gap: 2rem;
                }
                
                .form-row {
                    grid-template-columns: 1fr;
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
                  <li class="nav-item"><a class="nav-link" href="index.html">Inicio</a></li>
                  <li class="nav-item"><a class="nav-link" href="nosotros.html">Nosotros</a></li>
                  <li class="nav-item"><a class="nav-link" href="servicios.html">Servicios</a></li>
                  <li class="nav-item"><a class="nav-link" href="medicos.html">Médicos</a></li>
                  <li class="nav-item"><a class="nav-link active" href="registro.html">Registro</a></li>
                  <li class="nav-item"><a class="nav-link" href="contacto.jsp">Contacto</a></li>
                  <li class="nav-item"><a class="nav-link btn-login" href="../logeo/iniciarSesion.jsp">Iniciar Sesión</a></li>
                </ul>
              </div>
            </div>
        </nav>
        
        <!-- Hero Section -->
        <section class="hero">
            <div class="hero-content">
                <h1>Registro de Pacientes</h1>
                <p>Únete a nuestra familia de pacientes y accede a todos nuestros servicios médicos con facilidad y comodidad.</p>
            </div>
        </section>
        
        <!-- Registration Section -->
        <section class="registration">
            <div class="section-title">
                <h2>Crear Cuenta</h2>
                <p>Completa tus datos para registrarte en nuestro sistema</p>
            </div>
            
            <div class="registration-container">
                <div class="benefits">
                    <h3>Beneficios de Registrarse</h3>
                    
                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <i class="bi bi-calendar-check"></i>
                        </div>
                        <div class="benefit-content">
                            <h4>Agenda Citas Online</h4>
                            <p>Reserva tus consultas médicas en cualquier momento desde nuestra plataforma.</p>
                        </div>
                    </div>
                    
                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <i class="bi bi-file-medical"></i>
                        </div>
                        <div class="benefit-content">
                            <h4>Historial Médico Digital</h4>
                            <p>Accede a tu historial médico completo desde cualquier dispositivo.</p>
                        </div>
                    </div>
                    
                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <i class="bi bi-bell"></i>
                        </div>
                        <div class="benefit-content">
                            <h4>Recordatorios Automáticos</h4>
                            <p>Recibe notificaciones de tus próximas citas y exámenes.</p>
                        </div>
                    </div>
                    
                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <i class="bi bi-chat-dots"></i>
                        </div>
                        <div class="benefit-content">
                            <h4>Comunicación Directa</h4>
                            <p>Contacta directamente con nuestros especialistas para consultas rápidas.</p>
                        </div>
                    </div>
                    
                    <div class="benefit-item">
                        <div class="benefit-icon">
                            <i class="bi bi-graph-up"></i>
                        </div>
                        <div class="benefit-content">
                            <h4>Seguimiento de Salud</h4>
                            <p>Monitorea tu estado de salud y evolución médica a lo largo del tiempo.</p>
                        </div>
                    </div>
                </div>
                
                <div class="registration-form">
                    <form action="${pageContext.request.contextPath}/registroServlet" method="POST" enctype="multipart/form-data">
                    <!--<form action="prueba.jsp" method="POST">-->
                        <div class="form-row">
                            <div class="form-group">
                                <label for="nombres">Nombres *</label>
                                <input type="text" id="nombres" name="nombres" class="form-control" required maxlength="100">
                            </div>

                            <div class="form-group">
                                <label for="apellidos">Apellidos *</label>
                                <input type="text" id="apellidos" name="apellidos" class="form-control" required maxlength="100">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="fechaNacimiento">Fecha de Nacimiento *</label>
                            <input type="date" id="fechaNacimiento" name="fechaNacimiento" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label for="genero">Género *</label>
                            <select id="genero" name="genero" class="form-control" required>
                                <option value="">Seleccionar</option>
                                <option value="M">Masculino</option>
                                <option value="F">Femenino</option>
                                <option value="O">Otro</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="tipoDocumento">Tipo de Documento *</label>
                            <select id="tipoDocumento" name="tipoDocumento" class="form-control" required>
                                <option value="">Seleccionar</option>
                                <option value="DNI">DNI</option>
                                <option value="CE">Carnet de Extranjería</option>
                                <option value="PASAPORTE">Pasaporte</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="numeroDocumento">Número de Documento *</label>
                            <input type="text" id="numeroDocumento" name="numeroDocumento" class="form-control" required maxlength="20">
                        </div>

                        <div class="form-group">
                            <label for="fotografia">Fotografía</label>
                            <input type="file" id="fotografia" name="fotografia" class="form-control" accept="image/*">
                        </div>

                        <div class="form-group">
                            <label for="telefono">Teléfono / Celular</label>
                            <input type="tel" id="telefono" name="telefono" class="form-control" maxlength="20">
                        </div>

                        <div class="form-group">
                            <label for="correo">Correo Electrónico</label>
                            <input type="email" id="correo" name="correo" class="form-control" maxlength="100">
                        </div>

                        <div class="form-group">
                            <label for="direccion">Dirección</label>
                            <input type="text" id="direccion" name="direccion" class="form-control" maxlength="255">
                        </div>

                        <div class="form-group">
                            <label for="ciudad">Ciudad</label>
                            <input type="text" id="ciudad" name="ciudad" class="form-control" maxlength="100">
                        </div>

                        <div class="form-group">
                            <label for="antecedentes">Antecedentes Médicos</label>
                            <textarea id="antecedentes" name="antecedentes" class="form-control" rows="3" maxlength="65535"></textarea>
                        </div>

                        <div class="form-group">
                            <label for="grupoSanguineo">Grupo Sanguíneo</label>
                            <select id="grupoSanguineo" name="grupoSanguineo" class="form-control">
                                <option value="">Seleccionar</option>
                                <option value="A+">A+</option>
                                <option value="A-">A-</option>
                                <option value="B+">B+</option>
                                <option value="B-">B-</option>
                                <option value="AB+">AB+</option>
                                <option value="AB-">AB-</option>
                                <option value="O+">O+</option>
                                <option value="O-">O-</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="fechaRegistro">Fecha de Registro *</label>
                            <input type="date" id="fechaRegistro" name="fechaRegistro" class="form-control" required>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="userName">Nombre de Usuario *</label>
                                <input type="text" id="userName" name="userName" class="form-control" required maxlength="10">
                            </div>

                            <div class="form-group">
                                <label for="passwordDate">Contraseña *</label>
                                <input type="password" id="passwordDate" name="passwordDate" class="form-control" required maxlength="10">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="form-check">
                                <input type="checkbox" id="terms" name="terms" class="form-check-input" required>
                                <label for="terms" class="form-check-label">Acepto los <a href="#">términos y condiciones</a> y la <a href="#">política de privacidad</a> *</label>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary">Crear Cuenta</button>

                        <div class="login-redirect">
                            <p>¿Ya tienes una cuenta? <a href="../logeo/iniciarSesion.jsp">Inicia sesión aquí</a></p>
                        </div>
                    </form>

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
                        <li><a href="servicios.html">Consultas</a></li>
                        <li><a href="servicios.html">Exámenes</a></li>
                        <li><a href="servicios.html">Urgencias</a></li>
                        <li><a href="servicios.html">Vacunas</a></li>
                    </ul>
                </div>
                
                <div class="footer-links">
                    <h5>Información</h5>
                    <ul>
                        <li><a href="nosotros.html">Nosotros</a></li>
                        <li><a href="medicos.html">Médicos</a></li>
                        <li><a href="servicios.html">Precios</a></li>
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
            
            // Validación de formulario
            document.getElementById('patientForm').addEventListener('submit', function(e) {
                // Validar que los campos obligatorios estén completos
                const requiredFields = [
                    'nombres', 'apellidos', 'fechaNacimiento', 'genero',
                    'tipoDocumento', 'numeroDocumento', 'numeroHistoriaClinica',
                    'userName', 'passwordDate'
                ];
                
                let isValid = true;
                
                requiredFields.forEach(field => {
                    const input = document.getElementById(field);
                    if (!input.value.trim()) {
                        isValid = false;
                        input.style.borderColor = 'var(--danger)';
                    } else {
                        input.style.borderColor = '';
                    }
                });
                
                if (!isValid) {
                    e.preventDefault();
                    alert('Por favor, complete todos los campos obligatorios marcados con *');
                }
                
                // Validar formato de email si se ingresó
                const email = document.getElementById('correo');
                if (email.value && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
                    e.preventDefault();
                    alert('Por favor, ingrese un correo electrónico válido');
                    email.focus();
                }
            });
        </script>
    </body>
</html>