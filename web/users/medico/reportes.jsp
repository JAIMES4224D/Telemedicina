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
    <title>Reportes Médicos - Policlínico Wiener Sistem</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Open+Sans:wght@400;500;600&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        /* Sección de gráficos */
        .charts-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .chart-card {
            background: white;
            border-radius: var(--card-border-radius);
            padding: 1.5rem;
            box-shadow: var(--shadow-md);
            transition: var(--transition);
        }

        .chart-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .chart-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--secondary);
        }

        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
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
            .dashboard-grid, .charts-container {
                grid-template-columns: 1fr;
            }
            
            .main-content {
                padding: 1.5rem;
            }
            
            .chart-container {
                height: 250px;
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
                    <a href="<%= request.getContextPath() %>/controlMedico?acc=reportes&idMedico=<%= session.getAttribute("idMedico") %>" class="nav-link active">
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
            <div class="page-header">
                <div class="page-title">
                    <h1>Reportes y Estadísticas</h1>
                    <p>Análisis de citas médicas - Dr. <%= session.getAttribute("nombres") %> <%= session.getAttribute("apellidos") %></p>
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
            
            <!-- Estadísticas -->
            <div class="dashboard-grid">
                <div class="stat-card stat-appointments">
                    <div class="stat-icon">
                        <i class="bi bi-calendar-date"></i>
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
                
                <div class="stat-card stat-prescriptions">
                    <div class="stat-icon">
                        <i class="bi bi-file-medical"></i>
                    </div>
                    <div class="stat-info">
                        <h3><%= (Integer)session.getAttribute("citasComp") + (Integer)session.getAttribute("citasPend") %></h3>
                        <p>Total Citas</p>
                    </div>
                </div>
            </div>
            
            <!-- Gráficos -->
            <div class="charts-container">
                <div class="chart-card">
                    <div class="chart-header">
                        <h3 class="chart-title">Distribución de Citas</h3>
                        <i class="bi bi-pie-chart" style="color: var(--primary); font-size: 1.5rem;"></i>
                    </div>
                    <div class="chart-container">
                        <canvas id="pieChart"></canvas>
                    </div>
                </div>
                
                <div class="chart-card">
                    <div class="chart-header">
                        <h3 class="chart-title">Comparación de Citas</h3>
                        <i class="bi bi-bar-chart" style="color: var(--primary); font-size: 1.5rem;"></i>
                    </div>
                    <div class="chart-container">
                        <canvas id="barChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <footer>
                <p>© 2025 Policlínico Wiener Sistem. Todos los derechos reservados.</p>
            </footer>
        </main>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Datos para los gráficos
            const citasHoy = <%= session.getAttribute("cantCitas") %>;
            const citasCompletadas = <%= session.getAttribute("citasComp") %>;
            const citasPendientes = <%= session.getAttribute("citasPend") %>;
            
            // Gráfico de pastel
            const pieCtx = document.getElementById('pieChart').getContext('2d');
            const pieChart = new Chart(pieCtx, {
                type: 'pie',
                data: {
                    labels: ['Completadas', 'Pendientes'],
                    datasets: [{
                        data: [citasCompletadas, citasPendientes],
                        backgroundColor: [
                            'rgba(46, 204, 113, 0.8)',  // Verde para completadas
                            'rgba(243, 156, 18, 0.8)'   // Naranja para pendientes
                        ],
                        borderColor: [
                            'rgba(46, 204, 113, 1)',
                            'rgba(243, 156, 18, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                font: {
                                    size: 14,
                                    family: "'Open Sans', sans-serif"
                                },
                                padding: 20
                            }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0, 0, 0, 0.7)',
                            titleFont: {
                                family: "'Montserrat', sans-serif",
                                size: 14
                            },
                            bodyFont: {
                                family: "'Open Sans', sans-serif",
                                size: 13
                            }
                        }
                    }
                }
            });
            
            // Gráfico de barras
            const barCtx = document.getElementById('barChart').getContext('2d');
            const barChart = new Chart(barCtx, {
                type: 'bar',
                data: {
                    labels: ['Citas Hoy', 'Completadas', 'Pendientes'],
                    datasets: [{
                        label: 'Número de Citas',
                        data: [citasHoy, citasCompletadas, citasPendientes],
                        backgroundColor: [
                            'rgba(26, 124, 201, 0.8)',   // Azul para citas hoy
                            'rgba(46, 204, 113, 0.8)',   // Verde para completadas
                            'rgba(243, 156, 18, 0.8)'    // Naranja para pendientes
                        ],
                        borderColor: [
                            'rgba(26, 124, 201, 1)',
                            'rgba(46, 204, 113, 1)',
                            'rgba(243, 156, 18, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                font: {
                                    family: "'Open Sans', sans-serif",
                                    size: 12
                                }
                            },
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            }
                        },
                        x: {
                            ticks: {
                                font: {
                                    family: "'Open Sans', sans-serif",
                                    size: 12
                                }
                            },
                            grid: {
                                display: false
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0, 0, 0, 0.7)',
                            titleFont: {
                                family: "'Montserrat', sans-serif",
                                size: 14
                            },
                            bodyFont: {
                                family: "'Open Sans', sans-serif",
                                size: 13
                            }
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>