/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import mundo.Conexion;


/**
 *
 * @author julia
 */
@WebServlet("/verVentas")
public class VerVentasServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String[]> compras = new ArrayList<>();
        
        try {
            // Obtener conexión y datos de la base de datos
            Connection conn = Conexion.getConnection();
            String sql = "SELECT producto_nombre, cantidad, fecha FROM compras ORDER BY fecha DESC";
            Statement statement = conn.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                String producto = resultSet.getString("producto_nombre");
                int cantidad = resultSet.getInt("cantidad");
                String fecha = resultSet.getString("fecha");

                compras.add(new String[]{producto, String.valueOf(cantidad), fecha});
            }

            resultSet.close();
            statement.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Pasar la lista de compras a la JSP
        request.setAttribute("compras", compras);
        request.getRequestDispatcher("/verVentas.jsp").forward(request, response);
    }
}
