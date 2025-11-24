// Ubicación: hotelweb.models.Producto

package hotelweb.models;

import java.sql.Date; 

public class Producto {

    // Atributos basados en la tabla 'producto' (image_47d9fa.png)
    private int idProducto;
    private String codigo;
    private String nombre;
    private String descripcion;
    private int idCategoria; 
    private double precio;    // Corresponde a precioBase sin impuesto
    private double impuesto;  // Corresponde al porcentaje de IVA
    private int existencia;
    private Date fechaVencimiento; // Tipo java.sql.Date para usar en el DAO

    // Constructor vacío
    public Producto() {}

    // Constructor con campos para la inserción
    public Producto(String codigo, String nombre, String descripcion, int idCategoria, double precio, double impuesto, int existencia, Date fechaVencimiento) {
        this.codigo = codigo;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.idCategoria = idCategoria;
        this.precio = precio;
        this.impuesto = impuesto;
        this.existencia = existencia;
        this.fechaVencimiento = fechaVencimiento;
    }

    // --- Getters y Setters (Los métodos que causaban el error) ---

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public double getImpuesto() {
        return impuesto;
    }

    public void setImpuesto(double impuesto) {
        this.impuesto = impuesto;
    }

    public int getExistencia() {
        return existencia;
    }

    public void setExistencia(int existencia) {
        this.existencia = existencia;
    }

    public Date getFechaVencimiento() {
        return fechaVencimiento;
    }

    public void setFechaVencimiento(Date fechaVencimiento) {
        this.fechaVencimiento = fechaVencimiento;
    }
}