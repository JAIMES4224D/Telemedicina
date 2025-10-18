<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Médico - Policlínico Wiener Sistem</title>
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

        .user-specialty {
            font-size: 0.9rem;
            margin-top: 0.5rem;
            font-style: italic;
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

        .stat-today .stat-icon {
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

        .stat-availability .stat-icon {
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

        /* Próximas Citas */
        .appointments-section {
            margin-bottom: 2rem;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .section-title {
            font-size: 1.4rem;
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

        .view-all {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
        }

        .view-all i {
            margin-left: 0.5rem;
            transition: var(--transition);
        }

        .view-all:hover i {
            transform: translateX(3px);
        }

        .appointments-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .appointment-card {
            background: white;
            border-radius: var(--card-border-radius);
            padding: 1.5rem;
            box-shadow: var(--shadow-md);
            transition: var(--transition);
            border-left: 4px solid var(--primary);
        }

        .appointment-card.urgent {
            border-left-color: var(--danger);
        }

        .appointment-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-lg);
        }

        .appointment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid var(--gray-200);
        }

        .appointment-time {
            font-weight: 700;
            color: var(--primary);
            font-size: 1.1rem;
        }

        .appointment-status {
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .status-confirmed {
            background: rgba(46, 204, 113, 0.15);
            color: var(--accent-dark);
        }

        .status-pending {
            background: rgba(243, 156, 18, 0.15);
            color: var(--warning);
        }

        .status-urgent {
            background: rgba(231, 76, 60, 0.15);
            color: var(--danger);
        }

        .patient-info {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }

        .patient-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: var(--primary-light);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            color: var(--primary);
            font-size: 1.2rem;
        }

        .patient-details h4 {
            margin-bottom: 0.25rem;
        }

        .patient-details p {
            color: var(--gray-600);
            font-size: 0.85rem;
        }

        .appointment-details {
            margin-bottom: 1rem;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .detail-label {
            color: var(--gray-600);
        }

        .detail-value {
            font-weight: 600;
        }

        .appointment-actions {
            display: flex;
            gap: 0.75rem;
        }

        .btn-sm {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            border: none;
        }

        .btn-primary-sm {
            background: var(--primary);
            color: white;
        }

        .btn-primary-sm:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }

        .btn-outline-sm {
            background: transparent;
            color: var(--primary);
            border: 1px solid var(--primary);
        }

        .btn-outline-sm:hover {
            background: var(--primary-light);
            transform: translateY(-2px);
        }

        /* Quick Actions */
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
        }

        @media (max-width: 768px) {
            .dashboard-grid, .quick-actions-grid, .appointments-grid {
                grid-template-columns: 1fr;
            }
            
            .main-content {
                padding: 1.5rem;
            }
            
            .appointment-actions {
                flex-direction: column;
            }
            
            .section-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .view-all {
                margin-top: 0.5rem;
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
                <div class="user-specialty"></div>
            </div>
            
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/controlMedico?acc=dashboard&idMedico=<%= session.getAttribute("idMedico") %>" class="nav-link active">
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
                    <a href="<%= request.getContextPath() %>/controlMedico?acc=miPerfil&idMedico=<%= session.getAttribute("idMedico") %>" class="nav-link">
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
            <!-- Header -->
            <div class="page-header">
                <div class="page-title">
                    <h1>Bienvenido, Dr. <%= session.getAttribute("nombres") %></h1>
                    <p>Resumen de su agenda médica para hoy</p>
                </div>
                <div class="header-actions">
                    <div class="search-btn">
                        <i class="bi bi-search"></i>
                    </div>
                    <div class="notification-btn">
                        <i class="bi bi-bell"></i>
                        <span class="notification-badge">3</span>
                    </div>
                </div>
            </div>

            <!-- Estadísticas Rápidas -->
            <div class="dashboard-grid">
                <div class="stat-card stat-today">
                    <div class="stat-icon">
                        <i class="bi bi-calendar-day"></i>
                    </div>
                    <div class="stat-info">
                        <h3><%= session.getAttribute("cantCitas")%></h3>
                        <p>Citas Hoy</p>
                    </div>
                </div>
                
                <div class="stat-card stat-completed">
                    <div class="stat-icon">
                        <i class="bi bi-check-circle"></i>
                    </div>
                    <div class="stat-info">
                        <h3><%= session.getAttribute("citasComp") %></h3>
                        <p>Completadas</p>
                    </div>
                </div>
                
                <div class="stat-card stat-pending">
                    <div class="stat-icon">
                        <i class="bi bi-clock-history"></i>
                    </div>
                    <div class="stat-info">
                        <h3><%= session.getAttribute("citasPend") %></h3>
                        <p>Pendientes</p>
                    </div>
                </div>
                
                <div class="stat-card stat-availability">
                    <div class="stat-icon">
                        <i class="bi bi-person-check"></i>
                    </div>
                    <div class="stat-info">
                        <h3>92%</h3>
                        <p>Disponibilidad</p>
                    </div>
                </div>
            </div>

            <!-- Acciones Rápidas -->
            <h2 class="section-title">Acciones Rápidas</h2>
            <div class="quick-actions-grid">
                <div class="action-card">
                    <div class="action-icon">
                        <i class="bi bi-calendar-plus"></i>
                    </div>
                    <h3>Agendar Cita</h3>
                    <a href="<%= request.getContextPath() %>/controlMedico?acc=misCitas&idMedico=<%= session.getAttribute("idMedico") %>" class="action-btn">Mis Citas</a>
                </div>


                <div class="action-card">
                    <div class="action-icon">
                        <i class="bi bi-clock-history"></i>
                    </div>
                    <h3>Mi Horario</h3>
                    <a href="<%= request.getContextPath() %>/controlMedico?acc=horarios&idMedico=<%= session.getAttribute("idMedico") %>" class="action-btn">Gestionar</a>
                </div>
            </div>

            <!-- Footer -->
            <footer>
                <p>© 2025 Policlínico Wiener Sistem. Todos los derechos reservados.</p>
            </footer>
        </main>
    </div>

    <script>
        // Aquí puedes agregar funcionalidades JavaScript si es necesario
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Panel del médico cargado correctamente');
        });
    </script>
</body>
</html>