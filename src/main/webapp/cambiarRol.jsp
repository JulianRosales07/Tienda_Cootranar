<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="mundo.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<body>
    <h1>Lista de Usuarios</h1>
    <table>
        <thead>
            <tr>
                <th>Nombre</th>
                <th>Cédula</th>
                <th>Rol</th>
                <th>Fecha de Creación</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // Lógica de conexión y obtención de usuarios
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/station", "usuario", "contraseña");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT cedula, password, role, created_at FROM usuarios");

                while (rs.next()) {
                    int cedula = rs.getInt("cedula");
                    String password = rs.getString("password");
                    String role = rs.getString("role");
                    Timestamp createdAt = rs.getTimestamp("created_at");

                    Usuario usuario = new Usuario(cedula, password, role, createdAt);
            %>
                <tr>
                    <td><%= usuario.getCedula() %></td>
                    <td><%= usuario.getCedula() %></td>
                    <td><%= usuario.getRole() %></td>
                    <td><%= usuario.getCreatedAt() %></td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
