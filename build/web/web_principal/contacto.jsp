<%-- 
    Document   : contacto
    Created on : 03/09/2025, 03:26:09 PM
    Author     : JEJALUOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Contacto - Policlínico Wiener Sistem</title>
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
                background: linear-gradient(rgba(26, 124, 201, 0.8), rgba(44, 62, 80, 0.8)), url('https://images.unsplash.com/photo-1579684385127-1ef15d508118?auto=format&fit=crop&w=1480&q=80');
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
            
            /* Contact Section */
            .contact {
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
            
            .contact-container {
                max-width: 1200px;
                margin: 0 auto;
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 3rem;
            }
            
            .contact-info {
                background: var(--light);
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            }
            
            .contact-info h3 {
                color: var(--primary);
                margin-bottom: 1.5rem;
                text-align: center;
            }
            
            .contact-item {
                display: flex;
                align-items: flex-start;
                margin-bottom: 1.5rem;
            }
            
            .contact-icon {
                color: var(--accent);
                font-size: 1.5rem;
                margin-right: 1rem;
                min-width: 30px;
            }
            
            .contact-content h4 {
                margin-bottom: 0.3rem;
                color: var(--secondary);
            }
            
            .contact-form {
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
            
            textarea.form-control {
                min-height: 120px;
                resize: vertical;
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
            
            /* Map Section */
            .map-section {
                padding: 0 1rem 5rem;
            }
            
            .map-container {
                max-width: 1200px;
                margin: 0 auto;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }
            
            .map-container iframe {
                width: 100%;
                height: 400px;
                border: none;
            }
            
            /* FAQ Section */
            .faq {
                padding: 5rem 1rem;
                background: linear-gradient(135deg, #e6f0ff, #f9fbff);
            }
            
            .faq-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 2rem;
                max-width: 1200px;
                margin: 0 auto;
            }
            
            .faq-item {
                background: white;
                padding: 1.5rem;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            }
            
            .faq-item h4 {
                color: var(--primary);
                margin-bottom: 1rem;
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
                
                .contact-container {
                    grid-template-columns: 1fr;
                    gap: 2rem;
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
                  <li class="nav-item"><a class="nav-link" href="registro.jsp">Registro</a></li>
                  <li class="nav-item"><a class="nav-link active" href="contacto.html">Contacto</a></li>
                  <li class="nav-item"><a class="nav-link btn-login" href="../logeo/iniciarSesion.jsp">Iniciar Sesión</a></li>
                </ul>
              </div>
            </div>
        </nav>
        
        <!-- Hero Section -->
        <section class="hero">
            <div class="hero-content">
                <h1>Contáctanos</h1>
                <p>Estamos aquí para responder tus preguntas y brindarte la mejor atención médica.</p>
            </div>
        </section>
        
        <!-- Contact Section -->
        <section class="contact">
            <div class="section-title">
                <h2>¿Cómo podemos ayudarte?</h2>
                <p>Estamos disponibles para atender tus consultas las 24 horas del día</p>
            </div>
            
            <div class="contact-container">
                <div class="contact-info">
                    <h3>Información de Contacto</h3>
                    
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="bi bi-geo-alt-fill"></i>
                        </div>
                        <div class="contact-content">
                            <h4>Dirección</h4>
                            <p>Av. Los Pinos 711, Independencia<br>Lima, Perú</p>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="bi bi-telephone-fill"></i>
                        </div>
                        <div class="contact-content">
                            <h4>Teléfonos</h4>
                            <p>Central: (01) 234-5678<br>Emergencias: (01) 234-EMER (3637)</p>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="bi bi-envelope-fill"></i>
                        </div>
                        <div class="contact-content">
                            <h4>Correo Electrónico</h4>
                            <p>info@policlinico.com<br>citas@policlinico.com</p>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="bi bi-clock-fill"></i>
                        </div>
                        <div class="contact-content">
                            <h4>Horario de Atención</h4>
                            <p>Lunes a Viernes: 8:00 am - 8:00 pm<br>Sábados: 9:00 am - 5:00 pm<br>Emergencias: 24/7</p>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="bi bi-share-fill"></i>
                        </div>
                        <div class="contact-content">
                            <h4>Redes Sociales</h4>
                            <p>
                                <a href="https://www.facebook.com/jeferson.jaimes.2025" style="color: var(--primary); margin-right: 1rem;">
                                    <i class="bi bi-facebook"></i> Facebook
                                </a>
                                <a href="#" style="color: var(--primary); margin-right: 1rem;">
                                    <i class="bi bi-instagram"></i> Instagram
                                </a>
                                <a href="#" style="color: var(--primary);">
                                    <i class="bi bi-twitter"></i> Twitter
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
                
                <div class="contact-form">
                    <h3>Envíanos un Mensaje</h3>
                    <form id="contactForm" action="<%= request.getContextPath() %>/contactoServlet" method="POST">
                        <div class="form-group">
                            <label for="nombre">Nombre Completo *</label>
                            <input type="text" id="nombre" name="nombre" class="form-control" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">Correo Electrónico *</label>
                            <input type="email" id="email" name="email" class="form-control" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="telefono">Teléfono / Celular</label>
                            <input type="tel" id="telefono" name="telefono" class="form-control">
                        </div>
                        
                        <div class="form-group">
                            <label for="asunto">Asunto *</label>
                            <select id="asunto" name="asunto" class="form-control" required>
                                <option value="">Seleccionar</option>
                                <option value="cita">Solicitud de Cita</option>
                                <option value="informacion">Información General</option>
                                <option value="emergencia">Emergencia</option>
                                <option value="queja">Queja o Sugerencia</option>
                                <option value="otros">Otros</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="mensaje">Mensaje *</label>
                            <textarea id="mensaje" name="mensaje" class="form-control" required></textarea>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Enviar Mensaje</button>
                    </form>
                </div>
            </div>
        </section>
        
        <!-- Map Section -->
        <section class="map-section">
            <div class="map-container">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3901.965315892996!2d-77.0506239250192!3d-12.054366088179982!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105c8f4e2c7c3f1%3A0x9d336c1c1e0e0b0f!2sAv.%20Los%20Pinos%20711%2C%20Independencia%2015311!5e0!3m2!1ses!2spe!4v1690834567890!5m2!1ses!2spe" allowfullscreen="" loading="lazy"></iframe>
            </div>
        </section>
        
        <!-- FAQ Section -->
        <section class="faq">
            <div class="section-title">
                <h2>Preguntas Frecuentes</h2>
                <p>Resolvemos tus dudas más comunes</p>
            </div>
            
            <div class="faq-grid">
                <div class="faq-item">
                    <h4>¿Cómo agendo una cita médica?</h4>
                    <p>Puedes agendar tu cita a través de nuestro sistema online, llamando a nuestra central telefónica o visitándonos en nuestras instalaciones.</p>
                </div>
                
                <div class="faq-item">
                    <h4>¿Aceptan seguros médicos?</h4>
                    <p>Sí, trabajamos con la mayoría de aseguradoras. Contáctanos para verificar si tu seguro tiene convenio con nosotros.</p>
                </div>
                
                <div class="faq-item">
                    <h4>¿Ofrecen servicios de emergencia?</h4>
                    <p>Sí, contamos con servicio de emergencias las 24 horas del día, los 7 días de la semana.</p>
                </div>
                
                <div class="faq-item">
                    <h4>¿Puedo obtener mis resultados en línea?</h4>
                    <p>Sí, una vez registrado en nuestro sistema, podrás acceder a tus resultados de exámenes a través de tu cuenta personal.</p>
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
            
            // Validación de formulario de contacto
            document.getElementById('contactForm').addEventListener('submit', function(e) {
                const requiredFields = ['nombre', 'email', 'asunto', 'mensaje'];
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
            });
        </script>
        
    </body>
</html>