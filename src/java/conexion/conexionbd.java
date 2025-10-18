/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conexion;
import java.sql.*;
/**
 *
 * @author JEJALUOS
 */
public class conexionbd {
    public static String URL = "jdbc:mysql://localhost:3306/telemedicina1";
    public static String USER = "root";
    public static String PASSW = "";
    public Connection getConexion(){
        Connection cn = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            cn = DriverManager.getConnection(URL, USER, PASSW);
            System.out.println("Conexion con exito");
        }catch(Exception e){
            System.out.println("No hay conexion porque: " + e);
            e.printStackTrace();
        }
        return cn;
    }
}
