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
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import mundo.Conexion;
/**
 *
 * @author julia
 */
@WebServlet("/InsertProductServlet")
public class InsertProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role"); // Suponiendo que el rol se guarda en la sesión

        // Verificar si el usuario tiene el rol de ADMIN
        if (!"ADMIN".equals(role)) {
            response.getWriter().println("No tienes permiso para insertar productos.");
            return;
        }

        String nombre = request.getParameter("nombre");
        String tipo = request.getParameter("tipo");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        try {
            Connection conn = Conexion.getConnection();
            String sql = "INSERT INTO productos (nombre, tipo, precio, stock) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, nombre);
            statement.setString(2, tipo);
            statement.setDouble(3, precio);
            statement.setInt(4, stock);
            
            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("success.jsp"); // Redirige a una página de éxito
            } else {
                response.getWriter().println("Error al insertar el producto.");
            }
            
            statement.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}