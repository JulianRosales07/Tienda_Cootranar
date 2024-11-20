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

@WebServlet("/EditarProductoServlet")
public class EditarProductoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los parámetros del formulario
        String nombre = request.getParameter("nombre");
        double precio = Double.parseDouble(request.getParameter("precio"));

        try {
            // Conexión a la base de datos
            Connection conn = Conexion.getConnection();

            // Actualizar el producto en la base de datos
            String query = "UPDATE productos SET precio = ? WHERE nombre = ?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setDouble(1, precio);
            statement.setString(2, nombre);

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("productos.jsp");  // Redirige a la lista de productos después de la edición
            } else {
                response.getWriter().println("No se pudo actualizar el producto.");
            }

            statement.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error al actualizar el producto: " + e.getMessage());
        }
    }
}
