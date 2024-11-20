package mundo;

public class Compras {
    private String productoNombre;
    private int cantidad;
    private String fecha;

    public Compras(String productoNombre, int cantidad, String fecha) {
        this.productoNombre = productoNombre;
        this.cantidad = cantidad;
        this.fecha = fecha;
    }

    public String getProductoNombre() {
        return productoNombre;
    }

    public void setProductoNombre(String productoNombre) {
        this.productoNombre = productoNombre;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }
}
