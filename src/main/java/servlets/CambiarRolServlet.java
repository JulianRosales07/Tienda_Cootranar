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
import java.sql.SQLException;
import mundo.Conexion;

@WebServlet("/cambiarRolServlet")
public class CambiarRolServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int usuarioId = Integer.parseInt(request.getParameter("usuarioId"));
        String nuevoRol = request.getParameter("nuevoRol");

        try (Connection conn = Conexion.getConnection()) {
            String sql = "UPDATE usuarios SET role = ? WHERE cedula = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, nuevoRol);
                stmt.setInt(2, usuarioId);
                stmt.executeUpdate();
            }
            response.sendRedirect("cambiarRol.jsp?success=true");
        } catch (SQLException e) {
            response.sendRedirect("cambiarRol.jsp?error=true");
        }
    }
}
