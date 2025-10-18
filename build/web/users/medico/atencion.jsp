<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="modelo.citaMedica"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Atención de Cita Médica</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
        <style>
            :root {
                --primary: #1a7cc9;
                --primary-dark: #1565a3;
                --primary-light: #e1f0fa;
                --secondary: #2c3e50;
                --accent: #2ecc71;
                --accent-dark: #27ae60;
                --danger: #e74c3c;
                --warning: #f39c12;
                --gray-100: #f8f9fa;
                --gray-200: #e9ecef;
                --gray-300: #dee2e6;
            }
            
            body {
                background-color: #f5f9fc;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                padding: 20px;
            }
            
            .card {
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.07);
                margin-bottom: 20px;
                border: none;
            }
            
            .card-header {
                background-color: var(--primary);
                color: white;
                border-radius: 12px 12px 0 0 !important;
                font-weight: 600;
            }
            
            .btn-primary {
                background-color: var(--primary);
                border: none;
            }
            
            .btn-primary:hover {
                background-color: var(--primary-dark);
            }
            
            .btn-success {
                background-color: var(--accent);
                border: none;
            }
            
            .btn-success:hover {
                background-color: var(--accent-dark);
            }
            
            .cita-info {
                background-color: var(--gray-100);
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 15px;
            }
            
            .medicamento-row {
                margin-bottom: 15px;
                padding: 15px;
                border: 1px solid var(--gray-300);
                border-radius: 8px;
                background-color: var(--gray-100);
            }
            
            .btn-remove {
                color: var(--danger);
                background: none;
                border: none;
                font-size: 1.2rem;
            }
            
            .section-title {
                color: var(--primary);
                border-bottom: 2px solid var(--primary-light);
                padding-bottom: 10px;
                margin-bottom: 20px;
            }
            
            .error-container {
                text-align: center;
                padding: 40px;
                background-color: white;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.07);
                margin-top: 50px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <%
                List<citaMedica> lista = (List<citaMedica>) request.getAttribute("listaCitaAtencion");
                
                // Verificar si la lista es nula o vacía
                if (lista == null || lista.isEmpty()) {
            %>
                <div class="error-container">
                    <i class="bi bi-exclamation-triangle" style="font-size: 3rem; color: var(--danger);"></i>
                    <h2 class="mt-3">Error al cargar la cita</h2>
                    <p class="text-muted">No se pudo encontrar la información de la cita médica.</p>
                    <p>Posibles causas:</p>
                    <ul class="text-start">
                        <li>La cita no existe en el sistema</li>
                        <li>Error de conexión con la base de datos</li>
                        <li>Problemas de permisos de acceso</li>
                    </ul>
                    <div class="mt-4">
                        <a href="javascript:history.back()" class="btn btn-primary">
                            <i class="bi bi-arrow-left"></i> Volver atrás
                        </a>
                        <a href="<%= request.getContextPath() %>/controlMedico?acc=misCitas&idMedico=<%= session.getAttribute("idMedico") %>" class="btn btn-secondary ms-2">
                            <i class="bi bi-calendar-check"></i> Ver mis citas
                        </a>
                    </div>
                </div>
            <%
                } else {
                    citaMedica c = lista.get(0);
                    int id = c.getId();
System.out.println("id = " + id);
                    int idMedico = c.getIdMedico();
System.out.println("idMedico = " + idMedico);
                    int idPaciente = c.getIdPaciente();
System.out.println("idPaciente = " + idPaciente);
                    int idEnlace = c.getIdEnlace();
System.out.println("idEnlace = " + idEnlace);
                    Date horaInicio = c.getHoraInicio();
                    Date horaFin = c.getHoraFin();
                    String estado = c.getEstado();
System.out.println("estado = " + estado);
                    Date fechaRegistro = c.getFechaRegistro();
                    double precio = c.getPrecio();
System.out.println("precio = " + precio);
                    String enlace = c.getEnlace();
System.out.println("enlace = " + enlace);
                    String medico = c.getNombreMedico();
System.out.println("medico = " + medico);
                    String paciente = c.getNombrePaciente();
System.out.println("paciente =" + paciente);
                    String especialidad = c.getNombreEspecialidad();
System.out.println("especialidad = " + especialidad);

            %>
            
            <div class="row mb-4">
                <div class="col">
                    <h1 class="text-center"><i class="bi bi-heart-pulse"></i> Atención de Cita Médica</h1>
                </div>
            </div>
            
            <form action="<%= request.getContextPath() %>/ProcesarAtencionCita" method="post">
                <input type="hidden" name="idCita" value="<%= id %>">
                <input type="hidden" name="idMedico" value="<%= idMedico %>">
                <input type="hidden" name="idPaciente" value="<%= idPaciente %>">
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <i class="bi bi-info-circle"></i> Información de la Cita
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="cita-info">
                                            <h6><i class="bi bi-person"></i> Paciente</h6>
                                            <p class="fw-bold"><%= paciente %></p>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="cita-info">
                                            <h6><i class="bi bi-person-badge"></i> Médico</h6>
                                            <p class="fw-bold"><%= medico %></p>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="cita-info">
                                            <h6><i class="bi bi-calendar"></i> Fecha y Hora</h6>
                                            <p class="fw-bold"><%= horaInicio %> - <%= horaFin %></p>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="cita-info">
                                            <h6><i class="bi bi-bookmark"></i> Especialidad</h6>
                                            <p class="fw-bold"><%= especialidad %></p>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="cita-info">
                                    <h6><i class="bi bi-link"></i> Enlace de la Consulta</h6>
                                    <p class="fw-bold"><a href="<%= enlace %>" target="_blank"><%= enlace %></a></p>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="estado" class="form-label">Estado de la Cita</label>
                                    <select class="form-select" id="estado" name="estado" required>
                                        <option value="Proceso" <%= "Proceso".equals(estado) ? "selected" : "" %>>En Proceso</option>
                                        <option value="Completada" <%= "Completada".equals(estado) ? "selected" : "" %>>Completada</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <i class="bi bi-clipboard-plus"></i> Diagnóstico
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <label for="sintomas" class="form-label">Síntomas</label>
                                    <textarea class="form-control" id="sintomas" name="sintomas" rows="3" placeholder="Describa los síntomas presentados por el paciente"></textarea>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="diagnostico" class="form-label">Diagnóstico</label>
                                    <textarea class="form-control" id="diagnostico" name="diagnostico" rows="3" placeholder="Ingrese el diagnóstico" required></textarea>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="observaciones" class="form-label">Observaciones</label>
                                    <textarea class="form-control" id="observaciones" name="observaciones" rows="2" placeholder="Observaciones adicionales"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="card mt-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="bi bi-capsule"></i> Receta Médica</span>
                        <button type="button" class="btn btn-sm btn-primary" id="btnAddMedicamento">
                            <i class="bi bi-plus-circle"></i> Agregar Medicamento
                        </button>
                    </div>
                    <div class="card-body">
                        <div id="medicamentos-container">
                            <div class="medicamento-row">
                                <div class="row">
                                    <div class="col-md-5">
                                        <div class="mb-3">
                                            <label class="form-label">Medicamento</label>
                                            <input type="text" class="form-control" name="medicamento[]" placeholder="Nombre del medicamento" required>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="mb-3">
                                            <label class="form-label">Dosis</label>
                                            <input type="text" class="form-control" name="dosis[]" placeholder="Ej: 500mg" required>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="mb-3">
                                            <label class="form-label">Frecuencia</label>
                                            <input type="text" class="form-control" name="frecuencia[]" placeholder="Ej: Cada 8 horas" required>
                                        </div>
                                    </div>
                                    <div class="col-md-1">
                                        <div class="mb-3">
                                            <label class="form-label">&nbsp;</label>
                                            <button type="button" class="btn btn-remove" disabled>
                                                <i class="bi bi-x-circle"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row mt-4">
                    <div class="col text-center">
                        <button type="submit" class="btn btn-success btn-lg">
                            <i class="bi bi-check-circle"></i> Guardar Atención
                        </button>
                        <a href="<%= request.getContextPath() %>/controlMedico?acc=misCitas&idMedico=<%= session.getAttribute("idMedico") %>" class="btn btn-secondary btn-lg ms-2">
                            <i class="bi bi-arrow-left"></i> Volver
                        </a>
                    </div>
                </div>
            </form>
            <%
                } // Fin del else (cuando la lista no es nula)
            %>
        </div>
        
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Contador para IDs únicos
                let medicamentoCount = 1;
                
                // Función para agregar un nuevo medicamento
                const btnAddMedicamento = document.getElementById('btnAddMedicamento');
                if (btnAddMedicamento) {
                    btnAddMedicamento.addEventListener('click', function() {
                        const container = document.getElementById('medicamentos-container');
                        if (container) {
                            const newRow = document.createElement('div');
                            newRow.className = 'medicamento-row';
                            newRow.innerHTML = `
                                <div class="row">
                                    <div class="col-md-5">
                                        <div class="mb-3">
                                            <label class="form-label">Medicamento</label>
                                            <input type="text" class="form-control" name="medicamento[]" placeholder="Nombre del medicamento" required>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="mb-3">
                                            <label class="form-label">Dosis</label>
                                            <input type="text" class="form-control" name="dosis[]" placeholder="Ej: 500mg" required>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="mb-3">
                                            <label class="form-label">Frecuencia</label>
                                            <input type="text" class="form-control" name="frecuencia[]" placeholder="Ej: Cada 8 horas" required>
                                        </div>
                                    </div>
                                    <div class="col-md-1">
                                        <div class="mb-3">
                                            <label class="form-label">&nbsp;</label>
                                            <button type="button" class="btn btn-remove">
                                                <i class="bi bi-x-circle"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            `;
                            
                            container.appendChild(newRow);
                            
                            // Agregar evento al botón de eliminar
                            const removeBtn = newRow.querySelector('.btn-remove');
                            if (removeBtn) {
                                removeBtn.addEventListener('click', function() {
                                    container.removeChild(newRow);
                                });
                            }
                            
                            medicamentoCount++;
                        }
                    });
                }
                
                // Agregar eventos a los botones de eliminar existentes (excepto el primero)
                const removeButtons = document.querySelectorAll('.btn-remove');
                removeButtons.forEach(btn => {
                    if (!btn.disabled) {
                        btn.addEventListener('click', function() {
                            const row = this.closest('.medicamento-row');
                            if (row && row.parentNode) {
                                row.parentNode.removeChild(row);
                            }
                        });
                    }
                });
            });
        </script>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>