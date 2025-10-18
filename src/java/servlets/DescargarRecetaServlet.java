/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import DAO.listar;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.receta;

/**
 *
 * @author JEJALUOS
 */
@WebServlet(name = "DescargarRecetaServlet", urlPatterns = {"/DescargarRecetaServlet"})
public class DescargarRecetaServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        generarPDF(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        generarPDF(request, response);
    }

    private void generarPDF(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        // Obtener el ID de la receta desde los parámetros
        String idReceta = request.getParameter("idReceta");
        Integer intReceta = Integer.parseInt(idReceta);
        listar l = new listar();
        List<receta> lista = l.listarReceta(intReceta);
        String paciente = "";
        String medico = "";
        String diagnostico = "";
        String medicamento = "";
        Timestamp fecha = null;
        double total = 00.0;
        
        for(receta c : lista){
            paciente = c.getNombrePaciente();
            medico = c.getNombreMedico();
            diagnostico = c.getDiagnostico();
            medicamento = c.getMedicamento();
            fecha = c.getFecha();
        }
        
        // Configurar la respuesta para descargar un PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=receta_medica_" + idReceta + ".pdf");
        
        try {
            // Crear el documento PDF con iText 5
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();
            
            // Configurar fuentes
            Font fontHeader = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14);
            Font fontNormal = FontFactory.getFont(FontFactory.HELVETICA, 12);
            Font fontTitle = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18);
            Font fontMedicamento = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
            Font fontDetalle = FontFactory.getFont(FontFactory.HELVETICA, 10);
            
            // Título
            Paragraph title = new Paragraph("RECETA MÉDICA", fontTitle);
            title.setAlignment(Paragraph.ALIGN_CENTER);
            title.setSpacingAfter(20);
            document.add(title);
            
            // Crear tabla para la información básica
            PdfPTable table = new PdfPTable(2);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10f);
            table.setSpacingAfter(10f);
            
            // Llenar la tabla con información
            addTableRow(table, "Paciente:", paciente, fontHeader, fontNormal);
            addTableRow(table, "Médico:", medico, fontHeader, fontNormal);
            addTableRow(table, "Fecha:", fecha.toString(), fontHeader, fontNormal);
            addTableRow(table, "Diagnóstico:", diagnostico, fontHeader, fontNormal);
            
            document.add(table);
            
            // Agregar sección de medicamentos
            Paragraph medicamentosTitle = new Paragraph("Medicamentos Recetados", fontHeader);
            medicamentosTitle.setSpacingBefore(15);
            medicamentosTitle.setSpacingAfter(10);
            document.add(medicamentosTitle);
            
            // Parsear y formatear medicamentos
            if (medicamento != null && !medicamento.isEmpty()) {
                try {
                    // Eliminar corchetes externos
                    String contenido = medicamento.substring(1, medicamento.length() - 1);
                    
                    // Dividir por los objetos individuales
                    String[] objetos = contenido.split("\\},\\{");
                    
                    for (int i = 0; i < objetos.length; i++) {
                        String objeto = objetos[i];
                        if (i > 0) {
                            objeto = "{" + objeto;
                        }
                        if (i < objetos.length - 1) {
                            objeto = objeto + "}";
                        }
                        
                        // Extraer los valores manualmente
                        String nombreMedicamento = extraerValor(objeto, "medicamento");
                        String dosis = extraerValor(objeto, "dosis");
                        String frecuencia = extraerValor(objeto, "frecuencia");
                        
                        // Agregar medicamento al PDF
                        Paragraph medParagraph = new Paragraph();
                        medParagraph.add(new Chunk("• " + nombreMedicamento + " ", fontMedicamento));
                        medParagraph.add(new Chunk("(Dosis: " + dosis + ", Frecuencia: " + frecuencia + ")", fontDetalle));
                        medParagraph.setSpacingAfter(5);
                        document.add(medParagraph);
                    }
                } catch (Exception e) {
                    Paragraph errorParagraph = new Paragraph("Error al procesar medicamentos: " + e.getMessage(), fontNormal);
                    document.add(errorParagraph);
                }
            } else {
                Paragraph noMedicamentos = new Paragraph("No se prescribieron medicamentos", fontNormal);
                document.add(noMedicamentos);
            }
            
            // Añadir espacio y firma
            document.add(new Paragraph(" "));
            document.add(new Paragraph(" "));
            Paragraph firma = new Paragraph("Firma del Médico: ________________________", fontNormal);
            firma.setAlignment(Paragraph.ALIGN_RIGHT);
            document.add(firma);
            
            // Cerrar documento
            document.close();
            
        } catch (DocumentException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al generar el PDF");
        }
    }
    
    // Método auxiliar para extraer valores del JSON manualmente
    private String extraerValor(String objeto, String clave) {
        try {
            String clavePattern = "\"" + clave + "\":\"";
            int startIndex = objeto.indexOf(clavePattern) + clavePattern.length();
            int endIndex = objeto.indexOf("\"", startIndex);
            return objeto.substring(startIndex, endIndex);
        } catch (Exception e) {
            return "N/A";
        }
    }
    
    private void addTableRow(PdfPTable table, String header, String content, Font headerFont, Font contentFont) {
        table.addCell(new Paragraph(header, headerFont));
        table.addCell(new Paragraph(content, contentFont));
    }
}
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
   


