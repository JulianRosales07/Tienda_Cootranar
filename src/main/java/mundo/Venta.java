/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package mundo;

public class Venta {
    private String id;
    private String fecha;
    private String nombreProducto;
    private double precio;
    private int cantidad;
    private double total;

    public Venta(String id, String fecha, String nombreProducto, double precio, int cantidad, double total) {
        this.id = id;
        this.fecha = fecha;
        this.nombreProducto = nombreProducto;
        this.precio = precio;
        this.cantidad = cantidad;
        this.total = total;
    }

    // Getters
    public String getId() {
        return id;
    }

    public String getFecha() {
        return fecha;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public double getPrecio() {
        return precio;
    }

    public int getCantidad() {
        return cantidad;
    }

    public double getTotal() {
        return total;
    }
}
