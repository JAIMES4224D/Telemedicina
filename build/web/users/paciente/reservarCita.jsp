<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="conexion.conexionbd"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservar Cita - Policlínico Wiener Sistem</title>
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

        /* Formulario */
        .form-container {
            background: white;
            border-radius: var(--card-border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
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

        .form-group select,
        .form-group input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--gray-300);
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: var(--transition);
        }

        .form-group select:focus,
        .form-group input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(26, 124, 201, 0.1);
        }

        .btn-submit {
            background: var(--primary);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            font-size: 1rem;
        }

        .btn-submit:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }

        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: var(--primary);
            animation: spin 1s ease-in-out infinite;
            margin-left: 10px;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .info-precio {
            background-color: var(--primary-light);
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
            border-left: 4px solid var(--primary);
        }

        .info-precio h3 {
            color: var(--primary);
            margin-bottom: 0.5rem;
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
                <div class="user-role">Paciente</div>
            </div>
            
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/inicioPaciente?acc=actualizar" class="nav-link">
                        <i class="bi bi-house-door"></i> Inicio
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/inicioPaciente?acc=reservarCita" class="nav-link active">
                        <i class="bi bi-calendar-plus"></i> Reservar Cita
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/inicioPaciente?acc=misCitas" class="nav-link">
                        <i class="bi bi-calendar-check"></i> Mis Citas
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/inicioPaciente?acc=historial" class="nav-link">
                        <i class="bi bi-file-medical"></i> Historial Médico
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/inicioPaciente?acc=recetas" class="nav-link">
                        <i class="bi bi-prescription2"></i> Recetas
                    </a>
                </li>
                
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/inicioPaciente?acc=miperfil" class="nav-link">
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
                    <h1>Reservar Cita Médica</h1>
                    <p>Complete el formulario para agendar su cita</p>
                </div>
            </div>

            <div class="form-container">
                <form action="<%= request.getContextPath() %>/ConfirmarCitaServlet" method="POST">
                    <div class="form-group">
                        <label for="idEspecialidad">Especialidad:</label>
                        <select name="idEspecialidad" id="idEspecialidad" required onchange="cargarMedicos()">
                            <option value="">-- Seleccione una especialidad --</option>
                            <%
                                conexionbd c = new conexionbd();
                                PreparedStatement pt = null;
                                Connection cn = null;
                                ResultSet rs = null;

                                try {
                                    cn = c.getConexion();
                                    String sql = "SELECT * FROM especialidad";
                                    pt = cn.prepareStatement(sql);
                                    rs = pt.executeQuery();

                                    while(rs.next()) {
                                        int id = rs.getInt("id");
                                        String nombreEspecialidad = rs.getString("nombreEspecialidad");
                                        double precio = rs.getDouble("precio");
                            %>
                                        <option value="<%= id %>" data-precio="<%= precio %>">
                                            <%= nombreEspecialidad %> - S/. <%= precio %>
                                        </option>
                            <%
                                    }
                                } catch(Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                                    try { if (pt != null) pt.close(); } catch (Exception e) {}
                                    try { if (cn != null) cn.close(); } catch (Exception e) {}
                                }
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="idMedico">Médico:</label>
                        <select name="idMedico" id="idMedico" required disabled onchange="cargarHorarios()">
                            <option value="">-- Primero seleccione una especialidad --</option>
                        </select>
                        <span id="loadingMedicos" class="loading" style="display:none;"></span>
                    </div>
                        
                    <div class="form-group">
                        <label for="idHorario">Horario Disponible:</label>
                        <select name="idHorario" id="idHorario" required disabled>
                            <option value="">-- Primero seleccione un médico --</option>
                        </select>
                        <span id="loadingHorarios" class="loading" style="display:none;"></span>
                    </div>

                    <div class="info-precio">
                        <h3>Información de Precio</h3>
                        <p>Precio seleccionado: <strong id="precioMostrado">S/. 0.00</strong></p>
                    </div>

                    <input type="hidden" name="idPaciente" value="<%= session.getAttribute("idPaciente") %>">
                    <input type="hidden" name="precio" id="precioCita">

                    <button type="submit" class="btn-submit">Reservar Cita</button>
                </form>
            </div>

            <footer>
                <p>© 2025 Policlínico Wiener Sistem. Todos los derechos reservados.</p>
            </footer>
        </main>
    </div>

    <script>
        // Establecer el precio cuando se selecciona una especialidad
        document.getElementById('idEspecialidad').addEventListener('change', function() {
            var selectedOption = this.options[this.selectedIndex];
            var precio = selectedOption.getAttribute('data-precio');
            document.getElementById('precioCita').value = precio;
            document.getElementById('precioMostrado').textContent = 'S/. ' + parseFloat(precio).toFixed(2);
        });

        function cargarMedicos() {
            var idEspecialidad = document.getElementById("idEspecialidad").value;
            var selectMedicos = document.getElementById("idMedico");
            var selectHorarios = document.getElementById("idHorario");
            var loading = document.getElementById("loadingMedicos");
            
            // Resetear horarios y médico
            selectHorarios.innerHTML = '<option value="">-- Primero seleccione un médico --</option>';
            selectHorarios.disabled = true;
            selectMedicos.innerHTML = '<option value="">-- Primero seleccione una especialidad --</option>';
            
            if (idEspecialidad === "") {
                selectMedicos.disabled = true;
                return;
            }
            
            // Mostrar indicador de carga
            loading.style.display = 'inline-block';
            selectMedicos.disabled = true;
            
            // Realizar petición AJAX
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "<%= request.getContextPath() %>/cargarMedicos?idEspecialidad=" + idEspecialidad, true);
            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    loading.style.display = 'none';
                    
                    if (xhr.status === 200) {
                        try {
                            var medicos = JSON.parse(xhr.responseText);
                            selectMedicos.innerHTML = '<option value="">-- Seleccione un médico --</option>';
                            
                            if (medicos.length > 0) {
                                medicos.forEach(function(medico) {
                                    var option = document.createElement("option");
                                    option.value = medico.id;
                                    option.textContent = medico.nombres + " " + medico.apellidos;
                                    selectMedicos.appendChild(option);
                                });
                                selectMedicos.disabled = false;
                            } else {
                                selectMedicos.innerHTML = '<option value="">-- No hay médicos para esta especialidad --</option>';
                                selectMedicos.disabled = true;
                            }
                        } catch (e) {
                            console.error("Error parsing JSON:", e);
                            selectMedicos.innerHTML = '<option value="">-- Error al cargar médicos --</option>';
                            selectMedicos.disabled = true;
                        }
                    } else {
                        selectMedicos.innerHTML = '<option value="">-- Error al cargar médicos --</option>';
                        selectMedicos.disabled = true;
                    }
                }
            };
            
            xhr.send();
        }

        function cargarHorarios() {
            var idMedico = document.getElementById("idMedico").value;
            var selectHorarios = document.getElementById("idHorario");
            var loading = document.getElementById("loadingHorarios");
            
            if (idMedico === "") {
                selectHorarios.innerHTML = '<option value="">-- Primero seleccione un médico --</option>';
                selectHorarios.disabled = true;
                return;
            }
            
            loading.style.display = 'inline-block';
            selectHorarios.disabled = true;
            
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "<%= request.getContextPath() %>/cargarHorarios?idMedico=" + idMedico, true);
            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    loading.style.display = 'none';
                    
                    if (xhr.status === 200) {
                        try {
                            var horarios = JSON.parse(xhr.responseText);
                            console.log("Horarios recibidos:", horarios);
                            selectHorarios.innerHTML = '<option value="">-- Seleccione un horario --</option>';
                            
                            if (horarios.length > 0) {
                                horarios.forEach(function(horario) {
                                    var option = document.createElement("option");
                                    option.value = horario.id;
                                    
                                    // Formatear la fecha y hora
                                    var fechaInicio = new Date(horario.horaInicio);
                                    var fechaFin = new Date(horario.horaFin);
                                    
                                    var fechaFormateada = fechaInicio.toLocaleDateString('es-ES') + ' ' + 
                                                        fechaInicio.toLocaleTimeString('es-ES', {hour: '2-digit', minute:'2-digit'}) +
                                                        ' - ' +
                                                        fechaFin.toLocaleTimeString('es-ES', {hour: '2-digit', minute:'2-digit'});
                                    
                                    option.textContent = fechaFormateada;
                                    option.setAttribute('data-hora-inicio', horario.horaInicio);
                                    option.setAttribute('data-hora-fin', horario.horaFin);
                                    selectHorarios.appendChild(option);
                                });
                                selectHorarios.disabled = false;
                            } else {
                                selectHorarios.innerHTML = '<option value="">-- No hay horarios disponibles --</option>';
                                selectHorarios.disabled = true;
                            }
                        } catch (e) {
                            console.error("Error parsing JSON:", e);
                            console.log("Response received:", xhr.responseText);
                            selectHorarios.innerHTML = '<option value="">-- Error al cargar horarios --</option>';
                            selectHorarios.disabled = true;
                        }
                    } else {
                        selectHorarios.innerHTML = '<option value="">-- Error al cargar horarios --</option>';
                        selectHorarios.disabled = true;
                    }
                }
            };
            
            xhr.send();
        }
    </script>
</body>
</html>