<%@page import="modelo.pacienteFoto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil del Paciente - Policlínico Wiener Sistem</title>
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

        .header-actions {
            display: flex;
            gap: 1rem;
        }

        .notification-btn, .search-btn {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: white;
            border: 1px solid var(--gray-300);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
            position: relative;
        }

        .notification-btn:hover, .search-btn:hover {
            background: var(--gray-100);
            transform: translateY(-2px);
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--danger);
            color: white;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            font-weight: 600;
        }

        /* Dashboard Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: var(--card-border-radius);
            padding: 1.5rem;
            box-shadow: var(--shadow-md);
            transition: var(--transition);
            display: flex;
            align-items: center;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1.2rem;
            font-size: 1.8rem;
            flex-shrink: 0;
        }

        .stat-appointments .stat-icon {
            background: rgba(26, 124, 201, 0.15);
            color: var(--primary);
        }

        .stat-completed .stat-icon {
            background: rgba(46, 204, 113, 0.15);
            color: var(--accent);
        }

        .stat-pending .stat-icon {
            background: rgba(243, 156, 18, 0.15);
            color: var(--warning);
        }

        .stat-prescriptions .stat-icon {
            background: rgba(231, 76, 60, 0.15);
            color: var(--danger);
        }

        .stat-info h3 {
            font-size: 1.8rem;
            margin-bottom: 0.25rem;
            font-weight: 700;
        }

        .stat-info p {
            color: var(--gray-600);
            font-size: 0.9rem;
        }

        /* Próxima Cita */
        .next-appointment {
            background: white;
            border-radius: var(--card-border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
            border-left: 5px solid var(--accent);
        }

        .next-appointment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .next-appointment-header h2 {
            font-size: 1.4rem;
        }

        .appointment-status {
            background: var(--accent-light);
            color: var(--accent-dark);
            padding: 0.4rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .appointment-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .detail-item {
            display: flex;
            align-items: center;
        }

        .detail-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--primary-light);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            font-size: 1.2rem;
        }

        .detail-info h4 {
            font-size: 0.9rem;
            color: var(--gray-600);
            margin-bottom: 0.25rem;
        }

        .detail-info p {
            font-weight: 600;
        }

        .appointment-actions {
            margin-top: 1.5rem;
            display: flex;
            gap: 1rem;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
            border: none;
            padding: 0.7rem 1.5rem;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }

        .btn-outline {
            background: transparent;
            color: var(--primary);
            border: 2px solid var(--primary);
            padding: 0.7rem 1.5rem;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
        }

        .btn-outline:hover {
            background: var(--primary-light);
            transform: translateY(-2px);
        }

        /* Quick Actions */
        .section-title {
            font-size: 1.4rem;
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 0.75rem;
        }

        .section-title::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 4px;
            background: var(--primary);
            border-radius: 2px;
        }

        .quick-actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2.5rem;
        }

        .action-card {
            background: white;
            border-radius: var(--card-border-radius);
            padding: 1.75rem;
            box-shadow: var(--shadow-md);
            transition: var(--transition);
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .action-icon {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.2rem;
            font-size: 2rem;
            background: var(--primary-light);
            color: var(--primary);
            transition: var(--transition);
        }

        .action-card:hover .action-icon {
            background: var(--primary);
            color: white;
            transform: scale(1.1);
        }

        .action-card h3 {
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }

        .action-btn {
            display: inline-block;
            background: var(--primary);
            color: white;
            padding: 0.6rem 1.5rem;
            border-radius: 30px;
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
            font-size: 0.9rem;
        }

        .action-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(26, 124, 201, 0.3);
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
            
            .menu-toggle {
                display: block;
            }
        }

        @media (max-width: 768px) {
            .dashboard-grid, .quick-actions-grid, .appointment-details {
                grid-template-columns: 1fr;
            }
            
            .main-content {
                padding: 1.5rem;
            }
            
            .appointment-actions {
                flex-direction: column;
            }
        }
        /* Estilos para la sección de perfil del paciente */
.profile-container {
    background: white;
    border-radius: var(--card-border-radius);
    padding: 2.5rem;
    box-shadow: var(--shadow-md);
    margin-bottom: 2rem;
}

.profile-header {
    display: flex;
    align-items: center;
    margin-bottom: 2rem;
    padding-bottom: 1.5rem;
    border-bottom: 1px solid var(--gray-300);
}

.profile-photo {
    position: relative;
    width: 150px;
    height: 150px;
    border-radius: 50%;
    overflow: hidden;
    margin-right: 2rem;
    border: 4px solid var(--primary-light);
    box-shadow: var(--shadow-md);
    transition: var(--transition);
}

.profile-photo:hover {
    transform: scale(1.05);
    box-shadow: var(--shadow-lg);
}

.profile-photo img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.profile-info {
    flex: 1;
}

.profile-name {
    font-size: 1.8rem;
    margin-bottom: 0.5rem;
    color: var(--secondary);
}

.profile-dni {
    color: var(--gray-600);
    font-size: 1.1rem;
    margin-bottom: 1rem;
}

.profile-details {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.5rem;
}

.detail-card {
    background: var(--gray-100);
    border-radius: var(--border-radius);
    padding: 1.5rem;
    transition: var(--transition);
}

