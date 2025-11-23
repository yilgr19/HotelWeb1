<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.dao.UsuarioManager" %>
<%@ page import="hotelweb.dao.ProductoDAO" %>
<%@ page import="hotelweb.models.Categoria" %>
<%@ page import="java.util.List" %>

<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
    if (usuarioLogueado == null) {
        response.sendRedirect("index.jsp?error=sesion_expirada");
        return;
    }
    
    // Cargar categorías para el Select
    ProductoDAO daoCarga = new ProductoDAO();
    List<Categoria> listaCategorias = daoCarga.obtenerCategorias();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #343a40; min-height: 100vh; display: flex; flex-direction: column; }
        main { flex: 1; display: flex; justify-content: center; align-items: center; padding: 20px; }
        .form-container {
            background-color: #212529;
            color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.5);
            width: 100%;
            max-width: 900px;
        }
        .form-header { background-color: #000000; padding: 20px; text-align: center; border-bottom: 1px solid #495057; }
        .form-body { padding: 30px; }
        .form-control, .form-select { background-color: #343a40; border-color: #495057; color: #ffffff; }
        .form-control:focus, .form-select:focus { background-color: #3b4248; border-color: #0d6efd; color: #ffffff; }
        .form-control:read-only { background-color: #2c3034; color: #0dcaf0; font-weight: bold; }
        .btn-custom { width: 100%; margin-bottom: 10px; font-weight: bold; }
    </style>
</head>
<body>

    <main>
        <div class="form-container">
            <div class="form-header">
                <h2 class="mb-0">Registrar Nuevo Producto</h2>
            </div>
            
            <div class="form-body">
                <% 
                    String msj = (String) request.getAttribute("mensaje");
                    String err = (String) request.getAttribute("error");
                    if(msj != null) out.print("<div class='alert alert-success'>" + msj + "</div>");
                    if(err != null) out.print("<div class='alert alert-danger'>" + err + "</div>");
                %>

                <form action="ProductoServlet" method="post">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Código del Producto:</label>
                                <input type="text" class="form-control" name="codigo" placeholder="Ej: REF-001" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Nombre:</label>
                                <input type="text" class="form-control" name="nombre" placeholder="Ej: Coca-Cola 1.5L" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Categoría:</label>
                                <select class="form-select" name="idCategoria" required>
                                    <option value="" disabled selected>Seleccione...</option>
                                    <% for(Categoria c : listaCategorias) { %>
                                        <option value="<%= c.getIdCategoria() %>"><%= c.getNombre() %></option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Descripción:</label>
                                <textarea class="form-control" name="descripcion" rows="3" placeholder="Detalles..."></textarea>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="card bg-secondary bg-opacity-10 border-secondary p-3 mb-3">
                                <h5 class="text-info mb-3">Precios y Existencia</h5>
                                
                                <div class="mb-3">
                                    <label class="form-label text-white">Precio Base (Sin IVA):</label>
                                    <input type="number" class="form-control" id="precioBase" name="precio" step="50" min="0" oninput="calcularTotal()" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-white">IVA (%):</label>
                                    <input type="number" class="form-control" id="impuesto" name="impuesto" min="0" max="100" value="19" oninput="calcularTotal()" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-white">Precio Final:</label>
                                    <input type="text" class="form-control" id="precioFinal" readonly value="0">
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-6 mb-4">
                                    <label class="form-label text-info">Existencia:</label>
                                    <input type="number" class="form-control" name="existencia" min="0" value="0" required>
                                </div>
                                <div class="col-6 mb-4">
                                    <label class="form-label text-danger">Vencimiento:</label>
                                    <input type="date" class="form-control" name="fechaVencimiento">
                                    <small class="text-muted" style="font-size: 0.7rem;">Opcional</small>
                                </div>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" name="accion" value="guardar" class="btn btn-primary btn-custom">Guardar Producto</button>
                                <button type="button" class="btn btn-secondary btn-custom" onclick="window.location.href='Menu.jsp'">Regresar</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function calcularTotal() {
            let base = parseFloat(document.getElementById('precioBase').value) || 0;
            let iva = parseFloat(document.getElementById('impuesto').value) || 0;
            let total = base + (base * (iva / 100));
            document.getElementById('precioFinal').value = total.toLocaleString('es-CO');
        }
    </script>
</body>
</html>