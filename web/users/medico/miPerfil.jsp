<%@page import="modelo.medicoFoto"%>
<%@page import="modelo.paciente"%>
<%@page import="modelo.citaMedica"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Perfil - Policlínico Wiener Sistem</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Open+Sans:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #1a7cc9;
            --primary-dark: #1565a3;
            --primary-light: #e1f0fa;
            --secondary: #2c3e50;
            --secondary-light: #3a516e;
            --accent: #2ecc71;
            --accent-dark: #27ae60;
            --light: #f8f9fa;
            --dark: #343a40;
            --danger: #e74c3c;
            --warning: #f39c12;
            --info: #3498db;
            --gray-100: #f8f9fa;
            --gray-200: #e9ecef;
            --gray-300: #dee2e6;
            --gray-400: #ced4da;
            --gray-500: #adb5bd;
            --gray-600: #6c757d;
            --gray-700: #495057;
            --gray-800: #343a40;
            --gray-900: #212529;
            --shadow-sm: 0 2px 4px rgba(0,0,0,0.05);
            --shadow-md: 0 4px 6px rgba(0,0,0,0.07);
            --shadow-lg: 0 10px 15px rgba(0,0,0,0.1);
            --shadow-xl: 0 20px 25px rgba(0,0,0,0.15);
            --border-radius: 12px;
            --card-border-radius: 16px;
            --transition: all 0.3s ease;
            --sidebar-width: 280px;
            --header-height: 70px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Open Sans', sans-serif;
            background-color: #f5f9fc;
            color: var(--gray-700);
            line-height: 1.6;
            overflow-x: hidden;
            min-height: 100vh;
            display: flex;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            color: var(--secondary);
        }

        /* Layout Principal */
        .app-container {
            display: flex;
            width: 100%;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: var(--sidebar-width);
            background: linear-gradient(180deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            padding: 1.5rem 1rem;
            display: flex;
            flex-direction: column;
            box-shadow: var(--shadow-lg);
            z-index: 1000;
            transition: var(--transition);
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            position: relative;
        }

        .sidebar-brand {
            display: flex;
            align-items: center;
            font-size: 1.35rem;
            font-weight: 700;
            text-decoration: none;
            color: white;
        }

        .sidebar-brand i {
            margin-right: 0.75rem;
            font-size: 1.8rem;
        }

        .user-info {
            padding: 1rem 0;
            margin-bottom: 1.5rem;
            text-align: center;
            border-radius: var(--border-radius);
            background: rgba(255,255,255,0.1);
        }

        .user-name {
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 0.25rem;
        }

        .user-role {
            font-size: 0.85rem;
            opacity: 0.8;
        }

        .nav-menu {
            list-style: none;
            margin-top: 1rem;
            flex-grow: 1;
        }

        .nav-item {
            margin-bottom: 0.5rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.85rem 1rem;
            color: rgba(255,255,255,0.85);
            text-decoration: none;
            border-radius: var(--border-radius);
            transition: var(--transition);
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(255,255,255,0.15);
            color: white;
        }

        .nav-link i {
            margin-right: 0.75rem;
            font-size: 1.2rem;
            width: 24px;
            text-align: center;
        }

        .sidebar-footer {
            margin-top: auto;
            padding-top: 1rem;
            border-top: 1px solid rgba(255,255,255,0.1);
        }

        .logout-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            background: rgba(231, 76, 60, 0.9);
            color: white;
            border: none;
            padding: 0.75rem 1rem;
            border-radius: var(--border-radius);
            cursor: pointer;
            font-weight: 600;
            transition: var(--transition);
        }

        .logout-btn:hover {
            background: var(--danger);
            transform: translateY(-2px);
        }

        .logout-btn i {
            margin-right: 0.5rem;
        }

        /* Contenido Principal */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 2rem;
            transition: var(--transition);
        }

        /* Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--gray-300);
        }

        .page-title h1 {
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
        }

        .page-title p {
            color: var(--gray-600);
        }

        /* Estilos para el perfil */
        .profile-container {
            background: white;
            border-radius: var(--card-border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .profile-header h1 {
            font-size: 2rem;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .profile-content {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .profile-photo {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            overflow: hidden;
            margin-bottom: 1.5rem;
            border: 4px solid var(--primary-light);
            box-shadow: var(--shadow-md);
        }

        .profile-photo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-info {
            text-align: center;
            margin-bottom: 2rem;
            width: 100%;
        }

        .profile-name {
            font-size: 1.5rem;
            color: var(--secondary);
            margin-bottom: 0.5rem;
        }

        .profile-specialty {
            font-size: 1.1rem;
            color: var(--primary);
            margin-bottom: 1rem;
            font-weight: 500;
        }

        .profile-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            width: 100%;
        }

        .detail-card {
            background: var(--gray-100);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            display: flex;
            align-items: center;
            transition: var(--transition);
        }

        .detail-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-sm);
        }

        .detail-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            font-size: 1.5rem;
            flex-shrink: 0;
        }

        .detail-content h4 {
            font-size: 0.9rem;
            color: var(--gray-600);
            margin-bottom: 0.25rem;
        }

        .detail-content p {
            font-weight: 600;
            color: var(--secondary);
            font-size: 1.1rem;
        }

        /* Footer */
        footer {
            background-color: var(--secondary);
            color: white;
            padding: 1.5rem;
            text-align: center;
            margin-top: 3rem;
            border-radius: var(--border-radius);
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
                width: 260px;
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 1.5rem;
            }
            
            .profile-details {
                grid-template-columns: 1fr;
            }
            
            .detail-card {
                flex-direction: column;
                text-align: center;
            }
            
            .detail-icon {
                margin-right: 0;
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="app-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <a href="#" class="sidebar-brand">
                    <i class="bi bi-hospital"></i> Wiener Sistem
                </a>
            </div>
            
            <div class="user-info">
                <div class="user-name">Dr. <%= session.getAttribute("nombres") %> <%= session.getAttribute("apellidos") %></div>
                <div class="user-role">Médico</div>
                
            </div>
            
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/controlMedico?acc=dashboard&idMedico=<%= session.getAttribute("idMedico") %>" class="nav-link">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/controlMedico?acc=misCitas&idMedico=<%= session.getAttribute("idMedico") %>" class="nav-link">
                        <i class="bi bi-calendar-check"></i> Mis Citas
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/controlMedico?acc=pacientes&idMedico=<%= session.getAttribute("idMedico") %>" class="nav-link">
                        <i class="bi bi-people"></i> Pacientes
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/controlMedico?acc=horarios&idMedico=<%= session.getAttribute("idMedico") %>" class="nav-link">
                        <i class="bi bi-clock-history"></i> Horarios
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/controlMedico?acc=reportes&idMedico=<%= session.getAttribute("idMedico") %>" class="nav-link">
                        <i class="bi bi-bar-chart"></i> Reportes
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/controlMedico?acc=miPerfil&idMedico=<%= session.getAttribute("idMedico") %>" class="nav-link active">
                        <i class="bi bi-person"></i> Mi Perfil
                    </a>
                </li>
            </ul>
            
            <div class="sidebar-footer">
                <form action="<%= request.getContextPath() %>/cerrarSesion" method="post">
                    <button class="logout-btn" type="submit">
                        <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
                    </button>
                </form>
            </div>
        </aside>

        <!-- Contenido Principal -->
        <main class="main-content">
            <div class="profile-container">
                <div class="profile-header">
                    <h1>Mi Perfil</h1>
                </div>

                <%
                    List<medicoFoto> lista = (List<medicoFoto>) request.getAttribute("listaPerfil");
                    if (lista != null && !lista.isEmpty()) {
                        medicoFoto p = lista.get(0);
                        String base64Image = "";
                        if (p.getFoto() != null) {
                            base64Image = java.util.Base64.getEncoder().encodeToString(p.getFoto());
                        }
                %>

                <div class="profile-content">
                    <div class="profile-photo">
                        <% if (!base64Image.isEmpty()) { %>
                            <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Foto del médico">
                        <% } else { %>
                            <img src="https://cdn-icons-png.flaticon.com/512/847/847969.png" alt="Sin foto">
                        <% } %>
                    </div>
                    
                    <div class="profile-info">
                        <h2 class="profile-name"><%= p.getNombres() %> <%= p.getApellidos() %></h2>
                        <p class="profile-specialty">Especialidad: <%= p.getNombreEspecialidad() %></p>
                    </div>
                    
                    <div class="profile-details">
                        <div class="detail-card">
                            <div class="detail-icon">
                                <i class="bi bi-person-badge"></i>
                            </div>
                            <div class="detail-content">
                                <h4>Número de Colegiatura</h4>
                                <p><%= p.getNumeroColegiatura() %></p>
                            </div>
                        </div>
                        
                        <div class="detail-card">
                            <div class="detail-icon">
                                <i class="bi bi-envelope"></i>
                            </div>
                            <div class="detail-content">
                                <h4>Correo Electrónico</h4>
                                <p><%= p.getCorreoElectronico() %></p>
                            </div>
                        </div>
                        
                        <div class="detail-card">
                            <div class="detail-icon">
                                <i class="bi bi-telephone"></i>
                            </div>
                            <div class="detail-content">
                                <h4>Teléfono</h4>
                                <p><%= p.getNumeroTelefono() %></p>
                            </div>
                        </div>
                    </div>
                </div>

                <% } else { %>
                    <p>No se encontró información del médico.</p>
                <% } %>
            </div>

            <footer>
                <p>© 2025 Policlínico Wiener Sistem. Todos los derechos reservados.</p>
            </footer>
        </main>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Panel del médico cargado correctamente');
        });
    </script>
</body>
</html>