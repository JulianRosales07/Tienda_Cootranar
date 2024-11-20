package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import mundo.Conexion;

/**
 * Servlet para registrar compras
 */
@WebServlet("/comprarServlet")
public class ComprarServlet extends HttpServlet {
    
    // Método que maneja las solicitudes POST
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombreProducto = request.getParameter("productoNombre");
        String cantidadStr = request.getParameter("cantidad");

        if (nombreProducto != null && cantidadStr != null) {
            try {
                int cantidad = Integer.parseInt(cantidadStr);

                // Registrar la compra en la base de datos
                boolean compraExitosa = registrarCompra(nombreProducto, cantidad);

                if (compraExitosa) {
                    // Redirigir al JSP de compras para mostrar las compras registradas
                    response.sendRedirect("verVentas.jsp");
                } else {
                    response.getWriter().println("Error al realizar la compra. Verifica la información.");
                }
            } catch (NumberFormatException e) {
                response.getWriter().println("La cantidad debe ser un número válido.");
            } catch (Exception e) {
                response.getWriter().println("Ocurrió un error: " + e.getMessage());
                e.printStackTrace(response.getWriter());
            }
        } else {
            response.getWriter().println("No se especificó el nombre del producto o la cantidad.");
        }
    }

    // Método para registrar la compra en la base de datos
    private boolean registrarCompra(String nombreProducto, int cantidad) {
        boolean resultado = false;
        try (Connection conn = Conexion.getConnection()) {
            // Insertar la compra en la tabla `compras`
            String sql = "INSERT INTO compras (producto_nombre, cantidad, fecha) VALUES (?, ?, NOW())";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, nombreProducto);
                ps.setInt(2, cantidad);

                int filasInsertadas = ps.executeUpdate();
                resultado = filasInsertadas > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultado;
    }
}
