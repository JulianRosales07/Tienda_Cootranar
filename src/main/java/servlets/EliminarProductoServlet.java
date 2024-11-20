package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import mundo.Conexion;

@WebServlet("/eliminarProducto")
public class EliminarProductoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombreProducto = request.getParameter("nombre");

        try {
            // Conectar a la base de datos
            Connection conn = Conexion.getConnection();
            
            // Consulta para eliminar el producto
            String query = "DELETE FROM productos WHERE nombre = ?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setString(1, nombreProducto);

            // Ejecutar la eliminación
            int rowsAffected = statement.executeUpdate();
            
            if (rowsAffected > 0) {
                response.getWriter().println("<p>Producto eliminado correctamente.</p>");
            } else {
                response.getWriter().println("<p>No se pudo eliminar el producto.</p>");
            }

            statement.close();
            conn.close();
        } catch (Exception e) {
            response.getWriter().println("<p>Error al eliminar el producto: " + e.getMessage() + "</p>");
        }

        // Redirigir de nuevo a la lista de productos después de eliminar
        response.sendRedirect("productos.jsp");
    }
}
