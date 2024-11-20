package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import mundo.Conexion;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
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

        try {
            // Conexión a la base de datos
            Connection conn = Conexion.getConnection();
            String sql = "SELECT password, role FROM usuarios WHERE cedula = ?"; // Actualizado a 'usuarios' y 'cedula'
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, cedula);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String storedPassword = resultSet.getString("password");
                String role = resultSet.getString("role");

                // Validar la contraseña
                if (storedPassword.equals(hashPassword(password))) {
                    // Crear sesión y guardar el rol del usuario
                    // Crear sesión y guardar el rol del usuario
                HttpSession session = request.getSession();
                session.setAttribute("usuarioRol", role); // Cambiado a 'usuarioRol' para coincidir con la JSP
                session.setAttribute("cedula", cedula); // Guardar cédula para futuras referencias
                response.sendRedirect("Inicio.jsp"); // Redirigir a la página principal
                } else {
                    response.getWriter().println("Contraseña incorrecta.");
                }
            } else {
                response.getWriter().println("El usuario con esta cédula no existe.");
            }

            // Cerrar recursos
            resultSet.close();
            statement.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}