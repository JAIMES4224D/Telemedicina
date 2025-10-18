<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cita Confirmada - Policlínico Wiener Sistem</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Open+Sans:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #1a7cc9;
            --primary-dark: #1565a3;
            --primary-light: #e1f0fa;
            --secondary: #2c3e50;
            --accent: #2ecc71;
            --light: #f8f9fa;
            --dark: #343a40;
            --gray-200: #e9ecef;
            --gray-300: #dee2e6;
            --gray-600: #6c757d;
            --shadow-md: 0 4px 6px rgba(0,0,0,0.07);
            --shadow-lg: 0 10px 15px rgba(0,0,0,0.1);
            --card-border-radius: 16px;
            --border-radius: 12px;
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Open Sans', sans-serif;
            background: linear-gradient(135deg, #f5f9fc 0%, #e1f0fa 100%);
            color: #2c3e50;
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            color: var(--secondary);
        }

        .success-container {
            background: white;
            border-radius: var(--card-border-radius);
            box-shadow: var(--shadow-lg);
            max-width: 650px;
            width: 100%;
            overflow: hidden;
            text-align: center;
            position: relative;
        }

        .success-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 2.5rem 2rem;
            position: relative;
        }

        .success-header::after {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 50%;
            transform: translateX(-50%);
            width: 40px;
            height: 40px;
            background: white;
            border-radius: 50%;
        }

        .success-icon {
            font-size: 5rem;
            margin-bottom: 1rem;
            color: white;
            display: inline-block;
            position: relative;
            z-index: 2;
        }

        .success-header h2 {
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            color: white;
        }

        .success-content {
            padding: 3rem 2.5rem 2.5rem;
        }

        .success-content p {
            font-size: 1.1rem;
            margin-bottom: 1.5rem;
            color: var(--gray-600);
        }

        .confirmation-details {
            background: var(--primary-light);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            margin: 2rem 0;
            text-align: left;
        }

        .confirmation-details h3 {
            font-size: 1.2rem;
            margin-bottom: 1rem;
            color: var(--primary-dark);
            display: flex;
            align-items: center;
        }

        .confirmation-details h3 i {
            margin-right: 0.5rem;
        }

        .detail-item {
            display: flex;
            margin-bottom: 0.8rem;
        }

        .detail-label {
            font-weight: 600;
            min-width: 120px;
            color: var(--secondary);
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .btn-confirm, .btn-cancel {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.8rem 1.8rem;
            border-radius: 30px;
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
            font-size: 1rem;
            border: none;
            cursor: pointer;
        }

        .btn-confirm {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            box-shadow: 0 4px 8px rgba(26, 124, 201, 0.3);
        }

        .btn-confirm:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(26, 124, 201, 0.4);
        }

        .btn-cancel {
            background: white;
            color: var(--primary);
            border: 2px solid var(--primary);
        }

        .btn-cancel:hover {
            background: var(--primary-light);
            transform: translateY(-2px);
        }

        .success-footer {
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--gray-200);
            color: var(--gray-600);
            font-size: 0.9rem;
        }

        /* Animaciones */
        @keyframes checkmarkAnimation {
            0% { transform: scale(0); opacity: 0; }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); opacity: 1; }
        }

        .success-icon {
            animation: checkmarkAnimation 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .success-content {
            animation: fadeInUp 0.6s ease-out 0.3s both;
        }

        /* Responsive */
        @media (max-width: 576px) {
            .success-header {
                padding: 2rem 1.5rem;
            }
            
            .success-content {
                padding: 2.5rem 1.5rem 2rem;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn-confirm, .btn-cancel {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-header">
            <div class="success-icon">
                <i class="bi bi-check-circle-fill"></i>
            </div>
            <h2>¡Cita Confirmada Exitosamente!</h2>
        </div>
        
        <div class="success-content">
            <p>Su cita ha sido registrada en nuestro sistema. Recibirá un correo electrónico con los detalles de su cita.</p>
            <p>Puede ver el estado de sus citas en la sección "Mis Citas".</p>
            
            <div class="confirmation-details">
                <h3><i class="bi bi-info-circle"></i> Información importante</h3>
                <div class="detail-item">
                    <span class="detail-label">Lugar:</span>
                    <span>Consulta Virtual - Plataforma Google Meet</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Recordatorio:</span>
                    <span>Recibirá un recordatorio 24 horas antes de su cita</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Soporte:</span>
                    <span>soporte@wienersistem.com</span>
                </div>
            </div>
            
            <div class="action-buttons">
                <a href="<%= request.getContextPath() %>/inicioPaciente?acc=misCitas" class="btn-confirm">
                    <i class="bi bi-calendar-check"></i> Ver Mis Citas
                </a>
                <a href="<%= request.getContextPath() %>/inicioPaciente?acc=actualizar" class="btn-cancel">
                    <i class="bi bi-house"></i> Volver al Inicio
                </a>
            </div>
            
            <div class="success-footer">
                <p>© 2025 Policlínico Wiener Sistem. Todos los derechos reservados.</p>
            </div>
        </div>
    </div>
</body>
</html>