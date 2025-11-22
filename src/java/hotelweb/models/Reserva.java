package hotelweb.models;

public class Reserva {
    private int idReserva;
    private String fechaEntrada;
    private String horaEntrada;
    private String fechaSalida;
    private String horaSalida;
    private String tipoHabitacion;
    private int numHuespedes;
    private String habitacionAsignada;
    private String metodoPago;
    private String estadoReserva;
    private String clienteCedula;

    // Constructor para Registrar (Sin ID)
    public Reserva(String fechaEntrada, String horaEntrada, String fechaSalida, String horaSalida, 
                   String tipoHabitacion, int numHuespedes, String habitacionAsignada, 
                   String metodoPago, String estadoReserva, String clienteCedula) {
        this.fechaEntrada = fechaEntrada;
        this.horaEntrada = horaEntrada;
        this.fechaSalida = fechaSalida;
        this.horaSalida = horaSalida;
        this.tipoHabitacion = tipoHabitacion;
        this.numHuespedes = numHuespedes;
        this.habitacionAsignada = habitacionAsignada;
        this.metodoPago = metodoPago;
        this.estadoReserva = estadoReserva;
        this.clienteCedula = clienteCedula;
    }

    // Constructor para Leer (Con ID)
    public Reserva(int idReserva, String fechaEntrada, String horaEntrada, String fechaSalida, String horaSalida, 
                   String tipoHabitacion, int numHuespedes, String habitacionAsignada, 
                   String metodoPago, String estadoReserva, String clienteCedula) {
        this.idReserva = idReserva;
        this.fechaEntrada = fechaEntrada;
        this.horaEntrada = horaEntrada;
        this.fechaSalida = fechaSalida;
        this.horaSalida = horaSalida;
        this.tipoHabitacion = tipoHabitacion;
        this.numHuespedes = numHuespedes;
        this.habitacionAsignada = habitacionAsignada;
        this.metodoPago = metodoPago;
        this.estadoReserva = estadoReserva;
        this.clienteCedula = clienteCedula;
    }

    public Reserva() {}

    // Getters y Setters
    public int getIdReserva() { return idReserva; }
    public void setIdReserva(int idReserva) { this.idReserva = idReserva; }
    public String getFechaEntrada() { return fechaEntrada; }
    public void setFechaEntrada(String fechaEntrada) { this.fechaEntrada = fechaEntrada; }
    public String getHoraEntrada() { return horaEntrada; }
    public void setHoraEntrada(String horaEntrada) { this.horaEntrada = horaEntrada; }
    public String getFechaSalida() { return fechaSalida; }
    public void setFechaSalida(String fechaSalida) { this.fechaSalida = fechaSalida; }
    public String getHoraSalida() { return horaSalida; }
    public void setHoraSalida(String horaSalida) { this.horaSalida = horaSalida; }
    public String getTipoHabitacion() { return tipoHabitacion; }
    public void setTipoHabitacion(String tipoHabitacion) { this.tipoHabitacion = tipoHabitacion; }
    public int getNumHuespedes() { return numHuespedes; }
    public void setNumHuespedes(int numHuespedes) { this.numHuespedes = numHuespedes; }
    public String getHabitacionAsignada() { return habitacionAsignada; }
    public void setHabitacionAsignada(String habitacionAsignada) { this.habitacionAsignada = habitacionAsignada; }
    public String getMetodoPago() { return metodoPago; }
    public void setMetodoPago(String metodoPago) { this.metodoPago = metodoPago; }
    public String getEstadoReserva() { return estadoReserva; }
    public void setEstadoReserva(String estadoReserva) { this.estadoReserva = estadoReserva; }
    public String getCedulaCliente() { return clienteCedula; }
    public void setCedulaCliente(String clienteCedula) { this.clienteCedula = clienteCedula; }
}