// Ubicación: hotelweb.models.Venta

package hotelweb.models;

import java.sql.Date;
import java.sql.Time;

public class Venta {

    private int idVenta;
    private String numeroFactura;
    private String fecha;           // Ej: "2025-01-15"
    private String hora;            // Ej: "14:30:45"
    private String cedulaCliente;
    private String nombreCliente;
    private String metodoPago;
    private double subtotal;        // Suma sin IVA
    private double ivaTotal;        // Total de impuestos
    private double totalVenta;      // Subtotal + IVA

    // Constructor vacío
    public Venta() {}

    // Constructor con todos los campos (útil para inserción)
    public Venta(String numeroFactura, String fecha, String hora, String cedulaCliente, 
                 String nombreCliente, String metodoPago, double subtotal, double ivaTotal, double totalVenta) {
        this.numeroFactura = numeroFactura;
        this.fecha = fecha;
        this.hora = hora;
        this.cedulaCliente = cedulaCliente;
        this.nombreCliente = nombreCliente;
        this.metodoPago = metodoPago;
        this.subtotal = subtotal;
        this.ivaTotal = ivaTotal;
        this.totalVenta = totalVenta;
    }

    // --- Getters y Setters ---

    public int getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public String getNumeroFactura() {
        return numeroFactura;
    }

    public void setNumeroFactura(String numeroFactura) {
        this.numeroFactura = numeroFactura;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public String getCedulaCliente() {
        return cedulaCliente;
    }

    public void setCedulaCliente(String cedulaCliente) {
        this.cedulaCliente = cedulaCliente;
    }

    public String getNombreCliente() {
        return nombreCliente;
    }

    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public double getIvaTotal() {
        return ivaTotal;
    }

    public void setIvaTotal(double ivaTotal) {
        this.ivaTotal = ivaTotal;
    }

    public double getTotalVenta() {
        return totalVenta;
    }

    public void setTotalVenta(double totalVenta) {
        this.totalVenta = totalVenta;
    }
}