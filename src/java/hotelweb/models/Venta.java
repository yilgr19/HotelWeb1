package hotelweb.models;
import java.util.List;

public class Venta {
    private int idVenta;
    private String numFactura;
    private String fecha;
    private String hora;
    private String cedulaCliente;
    private String nombreCliente;
    private String metodoPago;
    private double subtotal;
    private double ivaTotal;
    private double totalVenta;
    private List<DetalleVenta> detalles; // Lista de productos

    public Venta() {}

    public Venta(String numFactura, String fecha, String hora, String cedulaCliente, String nombreCliente, 
                 String metodoPago, double subtotal, double ivaTotal, double totalVenta, List<DetalleVenta> detalles) {
        this.numFactura = numFactura;
        this.fecha = fecha;
        this.hora = hora;
        this.cedulaCliente = cedulaCliente;
        this.nombreCliente = nombreCliente;
        this.metodoPago = metodoPago;
        this.subtotal = subtotal;
        this.ivaTotal = ivaTotal;
        this.totalVenta = totalVenta;
        this.detalles = detalles;
    }

    // Getters necesarios para el DAO y la Factura
    public int getIdVenta() { return idVenta; }
    public void setIdVenta(int idVenta) { this.idVenta = idVenta; }
    public String getNumFactura() { return numFactura; }
    public String getFecha() { return fecha; }
    public String getHora() { return hora; }
    public String getCedulaCliente() { return cedulaCliente; }
    public String getNombreCliente() { return nombreCliente; }
    public String getMetodoPago() { return metodoPago; }
    public double getSubtotal() { return subtotal; }
    public double getIvaTotal() { return ivaTotal; }
    public double getTotalVenta() { return totalVenta; }
    public List<DetalleVenta> getDetalles() { return detalles; }
}