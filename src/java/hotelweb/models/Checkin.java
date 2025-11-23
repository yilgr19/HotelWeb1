package hotelweb.models;

public class Checkin {
    private int idCheckin;
    private String fechaEntrada;
    private String horaEntrada;
    private String fechaSalida;
    private String horaSalida;
    private String tiempoEstadia;
    private String numHabitacion;
    private String tipoHabitacion;
    private double precioNoche;
    private double costoTotal;
    private String estadoPago;
    private String clienteCedula;
    private String clienteNombre;
    private String clienteApellido;
    private String clienteTelefono;
    private String observaciones;

    public Checkin() {}

    // ESTE ES EL CONSTRUCTOR QUE TE FALTABA O ESTABA DIFERENTE
    // (Son 15 variables en total, en este orden exacto)
    public Checkin(String fechaEntrada, String horaEntrada, String fechaSalida, String horaSalida, 
                   String tiempoEstadia, String numHabitacion, String tipoHabitacion, double precioNoche, 
                   double costoTotal, String estadoPago, String clienteCedula, String clienteNombre, 
                   String clienteApellido, String clienteTelefono, String observaciones) {
        this.fechaEntrada = fechaEntrada;
        this.horaEntrada = horaEntrada;
        this.fechaSalida = fechaSalida;
        this.horaSalida = horaSalida;
        this.tiempoEstadia = tiempoEstadia;
        this.numHabitacion = numHabitacion;
        this.tipoHabitacion = tipoHabitacion;
        this.precioNoche = precioNoche;
        this.costoTotal = costoTotal;
        this.estadoPago = estadoPago;
        this.clienteCedula = clienteCedula;
        this.clienteNombre = clienteNombre;
        this.clienteApellido = clienteApellido;
        this.clienteTelefono = clienteTelefono;
        this.observaciones = observaciones;
    }

    // GETTERS Y SETTERS
    public int getIdCheckin() { return idCheckin; }
    public void setIdCheckin(int idCheckin) { this.idCheckin = idCheckin; } // <--- ESTE ES IMPORTANTE PARA EL DAO

    public String getFechaEntrada() { return fechaEntrada; }
    public void setFechaEntrada(String fechaEntrada) { this.fechaEntrada = fechaEntrada; }

    public String getHoraEntrada() { return horaEntrada; }
    public void setHoraEntrada(String horaEntrada) { this.horaEntrada = horaEntrada; }

    public String getFechaSalida() { return fechaSalida; }
    public void setFechaSalida(String fechaSalida) { this.fechaSalida = fechaSalida; }

    public String getHoraSalida() { return horaSalida; }
    public void setHoraSalida(String horaSalida) { this.horaSalida = horaSalida; }

    public String getTiempoEstadia() { return tiempoEstadia; }
    public void setTiempoEstadia(String tiempoEstadia) { this.tiempoEstadia = tiempoEstadia; }

    public String getNumHabitacion() { return numHabitacion; }
    public void setNumHabitacion(String numHabitacion) { this.numHabitacion = numHabitacion; }

    public String getTipoHabitacion() { return tipoHabitacion; }
    public void setTipoHabitacion(String tipoHabitacion) { this.tipoHabitacion = tipoHabitacion; }

    public double getPrecioNoche() { return precioNoche; }
    public void setPrecioNoche(double precioNoche) { this.precioNoche = precioNoche; }

    public double getCostoTotal() { return costoTotal; }
    public void setCostoTotal(double costoTotal) { this.costoTotal = costoTotal; }

    public String getEstadoPago() { return estadoPago; }
    public void setEstadoPago(String estadoPago) { this.estadoPago = estadoPago; }

    public String getClienteCedula() { return clienteCedula; }
    public void setClienteCedula(String clienteCedula) { this.clienteCedula = clienteCedula; }

    public String getClienteNombre() { return clienteNombre; }
    public void setClienteNombre(String clienteNombre) { this.clienteNombre = clienteNombre; }

    public String getClienteApellido() { return clienteApellido; }
    public void setClienteApellido(String clienteApellido) { this.clienteApellido = clienteApellido; }

    public String getClienteTelefono() { return clienteTelefono; }
    public void setClienteTelefono(String clienteTelefono) { this.clienteTelefono = clienteTelefono; }

    public String getObservaciones() { return observaciones; }
    public void setObservaciones(String observaciones) { this.observaciones = observaciones; }
}