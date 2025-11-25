<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.dao.VentaDAO" %>
<jsp:useBean id="daoV" class="hotelweb.dao.VentaDAO" scope="page" />
<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
    if (usuarioLogueado == null) { response.sendRedirect("index.jsp?error=sesion_expirada"); return; }
    String proxFactura = "000";
    try { proxFactura = daoV.generarNumeroFactura(); } catch(Exception e) { proxFactura = "ERROR_0000"; }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nueva Venta</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #343a40; color: white; }
        .form-control[readonly] { background-color: #495057; color: white; }
    </style>
</head>
<body>
<div class="container mt-4">
    <h2 class="text-center mb-3">Registro de Venta</h2>

    <div class="card bg-secondary text-white p-4 mb-4">
        <h4>Cliente (Factura: <%= proxFactura %>)</h4>
        <div class="row">
            <div class="col-md-4">
                <label>Cédula:</label>
                <input type="text" class="form-control" id="txtCedulaCliente">
            </div>
            <div class="col-md-4 align-self-end">
                <button class="btn btn-primary w-100" type="button" onclick="buscarCliente()">Buscar Cliente</button>
            </div>
        </div>
        <p id="clienteFeedback" class="mt-2 text-warning"></p>
    </div>

    <form action="VentaServlet" method="POST">
        <input type="hidden" name="accion" value="registrarVenta">
        <input type="hidden" name="idCliente" id="idClienteHidden">

        <div class="card bg-dark text-white p-4 mb-4">
            <div class="row mb-2">
                <div class="col-6">
                    <label>Nombre:</label>
                    <input type="text" class="form-control" id="txtNombreCliente" readonly>
                </div>
                <div class="col-6">
                    <label>Correo:</label>
                    <input type="text" class="form-control" id="txtCorreoCliente" readonly>
                </div>
            </div>
        </div>

        <div class="card bg-dark text-white p-4 mb-4">
            <h4>Añadir Productos</h4>
            <div class="row">
                <div class="col-md-3">
                    <label>Cód. Producto:</label>
                    <input type="text" class="form-control" id="txtCodigo" onchange="buscarProducto()">
                </div>
                <div class="col-md-5">
                    <label>Información:</label>
                    <input type="text" class="form-control" id="txtDisplayInfo" readonly>
                </div>
                <div class="col-md-2">
                    <label>Cant.:</label>
                    <input type="number" class="form-control" id="txtCantidad" value="1" min="1">
                </div>
                <div class="col-md-2 align-self-end">
                    <button type="button" class="btn btn-success w-100" onclick="agregarProducto()">Añadir</button>
                </div>
            </div>
        </div>

        <table class="table table-dark table-striped">
            <thead>
                <tr>
                    <th>Cód</th>
                    <th>Producto</th>
                    <th>Cant</th>
                    <th>P. Unit (+IVA)</th>
                    <th>Total</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody id="cuerpoTabla"></tbody>
        </table>

        <div class="row justify-content-end">
            <div class="col-md-4">
                <label>Total a Pagar:</label>
                <h3 class="text-warning" id="totalFacturaDisplay">$0.00</h3>
                <input type="hidden" name="totalFinalCuenta" id="total" value="0.00">
            </div>
        </div>
        <div class="row mb-3">
    <div class="col-md-4">
        <label>Método de Pago:</label>
        <select class="form-control" id="metodoPago">
            <option value="">-- Seleccionar --</option>
            <option value="Efectivo">Efectivo</option>
            <option value="Tarjeta Débito">Tarjeta Débito</option>
            <option value="Tarjeta Crédito">Tarjeta Crédito</option>
        </select>
    </div>
</div>

        <button type="button" class="btn btn-success btn-lg w-100 mt-4" onclick="finalizarVentaAjax()">FINALIZAR VENTA</button>
    </form>
</div>

<script>
    let productoSeleccionado = null;
    let productosAgregados = []; // GUARDAR PRODUCTOS AQUÍ

    function buscarCliente() {
        let cedula = document.getElementById("txtCedulaCliente").value.trim();
        let feedback = document.getElementById("clienteFeedback");
        if(cedula.length < 3) { 
            feedback.innerHTML = "Ingrese cédula válida."; 
            return; 
        }

        fetch('VentaServlet?accion=buscarCliente&cedula=' + encodeURIComponent(cedula))
            .then(r => r.text())
            .then(data => {
                if(data !== 'NO_ENCONTRADO' && data !== 'ERROR_DB') {
                    let partes = data.split('|');
                    document.getElementById("idClienteHidden").value = partes[0];
                    document.getElementById("txtNombreCliente").value = partes[1] + " " + partes[2];
                    document.getElementById("txtCorreoCliente").value = partes[5];
                    feedback.innerHTML = "✅ Cliente encontrado.";
                } else {
                    feedback.innerHTML = "❌ Cliente no encontrado.";
                    document.getElementById("txtNombreCliente").value = "";
                    document.getElementById("txtCorreoCliente").value = "";
                }
            })
            .catch(e => console.error("Error: " + e));
    }

    function buscarProducto() {
        let codigo = document.getElementById("txtCodigo").value.trim();
        if(codigo === "") {
            document.getElementById("txtDisplayInfo").value = "";
            return;
        }
        
        document.getElementById("txtDisplayInfo").value = "Buscando...";
        productoSeleccionado = null;

        fetch('VentaServlet?accion=buscarProducto&codigo=' + encodeURIComponent(codigo))
            .then(r => r.text())
            .then(data => {
                if(data && data !== 'NO_ENCONTRADO' && data !== 'ERROR_DB' && data !== 'ERROR_CODIGO' && data.trim() !== '') {
                    let partes = data.split('|');
                    
                    if(partes.length >= 5) {
                        let id = partes[0];
                        let nombre = partes[1];
                        let precioBase = parseFloat(partes[2]);
                        let impuesto = parseFloat(partes[3]);
                        let existencia = parseInt(partes[4]);
                        let precioFinal = precioBase * (1 + (impuesto / 100));

                        productoSeleccionado = {
                            id: id,
                            nombre: nombre,
                            precioBase: precioBase,
                            impuesto: impuesto,
                            existencia: existencia,
                            precioFinal: precioFinal,
                            codigo: codigo
                        };
                        
                        document.getElementById("txtDisplayInfo").value = nombre + " | Stock: " + existencia;
                        document.getElementById("txtCantidad").focus();
                    } else {
                        document.getElementById("txtDisplayInfo").value = "❌ Datos incompletos.";
                    }
                } else {
                    document.getElementById("txtDisplayInfo").value = "❌ Producto NO encontrado.";
                }
            })
            .catch(e => {
                console.error("Error: " + e);
                document.getElementById("txtDisplayInfo").value = "❌ Error.";
            });
    }

    function agregarProducto() {
        if(!document.getElementById("idClienteHidden").value) { 
            alert("Busque al cliente primero."); 
            return; 
        }
        if(!productoSeleccionado) { 
            alert("Busque un producto válido."); 
            return; 
        }
        
        let cant = parseInt(document.getElementById("txtCantidad").value);
        if(cant <= 0 || cant > productoSeleccionado.existencia) { 
            alert("Cantidad inválida o sin stock."); 
            return; 
        }

        // GUARDAR EN ARRAY GLOBAL
        console.log("Agregando producto - ID: " + productoSeleccionado.id + ", Cantidad: " + cant);
        productosAgregados.push({
            id: productoSeleccionado.id,
            cantidad: cant
        });
        console.log("Productos en array: ", productosAgregados);

        let totalLinea = cant * productoSeleccionado.precioFinal;
        
        let fila = "<tr>";
        fila += "<td>" + productoSeleccionado.codigo + "</td>";
        fila += "<td>" + productoSeleccionado.nombre + "</td>";
        fila += "<td>" + cant + "</td>";
        fila += "<td>$" + productoSeleccionado.precioFinal.toFixed(2) + "</td>";
        fila += "<td class='total-linea'>" + totalLinea.toFixed(2) + "</td>";
        fila += "<td><button type='button' class='btn btn-danger btn-sm' onclick='eliminarFila(this)'>X</button></td>";
        fila += "</tr>";
        
        document.getElementById("cuerpoTabla").insertAdjacentHTML('beforeend', fila);
        calcularTotales();
        
        document.getElementById("txtCodigo").value = "";
        document.getElementById("txtDisplayInfo").value = "";
        document.getElementById("txtCantidad").value = "1";
        productoSeleccionado = null;
        document.getElementById("txtCodigo").focus();
    }

    function calcularTotales() {
        let total = 0;
        let filas = document.querySelectorAll('.total-linea');
        filas.forEach(celda => {
            let valor = parseFloat(celda.innerText);
            if(!isNaN(valor)) {
                total += valor;
            }
        });
        document.getElementById("totalFacturaDisplay").innerText = "$" + total.toLocaleString('es-CO', {minimumFractionDigits: 2});
        document.getElementById("total").value = total.toFixed(2);
    }

    function eliminarFila(btn) {
        let fila = btn.closest('tr');
        let index = Array.from(fila.parentNode.children).indexOf(fila);
        
        console.log("Eliminando producto en índice: " + index);
        productosAgregados.splice(index, 1);
        console.log("Productos después de eliminar: ", productosAgregados);
        
        fila.remove();
        calcularTotales();
    }

    function finalizarVentaAjax() {
        console.log("=== FINALIZANDO VENTA ===");
        
        // Obtener valores
        let cedula = document.getElementById("txtCedulaCliente").value.trim();
        let nombre = document.getElementById("txtNombreCliente").value.trim();
        let total = document.getElementById("total").value;
        let metodoPago = document.getElementById("metodoPago") ? document.getElementById("metodoPago").value : "Efectivo";
        
        console.log("Cedula: " + cedula);
        console.log("Nombre: " + nombre);
        console.log("Total: " + total);
        console.log("Método Pago: " + metodoPago);
        console.log("Productos: ", productosAgregados);
        
        // Validaciones
        if (!cedula) {
            alert("Seleccione un cliente");
            return;
        }
        
        if (productosAgregados.length === 0) {
            alert("Agregue al menos un producto");
            return;
        }
        
        if (!metodoPago) {
            alert("Seleccione método de pago");
            return;
        }

        // Preparar datos con URLSearchParams en lugar de FormData
        let params = new URLSearchParams();
        params.append("accion", "registrarVenta");
        params.append("cedulaCliente", cedula);
        params.append("nombreCliente", nombre);
        params.append("metodoPago", metodoPago);
        params.append("totalVenta", total);
        params.append("productos", JSON.stringify(productosAgregados));

        console.log("Enviando datos al servidor...");
        console.log("Parámetros: " + params.toString());

        // Enviar al servidor
        fetch('VentaServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: params.toString()
        })
        .then(response => {
            console.log("Status: " + response.status);
            return response.text();
        })
        .then(text => {
            console.log("Respuesta del servidor (texto): " + text);
            try {
                let resultado = JSON.parse(text);
                console.log("Resultado JSON:", resultado);
                
                if (resultado.exito) {
                    alert("✅ Venta registrada correctamente\nFactura: " + resultado.factura);
                    location.reload();
                } else {
                    alert("❌ Error: " + resultado.mensaje);
                }
            } catch(e) {
                console.error("Error parseando JSON:", e);
                alert("Error: Respuesta inválida del servidor");
            }
        })
        .catch(error => {
            console.error("Error en fetch:", error);
            alert("Error al procesar la venta: " + error.message);
        });
    }

    document.getElementById("txtCodigo").addEventListener('keypress', function(e) {
        if(e.key === 'Enter') {
            buscarProducto();
            e.preventDefault();
        }
    });
</script>
</body>
</html>