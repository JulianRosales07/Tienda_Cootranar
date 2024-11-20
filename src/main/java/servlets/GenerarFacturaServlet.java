package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import mundo.Conexion;

@WebServlet("/generarFacturaServlet")
public class GenerarFacturaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String compraId = request.getParameter("compraId");

        try {
            // Conexión a la base de datos
            Connection conn = Conexion.getConnection();

            // Recuperar los datos de la compra
            String query = "SELECT producto_nombre, cantidad, fecha FROM compras WHERE id = ?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setInt(1, Integer.parseInt(compraId));

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String producto = resultSet.getString("producto_nombre");
                int cantidad = resultSet.getInt("cantidad");
                String fecha = resultSet.getString("fecha");

                // Generar la factura en HTML con mejor estilo
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();

                out.println("<!DOCTYPE html>");
                out.println("<html lang='es'>");
                out.println("<head>");
                out.println("<meta charset='UTF-8'>");
                out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
                out.println("<title>Factura</title>");
                out.println("<style>");
                out.println("body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f4f4f9; color: #333; }");
                out.println("h1 { color: #007bff; }");
                out.println(".factura { max-width: 600px; margin: 50px auto; background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); }");
                out.println(".detalle { margin-top: 20px; padding: 10px 15px; border: 1px solid #ddd; border-radius: 5px; background: #f9f9f9; }");
                out.println(".volver { display: inline-block; margin-top: 20px; padding: 10px 15px; background: #007bff; color: #fff; text-decoration: none; border-radius: 5px; }");
                out.println(".volver:hover { background: #0056b3; }");
                out.println("</style>");
                out.println("</head>");
                out.println("<body>");
                out.println("<div class='factura'>");
                out.println("<h1>Factura de Compra</h1>");
                out.println("<div class='detalle'>");
                out.println("<p><strong>Producto:</strong> " + producto + "</p>");
                out.println("<p><strong>Cantidad:</strong> " + cantidad + "</p>");
                out.println("<p><strong>Fecha:</strong> " + fecha + "</p>");
                out.println("</div>");
                out.println("<a href='verVentas.jsp' class='volver'>Volver</a>");
                out.println("</div>");
                out.println("</body>");
                out.println("</html>");
            } else {
                response.getWriter().println("<p>No se encontró la compra con ID: " + compraId + "</p>");
            }

            resultSet.close();
            statement.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<p>Error al generar la factura: " + e.getMessage() + "</p>");
        }
    }
}
