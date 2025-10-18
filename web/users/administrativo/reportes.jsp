<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DAO.loginDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes - Policlínico Wiener Sistem</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Open+Sans:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.3.6/css/buttons.dataTables.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js"></script>
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns"></script>
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

        .stat-doctors .stat-icon {
            background: rgba(26, 124, 201, 0.15);
            color: var(--primary);
        }

        .stat-patients .stat-icon {
            background: rgba(46, 204, 113, 0.15);
            color: var(--accent);
        }

        .stat-appointments .stat-icon {
            background: rgba(243, 156, 18, 0.15);
            color: var(--warning);
        }

        .stat-admins .stat-icon {
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

        /* Estadísticas */
        .stats-container {
            background: white;
            border-radius: var(--card-border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
        }

        .chart-container {
            position: relative;
            height: 350px;
            margin-top: 1.5rem;
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

        /* Nuevos estilos para reportes */
        .report-filters {
            background: white;
            border-radius: var(--card-border-radius);
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
        }
        
        .filter-row {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .filter-group {
            flex: 1;
            min-width: 200px;
        }
        
        .filter-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--gray-700);
        }
        
        .filter-group select, 
        .filter-group input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--gray-300);
            border-radius: var(--border-radius);
            font-family: 'Open Sans', sans-serif;
        }
        
        .filter-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 1rem;
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: var(--border-radius);
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            border: none;
        }
        
        .btn-primary {
            background: var(--primary);
            color: white;
        }
        
        .btn-primary:hover {
            background: var(--primary-dark);
        }
        
        .btn-outline {
            background: transparent;
            border: 1px solid var(--gray-300);
            color: var(--gray-700);
        }
        
        .btn-outline:hover {
            background: var(--gray-100);
        }
        
        .charts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .chart-card {
            background: white;
            border-radius: var(--card-border-radius);
            padding: 1.5rem;
            box-shadow: var(--shadow-md);
        }
        
        .chart-title {
            font-size: 1.2rem;
            margin-bottom: 1rem;
            color: var(--secondary);
        }
        
        .summary-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .summary-card {
            background: white;
            border-radius: var(--card-border-radius);
            padding: 1.5rem;
            box-shadow: var(--shadow-md);
            text-align: center;
        }
        
        .summary-card h3 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            color: var(--primary);
        }
        
        .summary-card p {
            color: var(--gray-600);
            font-size: 0.9rem;
        }
        
        .badge {
            display: inline-block;
            padding: 0.25rem 0.5rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .badge-success {
            background: rgba(46, 204, 113, 0.15);
            color: var(--accent);
        }
        
        .badge-warning {
            background: rgba(243, 156, 18, 0.15);
            color: var(--warning);
        }
        
        .badge-danger {
            background: rgba(231, 76, 60, 0.15);
            color: var(--danger);
        }
        
        .badge-info {
            background: rgba(52, 152, 219, 0.15);
            color: var(--info);
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
            
            .charts-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .dashboard-grid, .quick-actions-grid {
                grid-template-columns: 1fr;
            }
            
            .main-content {
                padding: 1.5rem;
            }
            
            .filter-row {
                flex-direction: column;
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
                <div class="user-name"><%= session.getAttribute("nombres") %> <%= session.getAttribute("apellidos") %></div>
                <div class="user-role">Administrador</div>
            </div>
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/dashboardServlet" class="nav-link ">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/listarServlet?acc=lmedico" class="nav-link ">
                        <i class="bi bi-person-plus"></i> Médicos
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/listarServlet?acc=lpaciente" class="nav-link ">
                        <i class="bi bi-people"></i> Pacientes
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/listarServlet?acc=lcita" class="nav-link">
                        <i class="bi bi-calendar-event"></i> Citas
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/listarServlet?acc=lhistorial" class="nav-link">
                        <i class="bi bi-journal-medical"></i> Historiales
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/users/administrativo/reportes.jsp" class="nav-link active">
                        <i class="bi bi-graph-up"></i> Reportes
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/users/administrativo/configuracion.jsp" class="nav-link">
                        <i class="bi bi-sliders"></i> Configuración
                    </a>
                </li>
            </ul>
            
             <div class="sidebar-footer">
                <form id="logoutForm" action="<%= request.getContextPath() %>/cerrarSesion" method="post">
                    <button class="logout-btn" type="button" onclick="cerrarSesion()">
                        <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
                    </button>
                </form>

                <script>
                function cerrarSesion() {
                    if (confirm("¿Seguro que deseas cerrar sesión?")) {
                        document.getElementById("logoutForm").submit(); // envía el form al servlet
                    }
                }
                </script>
            </div>
        </aside>

        <div class="main-content">
            <div class="page-header">
                <div class="page-title">
                    <h1>Reportes y Estadísticas</h1>
                    <p>Análisis en tiempo real del desempeño del policlínico</p>
                </div>
                <div class="header-actions">
                    <button class="notification-btn">
                        <i class="bi bi-bell"></i>
                        <span class="notification-badge">3</span>
                    </button>
                    <button class="search-btn">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
            </div>

            <!-- Filtros -->
            <div class="report-filters">
                <h3>Filtrar Reportes</h3>
                <div class="filter-row">
                    <div class="filter-group">
                        <label for="date-range">Rango de Fechas</label>
                        <select id="date-range">
                            <option value="today">Hoy</option>
                            <option value="week">Esta semana</option>
                            <option value="month" selected>Este mes</option>
                            <option value="quarter">Este trimestre</option>
                            <option value="year">Este año</option>
                            <option value="custom">Personalizado</option>
                        </select>
                    </div>
                    <div class="filter-group" id="custom-date-range" style="display:none">
                        <label for="start-date">Desde - Hasta</label>
                        <div style="display: flex; gap: 10px;">
                            <input type="date" id="start-date">
                            <input type="date" id="end-date">
                        </div>
                    </div>
                    <div class="filter-group">
                        <label for="especialidad">Especialidad</label>
                        <select id="especialidad">
                            <option value="all">Todas las especialidades</option>
                            <%
                                Connection cnEspecialidades = null;
                                Statement stEspecialidades = null;
                                ResultSet rsEspecialidades = null;
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    cnEspecialidades = DriverManager.getConnection("jdbc:mysql://localhost:3306/telemedicina1", "root", "");
                                    String sqlEspecialidades = "SELECT id, nombreEspecialidad FROM especialidad";
                                    stEspecialidades = cnEspecialidades.createStatement();
                                    rsEspecialidades = stEspecialidades.executeQuery(sqlEspecialidades);
                                    while(rsEspecialidades.next()){
                            %>
                                <option value="<%= rsEspecialidades.getString("id") %>"><%= rsEspecialidades.getString("nombreEspecialidad") %></option>
                            <%
                                    }
                                } catch(Exception e) {
                                    out.println("<option value='error'>Error cargando especialidades</option>");
                                } finally {
                                    if(rsEspecialidades != null) rsEspecialidades.close();
                                    if(stEspecialidades != null) stEspecialidades.close();
                                    if(cnEspecialidades != null) cnEspecialidades.close();
                                }
                            %>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label for="medico">Médico</label>
                        <select id="medico">
                            <option value="all">Todos los médicos</option>
                            <%
                                Connection cnMedicos = null;
                                Statement stMedicos = null;
                                ResultSet rsMedicos = null;
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    cnMedicos = DriverManager.getConnection("jdbc:mysql://localhost:3306/telemedicina1", "root", "");
                                    String sqlMedicos = "SELECT idMedico, nombres, apellidos FROM medico";
                                    stMedicos = cnMedicos.createStatement();
                                    rsMedicos = stMedicos.executeQuery(sqlMedicos);
                                    while(rsMedicos.next()){
                            %>
                                <option value="<%= rsMedicos.getString("idMedico") %>"><%= rsMedicos.getString("nombres") %> <%= rsMedicos.getString("apellidos") %></option>
                            <%
                                    }
                                } catch(Exception e) {
                                    out.println("<option value='error'>Error cargando médicos</option>");
                                } finally {
                                    if(rsMedicos != null) rsMedicos.close();
                                    if(stMedicos != null) stMedicos.close();
                                    if(cnMedicos != null) cnMedicos.close();
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="filter-actions">
                    <button class="btn btn-outline">Restablecer</button>
                    <button class="btn btn-primary" id="apply-filters">Aplicar Filtros</button>
                </div>
            </div>

            <!-- Tarjetas de resumen -->
            <%
                // Obtener estadísticas generales
                int totalCitas = 0;
                int citasAtendidas = 0;
                int citasPendientes = 0;
                int citasCanceladas = 0;
                int totalPacientes = 0;
                int totalMedicos = 0;
                double ingresosTotales = 0.0;
                
                Connection cnStats = null;
                Statement stStats = null;
                ResultSet rsStats = null;
                
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    cnStats = DriverManager.getConnection("jdbc:mysql://localhost:3306/telemedicina1", "root", "");
                    
                    // Total de citas
                    String sqlCitas = "SELECT COUNT(*) as total FROM citamedica";
                    stStats = cnStats.createStatement();
                    rsStats = stStats.executeQuery(sqlCitas);
                    if(rsStats.next()) totalCitas = rsStats.getInt("total");
                    
                    // Citas por estado
                    String sqlEstadoCitas = "SELECT estado, COUNT(*) as cantidad FROM citamedica GROUP BY estado";
                    rsStats = stStats.executeQuery(sqlEstadoCitas);
                    while(rsStats.next()) {
                        String estado = rsStats.getString("estado");
                        int cantidad = rsStats.getInt("cantidad");
                        
                        if("Atendida".equalsIgnoreCase(estado)) citasAtendidas = cantidad;
                        else if("Pendiente".equalsIgnoreCase(estado)) citasPendientes = cantidad;
                        else if("Cancelada".equalsIgnoreCase(estado)) citasCanceladas = cantidad;
                    }
                    
                    // Total pacientes
                    String sqlPacientes = "SELECT COUNT(*) as total FROM paciente";
                    rsStats = stStats.executeQuery(sqlPacientes);
                    if(rsStats.next()) totalPacientes = rsStats.getInt("total");
                    
                    // Total médicos
                    String sqlMedicos = "SELECT COUNT(*) as total FROM medico";
                    rsStats = stStats.executeQuery(sqlMedicos);
                    if(rsStats.next()) totalMedicos = rsStats.getInt("total");
                    
                    // Ingresos (asumiendo que hay un campo costo en citamedica)
                    try {
                        String sqlIngresos = "SELECT IFNULL(SUM(precio), 0) AS total FROM citamedica WHERE TRIM(LOWER(estado)) = 'pendiente';";
                        rsStats = stStats.executeQuery(sqlIngresos);
                        if(rsStats.next()) ingresosTotales = rsStats.getDouble("total");
                    } catch(Exception e) {
                        // Si no existe el campo costo, usar un valor por defecto
                        ingresosTotales = citasAtendidas * 150.0; // Suponiendo un costo promedio de 150 por cita
                    }
                    
                } catch(Exception e) {
                    out.println("<!-- Error obteniendo estadísticas: " + e.getMessage() + " -->");
                } finally {
                    if(rsStats != null) rsStats.close();
                    if(stStats != null) stStats.close();
                    if(cnStats != null) cnStats.close();
                }
            %>
            
            <div class="summary-cards">
                <div class="summary-card">
                    <h3><%= totalCitas %></h3>
                    <p>Citas Totales</p>
                </div>
                <div class="summary-card">
                    <h3><%= citasAtendidas %></h3>
                    <p>Citas Atendidas</p>
                </div>
                <div class="summary-card">
                    <h3><%= citasPendientes %></h3>
                    <p>Citas Pendientes</p>
                </div>
                <div class="summary-card">
                    <h3><%= citasCanceladas %></h3>
                    <p>Citas Canceladas</p>
                </div>
                <div class="summary-card">
                    <h3>S/.<%= String.format("%.2f", ingresosTotales) %></h3>
                    <p>Ingresos Totales</p>
                </div>
            </div>

            <!-- Gráficos -->
            <div class="charts-grid">
                <div class="chart-card">
                    <h3 class="chart-title">Distribución de Citas por Estado</h3>
                    <div class="chart-container">
                        <canvas id="estadoCitasChart"></canvas>
                    </div>
                </div>
                <div class="chart-card">
                    <h3 class="chart-title">Citas por Especialidad</h3>
                    <div class="chart-container">
                        <canvas id="especialidadChart"></canvas>
                    </div>
                </div>
                <div class="chart-card">
                    <h3 class="chart-title">Evolución Mensual de Citas</h3>
                    <div class="chart-container">
                        <canvas id="mensualChart"></canvas>
                    </div>
                </div>
                <div class="chart-card">
                    <h3 class="chart-title">Médicos con Más Citas</h3>
                    <div class="chart-container">
                        <canvas id="medicosChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Tabla de reportes -->
            <div class="stats-container">
                <h3 class="section-title">Detalle de Citas</h3>
                <div class="table-responsive mt-4">
                    <table id="reporteTable" class="display nowrap" style="width:100%">
                        <thead>
                            <tr>
                                <th>Paciente</th>
                                <th>Médico</th>
                                <th>Especialidad</th>
                                <th>Fecha Cita</th>
                                <th>Hora</th>
                                <th>Estado</th>
                                <th>Costo</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Connection cnCitas = null;
                                Statement stCitas = null;
                                ResultSet rsCitas = null;
                                
                                // Mapa para estadísticas de especialidades
                                Map<String, Integer> especialidadesMap = new HashMap<>();
                                
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    cnCitas = DriverManager.getConnection("jdbc:mysql://localhost:3306/telemedicina1", "root", "");
                                    String sqlCitas = "SELECT p.nombres AS paciente, m.nombres AS medico, e.nombreEspecialidad, c.fechaRegistro, c.horaInicio, c.estado, c.precio FROM citamedica c INNER JOIN paciente p ON c.idPaciente = p.idPaciente INNER JOIN medico m ON c.idMedico = m.idMedico INNER JOIN especialidad e ON m.idEspecialidad = e.id ORDER BY c.fechaRegistro DESC";
                                    stCitas = cnCitas.createStatement();
                                    rsCitas = stCitas.executeQuery(sqlCitas);
                                    while(rsCitas.next()){
                                        String especialidad = rsCitas.getString("nombreEspecialidad");
                                        especialidadesMap.put(especialidad, especialidadesMap.getOrDefault(especialidad, 0) + 1);
                            %>
                                <tr>
                                    <td><%= rsCitas.getString("paciente") %></td>
                                    <td><%= rsCitas.getString("medico") %></td>
                                    <td><%= especialidad %></td>
                                    <td><%= rsCitas.getString("fechaRegistro") %></td>
                                    <td><%= rsCitas.getString("horaInicio") != null ? rsCitas.getString("horaInicio") : "N/A" %></td>
                                    <td>
                                        <%
                                            String estado = rsCitas.getString("estado");
                                            String badgeClass = "";
                                            if("Atendida".equalsIgnoreCase(estado)) badgeClass = "badge-success";
                                            else if("Pendiente".equalsIgnoreCase(estado)) badgeClass = "badge-warning";
                                            else if("Cancelada".equalsIgnoreCase(estado)) badgeClass = "badge-danger";
                                            else badgeClass = "badge-info";
                                        %>
                                        <span class="badge <%= badgeClass %>"><%= estado %></span>
                                    </td>
                                    <td>S/. <%= rsCitas.getDouble("precio") > 0 ? String.format("%.2f", rsCitas.getDouble("precio")) : "0.00" %></td>
                                </tr>
                            <%
                                    }
                                } catch(Exception e) {
                                    out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
                                } finally {
                                    if(rsCitas != null) rsCitas.close();
                                    if(stCitas != null) stCitas.close();
                                    if(cnCitas != null) cnCitas.close();
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // Inicializar DataTable con botones de exportación
            $('#reporteTable').DataTable({
                dom: 'Bfrtip',
                buttons: [
                    { 
                        extend: 'excelHtml5', 
                        text: '<i class="bi bi-file-earmark-excel"></i> Excel',
                        className: 'btn btn-outline',
                        title: 'Reporte_Citas_Policlinico'
                    },
                    { 
                        extend: 'pdfHtml5', 
                        text: '<i class="bi bi-file-earmark-pdf"></i> PDF',
                        className: 'btn btn-outline',
                        title: 'Reporte_Citas_Policlinico'
                    },
                    { 
                        extend: 'csvHtml5', 
                        text: '<i class="bi bi-file-earmark-text"></i> CSV',
                        className: 'btn btn-outline',
                        title: 'Reporte_Citas_Policlinico'
                    },
                    { 
                        extend: 'print', 
                        text: '<i class="bi bi-printer"></i> Imprimir',
                        className: 'btn btn-outline'
                    }
                ],
                language: { 
                    url: '//cdn.datatables.net/plug-ins/1.13.4/i18n/es-ES.json' 
                },
                responsive: true,
                order: [[3, 'desc']] // Ordenar por fecha descendente por defecto
            });
            
            // Mostrar/ocultar selector de fechas personalizadas
            $('#date-range').change(function() {
                if ($(this).val() === 'custom') {
                    $('#custom-date-range').show();
                } else {
                    $('#custom-date-range').hide();
                }
            });
            
            // Gráfico de estado de citas
            const estadoCitasCtx = document.getElementById('estadoCitasChart').getContext('2d');
            new Chart(estadoCitasCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Atendidas', 'Pendientes', 'Canceladas'],
                    datasets: [{
                        data: [<%= citasAtendidas %>, <%= citasPendientes %>, <%= citasCanceladas %>],
                        backgroundColor: ['#28a745', '#ffc107', '#dc3545'],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        },
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    let label = context.label || '';
                                    let value = context.raw || 0;
                                    let total = context.dataset.data.reduce((a, b) => a + b, 0);
                                    let percentage = Math.round((value / total) * 100);
                                    return `${label}: ${value} (${percentage}%)`;
                                }
                            }
                        }
                    }
                }
            });
            
            // Gráfico de citas por especialidad
            const especialidadCtx = document.getElementById('especialidadChart').getContext('2d');
            <%
                StringBuilder especialidadesLabels = new StringBuilder();
                StringBuilder especialidadesData = new StringBuilder();
                
                for (Map.Entry<String, Integer> entry : especialidadesMap.entrySet()) {
                    if (especialidadesLabels.length() > 0) {
                        especialidadesLabels.append(",");
                        especialidadesData.append(",");
                    }
                    especialidadesLabels.append("'").append(entry.getKey()).append("'");
                    especialidadesData.append(entry.getValue());
                }
            %>
            
            new Chart(especialidadCtx, {
                type: 'bar',
                data: {
                    labels: [<%= especialidadesLabels.toString() %>],
                    datasets: [{
                        label: 'Número de Citas',
                        data: [<%= especialidadesData.toString() %>],
                        backgroundColor: '#1a7cc9',
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                stepSize: 1
                            }
                        }
                    }
                }
            });
            
            // Gráfico de evolución mensual (datos de ejemplo)
            const mensualCtx = document.getElementById('mensualChart').getContext('2d');
            new Chart(mensualCtx, {
                type: 'line',
                data: {
                    labels: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
                    datasets: [{
                        label: 'Citas Atendidas',
                        data: [12, 19, 15, 17, 22, 25, 30, 28, 26, 32, 35, 40],
                        borderColor: '#28a745',
                        backgroundColor: 'rgba(40, 167, 69, 0.1)',
                        fill: true,
                        tension: 0.3
                    }, {
                        label: 'Citas Totales',
                        data: [15, 22, 18, 20, 25, 28, 35, 32, 30, 38, 42, 48],
                        borderColor: '#1a7cc9',
                        backgroundColor: 'rgba(26, 124, 201, 0.1)',
                        fill: true,
                        tension: 0.3
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
            
            // Gráfico de médicos con más citas (datos de ejemplo)
            const medicosCtx = document.getElementById('medicosChart').getContext('2d');
            new Chart(medicosCtx, {
                type: 'horizontalBar',
                data: {
                    labels: ['Dr. García', 'Dra. Martínez', 'Dr. López', 'Dra. Rodríguez', 'Dr. Pérez'],
                    datasets: [{
                        label: 'Citas Atendidas',
                        data: [45, 38, 32, 28, 25],
                        backgroundColor: [
                            'rgba(52, 152, 219, 0.8)',
                            'rgba(46, 204, 113, 0.8)',
                            'rgba(155, 89, 182, 0.8)',
                            'rgba(241, 196, 15, 0.8)',
                            'rgba(230, 126, 34, 0.8)'
                        ],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    indexAxis: 'y',
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        x: {
                            beginAtZero: true
                        }
                    }
                }
            });
            
            // Aplicar filtros
            $('#apply-filters').click(function() {
                // Aquí iría la lógica para aplicar los filtros y actualizar los gráficos
                alert('Los filtros se aplicarían y se recargarían los datos en un sistema real');
            });
        });
    </script>
</body>
</html>