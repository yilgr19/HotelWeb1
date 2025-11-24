<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.dao.VentaDAO" %>
<jsp:useBean id="daoV" class="hotelweb.dao.VentaDAO" scope="page" />
<%
    // 1. SEGURIDAD
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
    if (usuarioLogueado == null) { response.sendRedirect("index.jsp?error=sesion_expirada"); return; }
    
    // 2. Obtener el número de factura
    String proxFactura = daoV.generarNumeroFactura();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nueva Venta</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style> 
        body { background-color: #343a40; color: white; } 
        .form-control[readonly] { background-color: #495057; color: #fff; }
    </style>
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center mb-3">Registro de Ventas</h2>
        
        <% String err = (String) request.getAttribute("error"); 
           if(err!=null) out.print("<div class='alert alert-danger'>"+err+"</div>"); %>
        
        <form id="formVenta" action="VentaServlet" method="POST">
            <div class="row mb-4 bg-dark p-3 rounded">
                <div class="col-md-3">
                    <label for="numFactura" class="form-label">Factura No:</label>
                    <input type="text" id="numFactura" name="numFactura" class="form-control" value="<%= proxFactura %>" readonly>
                </div>
                
                <div class="col-md-5">
                    <label for="txtCedulaCliente" class="form-label">Cédula del Cliente (Buscar):</label>
                    <div class="input-group">
                        <input type="text" id="txtCedulaCliente" name="cedulaCliente" class="form-control" required onblur="buscarCliente()" onkeyup="if(event.keyCode==13){ event.preventDefault(); buscarCliente(); }">
                        <button type="button" class="btn btn-outline-light" onclick="buscarCliente()">🔍</button>
                    </div>
                    <small id="clienteFeedback" class="text-warning"></small>
                </div>
                
                <div class="col-md-4">
                    <label for="txtNombreCliente" class="form-label">Nombre del Cliente:</label>
                    <input type="text" id="txtNombreCliente" name="nombreCliente" class="form-control" readonly required>
                </div>
                
                <input type="hidden" id="txtTelefonoCliente" name="telefonoCliente">
                <input type="hidden" id="txtDireccionCliente" name="direccionCliente">
                <input type="hidden" id="txtCorreoCliente" name="correoCliente">
            </div>

            <div class="row mb-4 bg-dark p-3 rounded">
                <div class="col-md-3">
                    <label for="txtCodigo" class="form-label">Código Producto (Buscar):</label>
                    <input type="text" id="txtCodigo" class="form-control" onkeyup="if(event.keyCode==13){ event.preventDefault(); buscarProducto(); }">
                </div>
                <div class="col-md-3">
                    <label for="txtCantidad" class="form-label">Cantidad:</label>
                    <input type="number" id="txtCantidad" class="form-control" value="1" min="1" onkeyup="if(event.keyCode==13){ event.preventDefault(); agregarProducto(); }">
                </div>
                <div class="col-md-4">
                    <label for="txtDisplayInfo" class="form-label">Info Producto:</label>
                    <input type="text" id="txtDisplayInfo" class="form-control" readonly placeholder="Nombre, Precio, Stock">
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button type="button" class="btn btn-success w-100" onclick="agregarProducto()">➕ Agregar</button>
                </div>
            </div>

            <div class="table-responsive mb-4">
                <table class="table table-dark table-striped">
                    <thead>
                        <tr>
                            <th>Código</th>
                            <th>Nombre</th>
                            <th>Cantidad</th>
                            <th>Precio Unitario (IVA Incl.)</th>
                            <th>Subtotal (IVA Incl.)</th>
                            <th>Acción</th>
                        </tr>
                    </thead>
                    <tbody id="cuerpoTabla">
                        </tbody>
                </table>
            </div>

            <div class="row bg-dark p-3 rounded align-items-end">
                <div class="col-md-3">
                    <label for="metodoPago" class="form-label">Método de Pago:</label>
                    <select id="metodoPago" name="metodoPago" class="form-select" required>
                        <option value="Efectivo">Efectivo</option>
                        <option value="TarjetaCredito">Tarjeta Crédito</option>
                        <option value="TarjetaDebito">Tarjeta Débito</option>
                        <option value="Transferencia">Transferencia</option>
                    </select>
                </div>
                
                <div class="col-md-3">
                    <label for="subtotal" class="form-label">Subtotal (SIN IVA):</label>
                    <input type="text" id="subtotal" name="subtotal" class="form-control" value="0.00" readonly>
                </div>
                <div class="col-md-2">
                    <label for="ivaTotal" class="form-label">IVA Total:</label>
                    <input type="text" id="ivaTotal" name="ivaTotal" class="form-control" value="0.00" readonly>
                </div>
                <div class="col-md-2">
                    <label for="total" class="form-label">TOTAL:</label>
                    <input type="text" id="total" name="total" class="form-control fw-bold fs-5" value="0.00" readonly>
                </div>

                <div class="col-md-2 d-grid">
                    <button type="submit" name="accion" value="registrar" class="btn btn-primary btn-lg">Registrar Venta</button>
                </div>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        
        let productoSeleccionado = null; 
        
        function buscarCliente() {
            let cedula = document.getElementById("txtCedulaCliente").value.trim();
            let feedback = document.getElementById("clienteFeedback");
            
            document.getElementById("txtNombreCliente").value = "";
            feedback.innerHTML = ""; 
            
            if (cedula.length < 5) {
                feedback.innerHTML = "Ingrese una cédula válida para buscar.";
                return;
            }

            fetch('VentaServlet?accion=buscarCliente&cedula=' + cedula)
                .then(response => response.json())
                .then(data => {
                    if (data.encontrado) {
                        document.getElementById("txtNombreCliente").value = data.nombre + " " + data.apellido;
                        document.getElementById("txtTelefonoCliente").value = data.telefono;
                        document.getElementById("txtDireccionCliente").value = data.direccion;
                        document.getElementById("txtCorreoCliente").value = data.correo;
                        feedback.innerHTML = "✅ Cliente encontrado: " + data.nombre + " " + data.apellido;
                    } else {
                        document.getElementById("txtNombreCliente").value = "CLIENTE NO ENCONTRADO";
                        feedback.innerHTML = "❌ Cliente no registrado. Verifique la cédula o regístrelo.";
                    }
                })
                .catch(error => {
                    console.error('Error al buscar cliente:', error);
                    feedback.innerHTML = "⚠️ Error de comunicación al buscar cliente.";
                });
        }
        
        function buscarProducto() {
            let codigo = document.getElementById("txtCodigo").value.trim();
            document.getElementById("txtDisplayInfo").value = "Buscando...";
            productoSeleccionado = null;

            if (codigo === "") {
                document.getElementById("txtDisplayInfo").value = "";
                return;
            }
            
            fetch('VentaServlet?accion=buscarProducto&codigo=' + codigo)
                .then(response => response.json())
                .then(data => {
                    if (data.encontrado) {
                        productoSeleccionado = data; 
                        document.getElementById("txtDisplayInfo").value = 
                            `${data.nombre} | P.Final: $${data.precioFinal.toFixed(2)} | Stock: ${data.existencia}`;
                        document.getElementById("txtCantidad").focus();
                    } else {
                        document.getElementById("txtDisplayInfo").value = "❌ Producto no encontrado. Revise código y DB.";
                        document.getElementById("txtCodigo").focus();
                    }
                })
                .catch(error => {
                    console.error('Error al buscar producto:', error);
                    document.getElementById("txtDisplayInfo").value = "⚠️ Error de comunicación. Revisar logs del servidor.";
                });
        }

        function agregarProducto() {
            if (!productoSeleccionado) {
                alert("Primero debe buscar y seleccionar un producto válido.");
                return;
            }
            
            if (document.getElementById("txtNombreCliente").value.trim() === "" || document.getElementById("txtNombreCliente").value.includes("NO ENCONTRADO")) {
                 alert("Por favor, busque y valide la cédula del cliente primero.");
                 document.getElementById("txtCedulaCliente").focus();
                 return;
            }

            let codigo = document.getElementById("txtCodigo").value.trim();
            let cantidadInput = document.getElementById("txtCantidad");
            let cantidad = parseInt(cantidadInput.value);

            if (isNaN(cantidad) || cantidad <= 0) {
                alert("La cantidad debe ser un número positivo.");
                cantidadInput.focus();
                return;
            }
            
            if (cantidad > productoSeleccionado.existencia) {
                alert(`⚠️ No hay suficiente stock. Disponible: ${productoSeleccionado.existencia}`);
                cantidadInput.focus();
                return;
            }
            
            // Revisa si el producto ya está en la tabla
            let filasExistentes = document.getElementById("cuerpoTabla").rows;
            for(let i=0; i < filasExistentes.length; i++){
                let codExistente = filasExistentes[i].querySelector("input[name='tblCodigo']").value;
                if(codExistente === codigo){
                    alert("El producto ya está en la lista. Por favor, elimínelo y vuelva a agregarlo con la cantidad correcta.");
                    return;
                }
            }
            
            // Cálculos
            let subtotalConIva = cantidad * productoSeleccionado.precioFinal; 
            let subtotalBase = cantidad * productoSeleccionado.precioBase; 
            let ivaMonto = subtotalConIva - subtotalBase;

            // Crear la nueva fila
            let tabla = document.getElementById("cuerpoTabla");
            let fila = tabla.insertRow();
            
            fila.setAttribute("data-base-monto", subtotalBase.toFixed(2));
            fila.setAttribute("data-iva-monto", ivaMonto.toFixed(2));
            
            fila.innerHTML = `
                <td>
                    ${codigo}
                    <input type="hidden" name="tblCodigo" value="${codigo}">
                </td>
                <td>
                    ${productoSeleccionado.nombre}
                    <input type="hidden" name="tblNombre" value="${productoSeleccionado.nombre}">
                </td>
                <td>
                    ${cantidad}
                    <input type="hidden" name="tblCantidad" value="${cantidad}">
                </td>
                <td>
                    $${productoSeleccionado.precioFinal.toFixed(2)}
                    <input type="hidden" name="tblPrecio" value="${productoSeleccionado.precioFinal.toFixed(2)}">
                </td>
                <td>
                    $${subtotalConIva.toFixed(2)}
                    <input type="hidden" name="tblSubtotal" value="${subtotalConIva.toFixed(2)}">
                </td>
                <td><button type="button" class="btn btn-danger btn-sm" onclick="eliminarFila(this)">X</button></td>
            `;

            calcularTotales();
            limpiarCamposProducto();
        }

        function calcularTotales() {
            let filas = document.getElementById("cuerpoTabla").rows;
            let totalGeneral = 0;
            let totalIva = 0;
            let subtotalBase = 0;
            
            for (let i = 0; i < filas.length; i++) {
                let ivaMonto = parseFloat(filas[i].getAttribute("data-iva-monto")); 
                let baseMonto = parseFloat(filas[i].getAttribute("data-base-monto")); 
                
                totalIva += ivaMonto;
                subtotalBase += baseMonto; 
            }
            
            totalGeneral = subtotalBase + totalIva;

            document.getElementById("subtotal").value = subtotalBase.toFixed(2);
            document.getElementById("ivaTotal").value = totalIva.toFixed(2);
            document.getElementById("total").value = totalGeneral.toFixed(2);
        }

        function limpiarCamposProducto() {
            productoSeleccionado = null;
            document.getElementById("txtCodigo").value = "";
            document.getElementById("txtCantidad").value = "1";
            document.getElementById("txtDisplayInfo").value = ""; 
            document.getElementById("txtCodigo").focus(); 
        }

        function eliminarFila(btn) {
            let fila = btn.parentNode.parentNode;
            fila.parentNode.removeChild(fila);
            calcularTotales();
        }

    </script>
</body>
</html>