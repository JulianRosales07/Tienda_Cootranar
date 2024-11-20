package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import mundo.Conexion;

@WebServlet("/registerServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Método para cifrar la contraseña usando SHA-256
    private String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes());
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los parámetros del formulario
        String cedula = request.getParameter("cedula").trim();
        String password = request.getParameter("password");
        String roleIdStr = request.getParameter("role_id"); // Obtener role_id desde el formulario

        try {
            // Validar que role_id sea un número
            int roleId = Integer.parseInt(roleIdStr);

            // Cifrar la contraseña antes de guardarla
            String hashedPassword = hashPassword(password);

            // Conexión a la base de datos
            try (Connection conn = Conexion.getConnection()) {
                String sql = "INSERT INTO usuarios (cedula, password, role_id) VALUES (?, ?, ?)";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setString(1, cedula);
                    statement.setString(2, hashedPassword);
                    statement.setInt(3, roleId);

                    // Ejecutar la inserción
                    int rowsInserted = statement.executeUpdate();
                    if (rowsInserted > 0) {
                        // Redirigir al login después de un registro exitoso
                        response.sendRedirect("index.jsp");
                    } else {
                        response.getWriter().println("No se pudo registrar el usuario.");
                    }
                }
            }
        } catch (NumberFormatException e) {
            response.getWriter().println("El ID del rol no es válido.");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error de base de datos: " + e.getMessage());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            response.getWriter().println("Error al cifrar la contraseña: " + e.getMessage());
        }
    }
}
