<%@ page import="java.sql.Connection, java.sql.PreparedStatement" %>
<%@ page import="mundo.Conexion" %>

<%
    String compraId = request.getParameter("compraId");
    if (compraId != null) {
        try {
            Connection conn = Conexion.getConnection();
            String sql = "DELETE FROM compras WHERE id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(compraId));
            int rowsAffected = statement.executeUpdate();
            
            if (rowsAffected > 0) {
                out.println("<p>Compra eliminada exitosamente.</p>");
            } else {
                out.println("<p>No se pudo eliminar la compra.</p>");
            }
            
            statement.close();
            conn.close();
        } catch (Exception e) {
            out.println("<p>Error al eliminar la compra: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>El ID de la compra no está presente.</p>");
    }
%>
