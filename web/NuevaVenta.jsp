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

        <form action="VentaServlet" method="post" id="formVenta">
            <div class="card bg-dark text-white border-secondary mb-3">
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label>Factura N°</label>
                            <input type="text" class="form-control text-warning fw-bold" name="numFactura" value="<%= proxFactura %>" readonly>
                        </div>
                        <div class="col-md-3">
                            <label>Cédula Cliente</label>
                            <input type="text" id="txtCedula" class="form-control" name="cedula" placeholder="Cédula/ID Cliente" required onchange="buscarClientePorCedula()">
                        </div>
                        <div class="col-md-3">
                            <label>Nombre Cliente</label>
                            <input type="text" id="txtNombreCliente" class="form-control" name="nombre" placeholder="Nombre completo" required>
                        </div>
                         <div class="col-md-3">
                            <label>Método Pago</label>
                            <select class="form-select" name="metodoPago">
                                <option>Efectivo</option>
                                <option>Tarjeta</option>
                                <option>Transferencia</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card bg-secondary bg-opacity-10 border-secondary mb-3">
                <div class="card-body">
                    <div class="row align-items-end">
                        <div class="col-md-4">
                            <label>Código Producto</label>
                            <input type="text" id="txtCodigo" class="form-control" placeholder="Escanea o escribe" autofocus>
                        </div>
                         <div class="col-md-4">
                            <label>Nombre / Precio / Impuesto</label>
                            <input type="text" id="txtDisplayInfo" class="form-control" readonly placeholder="Se cargan automáticamete al buscar">
                        </div>
                        <div class="col-md-2">
                            <label>Cant. a Vender</label>
                            <input type="number" id="txtCantidad" class="form-control" value="1" min="1">
                        </div>
                        
                        <input type="hidden" id="precioUnitarioBase" value="0.0">
                        <input type="hidden" id="porcentajeImpuesto" value="0.0">
                        <input type="hidden" id="stockDisponible" value="0"> 

                         <div class="col-md-2">
                            <label>&nbsp;</label>
                            <button type="button" class="btn btn-success w-100" onclick="buscarProductoYAgregar()">
                                + Agregar
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <table class="table table-dark table-hover border text-center">
                <thead>
                    <tr>
                        <th>Código</th>
                        <th>Producto</th>
                        <th>Cant.</th>
                        <th>Precio Unit. (Base)</th>
                        <th>Subtotal (con IVA)</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody id="cuerpoTabla">
                    </tbody>
            </table>

            <div class="row justify-content-end">
                <div class="col-md-4">
                    <div class="input-group mb-2">
                        <span class="input-group-text bg-dark text-white border-secondary">Subtotal (Base):</span>
                        <input type="text" class="form-control bg-dark text-white border-secondary text-end" id="subtotal" name="subtotal" value="0.00" readonly>
                    </div>
                    <div class="input-group mb-2">
                        <span class="input-group-text bg-dark text-white border-secondary">Total IVA:</span>
                        <input type="text" class="form-control bg-dark text-white border-secondary text-end" id="ivaTotal" name="ivaTotal" value="0.00" readonly>
                    </div>
                    <div class="input-group mb-3">
                        <span class="input-group-text bg-success text-white border-success fw-bold">TOTAL PAGAR:</span>
                        <input type="text" class="form-control bg-dark text-success border-success text-end fw-bold fs-4" id="total" name="total" value="0.00" readonly>
                    </div>
                    
                    <button type="submit" name="accion" value="guardar_venta" class="btn btn-primary w-100 btn-lg">
                        GUARDAR Y GENERAR FACTURA
                    </button>
                    <a href="Menu.jsp" class="btn btn-secondary w-100 mt-2">Cancelar</a>
                </div>
            </div>
        </form>
    </div>

    <script>
        const servletUrl = "VentaServlet";

        // 🛑 FUNCIÓN NUEVA: Búsqueda de Cliente por Cédula (AJAX)
        function buscarClientePorCedula() {
            const cedula = document.getElementById("txtCedula").value.trim();
            const nombreInput = document.getElementById("txtNombreCliente");

            // 1. Limpiar y resetear el campo de nombre
            nombreInput.value = "";
            nombreInput.readOnly = false;
            nombreInput.placeholder = "Nombre completo"; 

            if (cedula.length < 5) {
                return; 
            }
            
            nombreInput.placeholder = "Buscando cliente...";

            // 2. Petición AJAX al Servlet
            fetch(servletUrl + "?accion=buscar_cliente_ajax&cedula=" + cedula)
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.found) {
                        // 3. Cliente encontrado
                        nombreInput.value = data.nombre;
                        nombreInput.readOnly = true; // Bloquear edición
                        nombreInput.placeholder = data.nombre;
                        document.getElementById("txtCodigo").focus(); // Mover foco al producto
                    } else {
                        // 4. Cliente NO encontrado
                        alert("¡Cliente no registrado! ⚠️ Por favor, ingrese el nombre del cliente para registrar la venta a su nombre.");
                        nombreInput.value = "";
                        nombreInput.readOnly = false; // Permitir al usuario escribir el nombre
                        nombreInput.placeholder = "Cliente no existe. Escriba el nombre completo.";
                        nombreInput.focus();
                    }
                })
                .catch(error => {
                    console.error('Error al buscar cliente:', error);
                    alert("Error de conexión al buscar cliente.");
                    nombreInput.readOnly = false;
                    nombreInput.placeholder = "Error de conexión";
                });
        }
        
        // --- Funciones de Productos (Se mantienen con la validación de cliente) ---

        function buscarProductoYAgregar() {
            const cedula = document.getElementById("txtCedula").value.trim();
            const nombre = document.getElementById("txtNombreCliente").value.trim();
            
            // 🛑 VALIDACIÓN ANTES DE AGREGAR PRODUCTOS
            if (cedula === "" || nombre === "") {
                alert("Primero debe ingresar la Cédula y Nombre del cliente (se validan automáticamente).");
                document.getElementById("txtCedula").focus();
                return;
            }
            
            const codigo = document.getElementById("txtCodigo").value.trim();
            const cantidad = parseInt(document.getElementById("txtCantidad").value || '0');

            if (codigo === "") {
                alert("Ingrese el código del producto.");
                document.getElementById("txtCodigo").focus();
                return;
            }
            if (cantidad <= 0 || isNaN(cantidad)) {
                alert("Ingrese una cantidad válida.");
                document.getElementById("txtCantidad").focus();
                return;
            }
            
            document.getElementById("txtDisplayInfo").value = "Buscando...";
            
            fetch(servletUrl + "?accion=buscar_producto_ajax&codigo=" + codigo)
                .then(response => {
                    if (!response.ok) { throw new Error(`HTTP error! status: ${response.status}`); }
                    return response.json();
                })
                .then(data => {
                    if (data.error) {
                        alert("Error: " + data.error);
                        document.getElementById("txtDisplayInfo").value = "Error al buscar";
                    } else if (data.existencia < cantidad) {
                         alert(`Error: Stock insuficiente. Existencia actual: ${data.existencia}.`);
                         document.getElementById("txtDisplayInfo").value = `Stock: ${data.existencia} (Insuficiente)`;
                    } else {
                        agregarProductoTabla(data.codigo, data.nombre, data.precio, data.impuesto, cantidad);
                        document.getElementById("txtDisplayInfo").value = `OK: ${data.nombre} ($${data.precio.toFixed(2)} + ${data.impuesto}%)`;
                    }
                })
                .catch(error => {
                    console.error('Error al buscar producto:', error);
                    alert("Error de conexión o servidor al buscar el producto.");
                    document.getElementById("txtDisplayInfo").value = "Error de conexión";
                });
        }

        function agregarProductoTabla(codigo, nombre, precio, impuesto, cantidad) {
            
            const precioBaseUnitario = precio; 
            const impuestoUnitario = precioBaseUnitario * (impuesto / 100.0);
            const precioTotalUnitario = precioBaseUnitario + impuestoUnitario;
            
            const subtotalConIva = precioTotalUnitario * cantidad;
            const subtotalIvaMonto = impuestoUnitario * cantidad;
            const subtotalBaseMonto = precioBaseUnitario * cantidad;

            let fila = `<tr data-iva-monto='${subtotalIvaMonto.toFixed(2)}' data-base-monto='${subtotalBaseMonto.toFixed(2)}'>` +
                "<td><input type='hidden' name='tblCodigo' value='"+codigo+"'>"+codigo+"</td>" +
                "<td><input type='hidden' name='tblNombre' value='"+nombre+"'>"+nombre+"</td>" +
                "<td><input type='hidden' name='tblCantidad' value='"+cantidad+"'>"+cantidad+"</td>" +
                "<td><input type='hidden' name='tblPrecio' value='"+precioBaseUnitario.toFixed(2)+"'>"+precioBaseUnitario.toFixed(2)+"</td>" +
                "<td><input type='hidden' name='tblSubtotal' value='"+subtotalConIva.toFixed(2)+"'>"+subtotalConIva.toFixed(2)+"</td>" +
                "<td><button type='button' class='btn btn-danger btn-sm' onclick='eliminarFila(this)'>X</button></td>" +
                "</tr>";

            document.getElementById("cuerpoTabla").innerHTML += fila;
            calcularTotales();
            
            document.getElementById("txtCodigo").value = "";
            document.getElementById("txtCantidad").value = "1";
            document.getElementById("txtDisplayInfo").value = ""; 
            document.getElementById("txtCodigo").focus(); 
        }

        function calcularTotales() {
            let filas = document.getElementById("cuerpoTabla").rows;
            let totalGeneral = 0;
            let totalIva = 0;
            let subtotalBase = 0;
            
            for (let i = 0; i < filas.length; i++) {
                let subtotalConIva = parseFloat(filas[i].querySelector("input[name='tblSubtotal']").value);
                let ivaMonto = parseFloat(filas[i].getAttribute("data-iva-monto")); 
                let baseMonto = parseFloat(filas[i].getAttribute("data-base-monto")); 
                
                totalGeneral += subtotalConIva;
                totalIva += ivaMonto;
                subtotalBase += baseMonto; 
            }
            
            document.getElementById("subtotal").value = subtotalBase.toFixed(2);
            document.getElementById("ivaTotal").value = totalIva.toFixed(2);
            document.getElementById("total").value = totalGeneral.toFixed(2);
        }

        function eliminarFila(btn) {
            let fila = btn.parentNode.parentNode;
            fila.parentNode.removeChild(fila);
            calcularTotales();
        }

    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>