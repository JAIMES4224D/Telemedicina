<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.io.*, javax.servlet.http.Part"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Datos del Formulario Recibidos</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <style>
        :root{
            --primary: #1a7cc9;
            --secondary: #2c3e50;
            --accent: #2ecc71;
            --light: #f8f9fa;
            --dark: #343a40;
            --danger: #e74c3c;
        }
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body{
            font-family: 'Open Sans', sans-serif;
            color: #333;
            line-height: 1.6;
            background-color: #f0f7fd;
        }
        h1, h2, h3, h4, h5, h6{
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            color: var(--secondary);
        }
        
        .container {
            max-width: 1000px;
            margin: 2rem auto;
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .header {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--primary);
        }
        
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
        }
        
        .data-table th, .data-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        .data-table th {
            background-color: var(--primary);
            color: white;
            font-weight: 600;
        }
        
        .data-table tr:hover {
            background-color: #f9f9f9;
        }
        
        .value-cell {
            font-weight: bold;
            color: var(--secondary);
        }
        
        .null-value {
            color: var(--danger);
            font-style: italic;
        }
        
        .file-info {
            background-color: #e8f4fc;
            padding: 10px;
            border-radius: 5px;
            margin-top: 5px;
        }
        
        .back-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: var(--primary);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin-top: 1rem;
        }
        
        .back-button:hover {
            background-color: #1565a7;
        }
        
        .warning {
            background-color: #fff3cd;
            color: #856404;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #ffeeba;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📋 Datos Recibidos del Formulario</h1>
            <p>Valores recibidos desde el formulario de registro</p>
        </div>
        
        <%
            // Verificar si es una solicitud multipart
            String contentType = request.getContentType();
            boolean isMultipart = contentType != null && contentType.toLowerCase().contains("multipart/form-data");
            
            if (isMultipart) {
                try {
                    // Obtener las partes del request
                    Collection<Part> parts = request.getParts();
        %>
        
        <h2>✅ Datos Recibidos Correctamente:</h2>
        <table class="data-table">
            <tr>
                <th>Campo</th>
                <th>Valor</th>
            </tr>
            <%
                for (Part part : parts) {
                    String fieldName = part.getName();
                    String fieldValue = "";
                    
                    if (part.getContentType() == null) {
                        // Es un campo de texto normal - LEER SU VALOR REAL
                        InputStream inputStream = part.getInputStream();
                        StringBuilder valueBuilder = new StringBuilder();
                        try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"))) {
                            String line;
                            while ((line = reader.readLine()) != null) {
                                valueBuilder.append(line);
                            }
                        }
                        fieldValue = valueBuilder.toString();
                    } else {
                        // Es un archivo
                        fieldValue = "ARCHIVO: " + part.getSubmittedFileName() + " (" + part.getSize() + " bytes)";
                    }
            %>
            <tr>
                <td><strong><%= fieldName %></strong></td>
                <td class="value-cell">
                    <% 
                        if (fieldValue.isEmpty()) {
                            out.print("<span class='null-value'>VACÍO</span>");
                        } else {
                            out.print(fieldValue);
                        }
                    %>
                </td>
            </tr>
            <%
                }
            %>
        </table>
        
        <%
                } catch (Exception e) {
                    out.println("<div class='warning'><strong>❌ Error al procesar partes multipart:</strong> " + e.getMessage() + "</div>");
                }
            } else {
                // No es multipart - mostrar parámetros normales
        %>
        
        <div class="warning">
            <strong>⚠️ ADVERTENCIA:</strong> Esta no es una solicitud multipart. 
            Content-Type: <%= contentType != null ? contentType : "N/A" %>
        </div>
        
        <h2>Parámetros del Request (getParameter):</h2>
        <table class="data-table">
            <tr>
                <th>Campo</th>
                <th>Valor (getParameter)</th>
            </tr>
            <%
                Enumeration<String> paramNames = request.getParameterNames();
                if (paramNames.hasMoreElements()) {
                    while (paramNames.hasMoreElements()) {
                        String paramName = paramNames.nextElement();
                        String paramValue = request.getParameter(paramName);
            %>
            <tr>
                <td><strong><%= paramName %></strong></td>
                <td class="value-cell">
                    <% 
                        if (paramValue == null || paramValue.isEmpty()) {
                            out.print("<span class='null-value'>VACÍO</span>");
                        } else {
                            out.print(paramValue);
                        }
                    %>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="2" style="text-align: center;">No se encontraron parámetros via request.getParameter()</td>
            </tr>
            <%
                }
            %>
        </table>
        
        <%
            }
        %>
        
        <div style="margin-top: 30px; padding: 15px; background-color: #f8f9fa; border-radius: 5px;">
            <h3>📝 Información de la solicitud:</h3>
            <p><strong>Método:</strong> <%= request.getMethod() %></p>
            <p><strong>Content-Type:</strong> <%= contentType %></p>
            <p><strong>Tamaño:</strong> <%= request.getContentLength() %> bytes</p>
        </div>
        
        <a href="javascript:history.back()" class="back-button">← Volver al formulario</a>
    </div>
</body>
</html>