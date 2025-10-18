<%@page import="conexion.conexionbd"%>
<%@page import="java.sql.*"%>
<%@page import="javax.naming.*"%>
<%@page import="javax.sql.DataSource"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Médicos - Policlínico Wiener Sistem</title>
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
            .dashboard-grid, .quick-actions-grid {
                grid-template-columns: 1fr;
            }
            
            .main-content {
                padding: 1.5rem;
            }
        }
        /* Usa tu mismo estilo ya definido arriba */
        .form-container {
            background: white;
            padding: 2rem;
            border-radius: var(--card-border-radius);
            box-shadow: var(--shadow-md);
            margin: 2rem auto;
            max-width: 800px;
        }
        .form-container h2 {
            margin-bottom: 1.5rem;
            color: var(--secondary);
            text-align: center;
        }
        .form-group {
            margin-bottom: 1rem;
        }
        label {
            font-weight: 600;
            display: block;
            margin-bottom: 0.5rem;
            color: var(--secondary);
        }
        input, select, textarea {
            width: 100%;
            padding: 0.7rem;
            border: 1px solid var(--gray-400);
            border-radius: var(--border-radius);
            font-size: 0.95rem;
        }
        .btn-submit {
            background: var(--primary);
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 600;
            transition: var(--transition);
            display: block;
            margin: 1.5rem auto 0;
        }
        .btn-submit:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="app-container">
        <!-- Aquí va tu sidebar como ya lo tienes -->
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
                    <a href="<%= request.getContextPath() %>/listarServlet?acc=lpaciente" class="nav-link">
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
                    <a href="<%= request.getContextPath() %>/users/administrativo/reportes.jsp" class="nav-link">
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
                <form id="logoutForm" action="cerrarSesion" method="post">
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

        
        <main class="main-content">
            <div class="form-container">
                <h2>Registrar Médico</h2>
                <form action="<%= request.getContextPath() %>/registroMedico" method="post" enctype="multipart/form-data">
                    
                    <div class="form-group">
                        <label>Nombres</label>
                        <input type="text" name="nombres" required>
                    </div>

                    <div class="form-group">
                        <label>Apellidos</label>
                        <input type="text" name="apellidos" required>
                    </div>

                    <div class="form-group">
                        <label>Fotografía</label>
                        <input type="file" name="foto" accept="image/*">
                    </div>

                    <div class="form-group">
                        <label>Especialidad</label>
                        <select name="idEspecialidad" required>
                            <option value="">Seleccione una especialidad</option>
                            <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs = null;
                                try {
                                    conexionbd c = new conexionbd();
                                    con = c.getConexion();
                                    ps = con.prepareStatement("SELECT id, nombreEspecialidad FROM Especialidad");
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                            %>
                                <option value="<%= rs.getInt("id") %>"><%= rs.getString("nombreEspecialidad") %></option>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("<option>Error al cargar</option>");
                                } finally {
                                    if (rs != null) rs.close();
                                    if (ps != null) ps.close();
                                    if (con != null) con.close();
                                }
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Subespecialidad</label>
                        <select name="idSubespecialidad">
                            <option value="">Seleccione una subespecialidad</option>
                            <%
                                con = null;
                                ps = null;
                                rs = null;
                                try {
                                    conexionbd c = new conexionbd();
                                    con = c.getConexion();
                                    ps = con.prepareStatement("SELECT id, nombreSubEspecialidad FROM SubEspecialidad");
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                            %>
                                <option value="<%= rs.getInt("id") %>"><%= rs.getString("nombreSubEspecialidad") %></option>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("<option>Error al cargar</option>");
                                } finally {
                                    if (rs != null) rs.close();
                                    if (ps != null) ps.close();
                                    if (con != null) con.close();
                                }
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Número de colegiatura</label>
                        <input type="text" name="colegiatura" required>
                    </div>

                    <div class="form-group">
                        <label>Universidad</label>
                        <input type="text" name="universidad">
                    </div>

                    <div class="form-group">
                        <label>Correo Electrónico</label>
                        <input type="email" name="correo" required>
                    </div>

                    <div class="form-group">
                        <label>Número de teléfono</label>
                        <input type="text" name="telefono">
                    </div>

                    <div class="form-group">
                        <label>Descripción</label>
                        <textarea name="descripcion" rows="3"></textarea>
                    </div>

                    <div class="form-group">
                        <label>Username</label>
                        <input type="text" name="username" required>
                    </div>

                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" name="password" required>
                    </div>

                    <button type="submit" class="btn-submit">Registrar Médico</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>
