package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class ConsultarVentas_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <title>Consultar Ventas</title>\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css\">\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            background-color: #343a40; /* Fondo oscuro similar a tus imágenes */\n");
      out.write("            color: #f8f9fa;\n");
      out.write("            padding: 20px;\n");
      out.write("        }\n");
      out.write("        .container {\n");
      out.write("            max-width: 95%;\n");
      out.write("        }\n");
      out.write("        .card {\n");
      out.write("            background-color: #212529; /* Color de tarjeta/área de contenido */\n");
      out.write("            border: 1px solid #495057;\n");
      out.write("        }\n");
      out.write("        .table-responsive {\n");
      out.write("            margin-top: 20px;\n");
      out.write("        }\n");
      out.write("        .table thead th {\n");
      out.write("            color: #adb5bd;\n");
      out.write("            background-color: #495057;\n");
      out.write("        }\n");
      out.write("        .table tbody tr {\n");
      out.write("            color: #f8f9fa;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("<div class=\"container\">\n");
      out.write("    <h2 class=\"text-center mb-4\">Consultar Ventas</h2>\n");
      out.write("    <div class=\"card p-3\">\n");
      out.write("        \n");
      out.write("        <div class=\"d-flex justify-content-start mb-3\">\n");
      out.write("            <a href=\"NuevaVenta.jsp\" class=\"btn btn-success mr-2\">Nueva Venta</a>\n");
      out.write("            <button class=\"btn btn-secondary mr-2\">Buscar</button>\n");
      out.write("            <button class=\"btn btn-info mr-2\">Exportar</button>\n");
      out.write("            <button type=\"button\" onclick=\"window.location.href='Menu.jsp';\" class=\"btn btn-info btn-responsive\">Regresar</button>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <div class=\"mb-3\">\n");
      out.write("            <form action=\"VentasController\" method=\"get\" class=\"form-inline\">\n");
      out.write("                <input type=\"hidden\" name=\"action\" value=\"buscar\">\n");
      out.write("                <label for=\"fechaIni\" class=\"mr-2\">Fecha Inicio:</label>\n");
      out.write("                <input type=\"date\" id=\"fechaIni\" name=\"fechaIni\" class=\"form-control mr-3 bg-dark text-white border-secondary\">\n");
      out.write("                \n");
      out.write("                <label for=\"fechaFin\" class=\"mr-2\">Fecha Fin:</label>\n");
      out.write("                <input type=\"date\" id=\"fechaFin\" name=\"fechaFin\" class=\"form-control mr-3 bg-dark text-white border-secondary\">\n");
      out.write("\n");
      out.write("                <button type=\"submit\" class=\"btn btn-sm btn-outline-light\">Filtrar</button>\n");
      out.write("            </form>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <div class=\"table-responsive\">\n");
      out.write("            <table class=\"table table-dark table-hover table-sm\">\n");
      out.write("                <thead>\n");
      out.write("                    <tr>\n");
      out.write("                        <th>ID Venta</th>\n");
      out.write("                        <th>Fecha</th>\n");
      out.write("                        <th>Cédula Cliente</th>\n");
      out.write("                        <th>Nombre Cliente</th>\n");
      out.write("                        <th>Tipo Pago</th>\n");
      out.write("                        <th>Total Venta</th>\n");
      out.write("                        <th>Estado</th>\n");
      out.write("                        <th>Acciones</th>\n");
      out.write("                    </tr>\n");
      out.write("                </thead>\n");
      out.write("                <tbody>\n");
      out.write("                    <c:forEach var=\"venta\" items=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${listaVentas}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("\">\n");
      out.write("                        <tr>\n");
      out.write("                            <td><c:out value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${venta.idVenta}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("\"/></td>\n");
      out.write("                            <td><c:out value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${venta.fecha}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("\"/></td>\n");
      out.write("                            <td><c:out value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${venta.cedulaCliente}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("\"/></td>\n");
      out.write("                            <td><c:out value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${venta.nombreCliente}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("\"/></td>\n");
      out.write("                            <td><c:out value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${venta.tipoPago}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("\"/></td>\n");
      out.write("                            <td><c:out value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${venta.totalVenta}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("\"/></td>\n");
      out.write("                            <td><c:out value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${venta.estado}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("\"/></td>\n");
      out.write("                            <td>\n");
      out.write("                                <a href=\"detalleVenta.jsp?id=");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${venta.idVenta}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("\" class=\"btn btn-sm btn-primary\">Ver Detalle</a>\n");
      out.write("                                <a href=\"VentasController?action=anular&id=");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${venta.idVenta}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("\" class=\"btn btn-sm btn-danger\">Anular</a>\n");
      out.write("                            </td>\n");
      out.write("                        </tr>\n");
      out.write("                    </c:forEach>\n");
      out.write("                    \n");
      out.write("                    <c:if test=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${empty listaVentas}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("\">\n");
      out.write("                        <tr>\n");
      out.write("                            <td colspan=\"8\" class=\"text-center\">No se encontraron ventas.</td>\n");
      out.write("                        </tr>\n");
      out.write("                    </c:if>\n");
      out.write("\n");
      out.write("                </tbody>\n");
      out.write("            </table>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("    </div>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
