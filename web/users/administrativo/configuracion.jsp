<%@page import="DAO.loginDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Medicos - Policlínico Wiener Sistem</title>
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

        * { margin: 0; padding: 0; box-sizing: border-box; }

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

        .sidebar-brand i { margin-right: 0.75rem; font-size: 1.8rem; }

        .user-info {
            padding: 1rem 0;
            margin-bottom: 1.5rem;
            text-align: center;
            border-radius: var(--border-radius);
            background: rgba(255,255,255,0.1);
        }

        .user-name { font-weight: 600; font-size: 1.1rem; margin-bottom: 0.25rem; }
        .user-role { font-size: 0.85rem; opacity: 0.8; }

        .nav-menu { list-style: none; margin-top: 1rem; flex-grow: 1; }
        .nav-item { margin-bottom: 0.5rem; }

        .nav-link {
            display: flex; align-items: center;
            padding: 0.85rem 1rem;
            color: rgba(255,255,255,0.85);
            text-decoration: none;
            border-radius: var(--border-radius);
            transition: var(--transition);
        }

        .nav-link:hover, .nav-link.active { background: rgba(255,255,255,0.15); color: white; }

        .nav-link i { margin-right: 0.75rem; font-size: 1.2rem; width: 24px; text-align: center; }

        .sidebar-footer {
            margin-top: auto; padding-top: 1rem;
            border-top: 1px solid rgba(255,255,255,0.1);
        }

        .logout-btn {
            display: flex; align-items: center; justify-content: center;
            width: 100%; background: rgba(231, 76, 60, 0.9); color: white;
            border: none; padding: 0.75rem 1rem;
            border-radius: var(--border-radius);
            cursor: pointer; font-weight: 600;
            transition: var(--transition);
        }
        .logout-btn:hover { background: var(--danger); transform: translateY(-2px); }
        .logout-btn i { margin-right: 0.5rem; }

        /* Contenido Principal */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 2rem;
            transition: var(--transition);
        }

        .page-header {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 2rem; padding-bottom: 1rem; border-bottom: 1px solid var(--gray-300);
        }

        .page-title h1 { font-size: 1.8rem; margin-bottom: 0.5rem; }
        .page-title p { color: var(--gray-600); }

        /* Configuración */
        .config-container {
            background: white;
            padding: 2rem;
            border-radius: var(--card-border-radius);
            box-shadow: var(--shadow-md);
        }

        .config-container h2 {
            margin-bottom: 1.5rem;
            color: var(--primary);
        }

        .form-group { margin-bottom: 1.2rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: 600; }
        .form-group input {
            width: 100%; padding: 0.6rem;
            border: 1px solid var(--gray-400);
            border-radius: var(--border-radius);
        }

        .btn-guardar {
            background: var(--primary);
            color: white;
            padding: 0.7rem 1.5rem;
            border: none;
            border-radius: var(--border-radius);
            font-weight: 600;
            cursor: pointer;
        }
        .btn-guardar:hover { background: var(--primary-dark); }
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
                    <a href="<%= request.getContextPath() %>/users/administrativo/reportes.jsp" class="nav-link">
                        <i class="bi bi-graph-up"></i> Reportes
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/users/administrativo/configuracion.jsp" class="nav-link active">
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
                        document.getElementById("logoutForm").submit();
                    }
                }
                </script>
            </div>
        </aside>

        <!-- Contenido de Configuración -->
        <main class="main-content">
            <div class="page-header">
                <div class="page-title">
                    <h1>Configuración</h1>
                    <p>Administra tus preferencias del sistema</p>
                </div>
            </div>

            <div class="config-container">
                <h2>Preferencias del Usuario</h2>
                <form action="guardarConfiguracion" method="post">
                    <div class="form-group">
                        <label for="correo">Correo electrónico</label>
                        <input type="email" id="correo" name="correo" value="<%= session.getAttribute("correoElectronico") %>">
                    </div>
                    <div class="form-group">
                        <label for="telefono">Número de teléfono</label>
                        <input type="text" id="telefono" name="telefono" value="<%= session.getAttribute("numeroTelefono") %>">
                    </div>
                    <button type="submit" class="btn-guardar">Guardar Cambios</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>