.detail-card:hover {
    background: var(--primary-light);
    transform: translateY(-3px);
    box-shadow: var(--shadow-sm);
}

.detail-icon {
    display: flex;
    align-items: center;
    margin-bottom: 1rem;
    color: var(--primary);
}

.detail-icon i {
    font-size: 1.5rem;
    margin-right: 0.75rem;
}

.detail-content h4 {
    font-size: 0.9rem;
    color: var(--gray-600);
    margin-bottom: 0.5rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.detail-content p {
    font-weight: 600;
    color: var(--secondary);
    font-size: 1.1rem;
}

/* Responsive */
@media (max-width: 768px) {
    .profile-header {
        flex-direction: column;
        text-align: center;
    }
    
    .profile-photo {
        margin-right: 0;
        margin-bottom: 1.5rem;
    }
    
    .profile-details {
        grid-template-columns: 1fr;
    }
}

/* Efecto de carga para la imagen */
.profile-photo::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(45deg, #f1f1f1, #e1e1e1);
    border-radius: 50%;
    z-index: -1;
}

/* Badge de estado (opcional) */
.status-badge {
    position: absolute;
    bottom: 10px;
    right: 10px;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    background: var(--accent);
    border: 3px solid white;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}
    </style>
    <!-- Librería Chart.js para estadísticas -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            <%  
                
                int idPaciente = (Integer) session.getAttribute("idPaciente");
                System.out.println("exp = " + idPaciente);

            %>
            <div class="user-info">
                <div class="user-name"><%= session.getAttribute("nombres") %> <%= session.getAttribute("apellidos") %></div>
                <div class="user-role">Paciente</div>
            </div>
            
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/inicioPaciente?acc=actualizar" class="nav-link ">
                        <i class="bi bi-house-door"></i> Inicio
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/inicioPaciente?acc=reservarCita" class="nav-link">
                        <i class="bi bi-calendar-plus"></i> Reservar Cita
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/inicioPaciente?acc=misCitas&idPaciente=<%= session.getAttribute("idPaciente") %>" 
   class="nav-link">
                        <i class="bi bi-calendar-check"></i> Mis Citas
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/inicioPaciente?acc=historial&idPaciente=<%= session.getAttribute("idPaciente")%>" class="nav-link">
                        <i class="bi bi-file-medical"></i> Historial Médico
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/inicioPaciente?acc=recetas&idPaciente=<%= session.getAttribute("idPaciente")%>" class="nav-link">
                        <i class="bi bi-prescription2"></i> Recetas
                    </a>
                </li>
                
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/inicioPaciente?acc=miperfil&idPaciente=<%= session.getAttribute("idPaciente")%>" class="nav-link active">
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
            <div class="profile-container">
        <h1>Mi Perfil</h1>

        <%
            List<pacienteFoto> lista = (List<pacienteFoto>) request.getAttribute("listaRecetas");
            if (lista != null && !lista.isEmpty()) {
                pacienteFoto p = lista.get(0); // suponiendo que solo trae 1 paciente
                String base64Image = "";
                if (p.getFoto() != null) {
                    base64Image = java.util.Base64.getEncoder().encodeToString(p.getFoto());
                }
        %>

        <div class="profile-info">
            <div class="profile-photo">
                <% if (!base64Image.isEmpty()) { %>
                    <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Foto del paciente">
                <% } else { %>
                    <img src="https://cdn-icons-png.flaticon.com/512/847/847969.png" alt="Sin foto">
                <% } %>
            </div> 
            
            <div class="profile-info">
                <h2 class="profile-name"><%= p.getNombres() %> <%= p.getApellidos() %></h2>
                <p class="profile-dni">DNI: <%= p.getNumeroDocumento()%></p>
            </div>
            <div class="profile-details">
                <div class="detail-card">
                    <div class="detail-icon">
                        <i class="bi bi-envelope"></i>
                        <h4>Correo electrónico</h4>
                    </div>
                    <div class="detail-content">
                        <p><%= p.getCorreo() %></p>
                    </div>
                </div>

                <div class="detail-card">
                    <div class="detail-icon">
                        <i class="bi bi-telephone"></i>
                        <h4>Teléfono</h4>
                    </div>
                    <div class="detail-content">
                        <p><%= p.getTelefono() %></p>
                    </div>
                </div>

                <div class="detail-card">
                    <div class="detail-icon">
                        <i class="bi bi-geo-alt"></i>
                        <h4>Dirección</h4>
                    </div>
                    <div class="detail-content">
                        <p><%= p.getDireccion() %></p>
                    </div>
                </div>

                <div class="detail-card">
                    <div class="detail-icon">
                        <i class="bi bi-calendar-event"></i>
                        <h4>Fecha de nacimiento</h4>
                    </div>
                    <div class="detail-content">
                        <p><%= p.getFechaNacimiento() %></p>
                    </div>
                </div>
            </div>
        </div>

        <% } else { %>
            <p>No se encontró información del paciente.</p>
        <% } %>

        
            <!-- Footer -->
                <footer>
                <p>© 2025 Policlínico Wiener Sistem. Todos los derechos reservados.</p>
            </footer>
        </main>
     
    </div>
       
</div>
    <script>
        // Aquí puedes agregar funcionalidades JavaScript si es necesario
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Panel del paciente cargado correctamente');
        });
    </script>
</body>
</html>