<%@page import="modelo.receta"%>
<%@page import="java.util.List"%>
<%@page import="modelo.citaMedica"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recetas del Paciente - Policlínico Wiener Sistem</title>
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
        .table-container {
            background: white;
            border-radius: var(--card-border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            overflow-x: auto;
            margin-top: 2rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95rem;
        }

        table thead {
            background-color: var(--primary);
            color: white;
        }

        table th, table td {
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid var(--gray-300);
        }

        table tr:hover {
            background-color: var(--gray-100);
        }

        table th {
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .section-title {
            margin-bottom: 1.5rem;
        }
        .btn-descargar {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #1a7cc9 0%, #1565a3 100%);
    color: white;
    padding: 0.6rem 1.2rem;
    border-radius: 30px;
    text-decoration: none;
    font-size: 0.85rem;
    font-weight: 600;
    transition: all 0.3s ease;
    box-shadow: 0 4px 6px rgba(26, 124, 201, 0.2);
    border: none;
    cursor: pointer;
    position: relative;
    overflow: hidden;
}

.btn-descargar::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s ease;
}

.btn-descargar:hover {
    background: linear-gradient(135deg, #1565a3 0%, #0f4c7e 100%);
    transform: translateY(-2px);
    box-shadow: 0 6px 12px rgba(26, 124, 201, 0.3);
    color: white;
}

.btn-descargar:hover::before {
    left: 100%;
}

.btn-descargar:active {
    transform: translateY(0);
    box-shadow: 0 2px 4px rgba(26, 124, 201, 0.2);
}

.btn-descargar i {
    margin-right: 0.5rem;
    font-size: 0.9rem;
    transition: transform 0.3s ease;
}

.btn-descargar:hover i {
    transform: translateY(2px);
}

/* Variante secundaria para diferentes contextos */
.btn-descargar.secondary {
    background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
    box-shadow: 0 4px 6px rgba(46, 204, 113, 0.2);
}

.btn-descargar.secondary:hover {
    background: linear-gradient(135deg, #27ae60 0%, #219653 100%);
    box-shadow: 0 6px 12px rgba(46, 204, 113, 0.3);
}

/* Estado de deshabilitado */
.btn-descargar:disabled {
    background: #cccccc;
    cursor: not-allowed;
    transform: none;
    box-shadow: none;
}

.btn-descargar:disabled:hover::before {
    left: -100%;
}
.btn-descargar {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #1a7cc9 0%, #1565a3 100%);
    color: white;
    padding: 0.6rem 1.2rem;
    border-radius: 30px;
    text-decoration: none;
    font-size: 0.85rem;
    font-weight: 600;
    transition: all 0.3s ease;
    box-shadow: 0 4px 6px rgba(26, 124, 201, 0.2);
    border: none;
    cursor: pointer;
    position: relative;
    overflow: hidden;
}

.btn-descargar span {
    position: relative;
    z-index: 2;
    display: flex;
    align-items: center;
}

.btn-descargar i {
    margin-right: 0.5rem;
    font-size: 0.9rem;
    transition: transform 0.3s ease;
}

.btn-descargar::after {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 0;
    height: 0;
    background: rgba(255, 255, 255, 0.3);
    border-radius: 50%;
    transform: translate(-50%, -50%);
    transition: width 0.6s ease, height 0.6s ease;
}

.btn-descargar:hover::after {
    width: 300px;
    height: 300px;
}

.btn-descargar:hover i {
    animation: downloadBounce 0.6s ease;
}

@keyframes downloadBounce {
    0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
    40% {transform: translateY(-5px);}
    60% {transform: translateY(-3px);}
}

.btn-descargar:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 15px rgba(26, 124, 201, 0.3);
}
@media (max-width: 768px) {
    .btn-descargar {
        padding: 0.5rem 1rem;
        font-size: 0.8rem;
    }
    
    .btn-descargar i {
        margin-right: 0.4rem;
        font-size: 0.8rem;
    }
}

/* Estilos para medicamentos */
.medicamento-item {
    background-color: #f8f9fa;
    border-radius: 8px;
    padding: 12px;
    margin-bottom: 10px;
    border-left: 4px solid var(--primary);
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

.medicamento-nombre {
    font-weight: 600;
    color: var(--primary);
    margin-bottom: 5px;
    font-size: 1rem;
}

.medicamento-detalle {
    display: flex;
    justify-content: space-between;
    font-size: 0.85rem;
    color: var(--gray-600);
}

.medicamento-detalle span {
    display: inline-block;
    background-color: #e9ecef;
    padding: 4px 8px;
    border-radius: 4px;
    margin-right: 8px;
}

.medicamentos-container {
    max-height: 200px;
    overflow-y: auto;
    padding-right: 5px;
}

/* Scrollbar personalizado */
.medicamentos-container::-webkit-scrollbar {
    width: 6px;
}

.medicamentos-container::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
}

.medicamentos-container::-webkit-scrollbar-thumb {
    background: #c1c1c1;
    border-radius: 10px;
}

.medicamentos-container::-webkit-scrollbar-thumb:hover {
    background: #a8a8a8;
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
                
                //int idPaciente = Integer.parseInt(session.getAttribute("idPaciente"));
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
                    <a href="<%= request.getContextPath() %>/inicioPaciente?acc=recetas&idPaciente=<%= session.getAttribute("idPaciente")%>" class="nav-link active">
                        <i class="bi bi-prescription2"></i> Recetas
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/inicioPaciente?acc=miperfil&idPaciente=<%= session.getAttribute("idPaciente")%>" class="nav-link ">
                        <i class="bi bi-person"></i> Mi Perfil
                    </a>
                </li>
            </ul>
            
            <div class="sidebar-footer">
                <form action="cerrarSesion" method="post">
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
                    <h1 align="center">RECETAS MÉDICAS - POLICLÍNICO WIENER SISTEM</h1>
                </div>
            </div>
            <form action="inicioPaciente" method="Post" >
                <%
                    List<receta> listarCitas = (List<receta>) request.getAttribute("listaRecetas");
                %>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>CITA</th>
                                <th>PACIENTE</th>
                                <th>MÉDICO</th>
                                <th>DIAGNÓSTICO</th>
                                <th>MEDICAMENTOS</th>
                                <th>FECHA</th>
                                <th>ACCIÓN</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if(listarCitas != null && !listarCitas.isEmpty()){
                                    for(receta c : listarCitas){
                                        String medicamentosJson = c.getMedicamento();
                            %>
                            <tr>
                                <td><%=c.getIdCita()  %></td>
                                <td><%=c.getNombrePaciente()  %></td>
                                <td><%=c.getNombreMedico()  %></td>
                                <td><%=c.getDiagnostico()  %></td>
                                <td>
                                    <div class="medicamentos-container">
                                        <%
                                            if (medicamentosJson != null && !medicamentosJson.isEmpty()) {
                                                try {
                                                    JSONArray medicamentosArray = new JSONArray(medicamentosJson);
                                                    for (int i = 0; i < medicamentosArray.length(); i++) {
                                                        JSONObject medicamento = medicamentosArray.getJSONObject(i);
                                        %>
                                        <div class="medicamento-item">
                                            <div class="medicamento-nombre">
                                                <i class="bi bi-capsule"></i> <%= medicamento.getString("medicamento") %>
                                            </div>
                                            <div class="medicamento-detalle">
                                                <span><i class="bi bi-droplet"></i> Dosis: <%= medicamento.getString("dosis") %></span>
                                                <span><i class="bi bi-clock"></i> Frecuencia: <%= medicamento.getString("frecuencia") %></span>
                                            </div>
                                        </div>
                                        <%
                                                    }
                                                } catch (Exception e) {
                                                    out.print("Error al procesar medicamentos");
                                                }
                                            } else {
                                                out.print("No hay medicamentos prescritos");
                                            }
                                        %>
                                    </div>
                                </td>
                                <td><%=c.getFecha()  %></td>
                                <td>
                                    <a href="<%= request.getContextPath() %>/DescargarRecetaServlet?idReceta=<%=c.getId()%>" class="btn-descargar"> 
                                        <span>
                                            <i class="bi bi-download"></i> Descargar
                                        </span>
                                    </a>
                                </td>
                                
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="7" style="text-align:center;">No hay recetas registradas.</td>
                            </tr>
                            <%    
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </form>
            
            <div>
                <footer>
                    <p>© 2025 Policlínico Wiener Sistem. Todos los derechos reservados.</p>
                </footer>
            </div>
        </main>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Panel del paciente cargado correctamente');
        });
    </script>
</body>
</html>