CREATE TABLE Usuario ( uid varchar(20) NOT NULL, usuario varchar(20) NOT NULL, password varchar(20) NOT NULL, standard BOOL NOT NULL, PRIMARY KEY(uid));

Podemos añadir datos para probar la aplicación:

- INSERT INTO Usuario (UID, usuario, password, standard) VALUES ('1', 'admin', 'admin', '0');
- INSERT INTO Usuario (UID, usuario, password, standard) VALUES ('2', 'ajcalle', '123456', '1');


En el FRONTCONTROLLER lo siguiente (pongo todo el FrontController):

package pos.presentation;
 
import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import pos.domain.UserManager;
 
public class FrontController extends HttpServlet {
 
    boolean standar = true;
    String resource;
    
    public void init() throws ServletException {
    }
 
    protected void doGet(HttpServletRequest request,
   		 HttpServletResponse response) throws ServletException, IOException {
   	 processRequest(request, response);
 
    }
 
    protected void doPost(HttpServletRequest request,
   		 HttpServletResponse response) throws ServletException, IOException {
   	 processRequest(request, response);
    }
 
    public void processRequest(HttpServletRequest request,
   		 HttpServletResponse response) throws IOException, ServletException {
   	 if (logado(request)) {
   		 if (standar==false)
   		 {
   			 resource="vip.jsp";
			 standar=true;
   		 }
   		 else
   		 {
   			 resource = request.getParameter("res");
   		 }
   			 RequestDispatcher d = request.getRequestDispatcher(resource);
   			 if(d!=null){
   				 d.forward(request,response);
   			 }
   			 System.out.println("LOGADO ACCEDIENDO A " + resource);
   		 }
   	  else {
   		 response.sendRedirect("error.html");
   	 }
 
    }
 
    private boolean logado(HttpServletRequest request) {
   	 boolean logado = false;
 
   	 HttpSession session = request.getSession(false);
 
   	 String userForm = request.getParameter("user");
   	 String passwdForm = request.getParameter("passwd");
 
   	 if (session == null) {
   		 session = request.getSession();
   		 if (userForm == null || passwdForm == null
   				 || userForm.length() == 0 || passwdForm.length() == 0) {
   			 logado = false;
 
   		 } else {
   			 if (valido(userForm, passwdForm)) {
   				 logado = true;
   				 session.setAttribute("session.user", userForm);
   			 } else {
   				 logado = false;
   			 }
 
   		 }
 
   	 } else {
   		 if (userForm == null || passwdForm == null) {
   			 logado = true;
   		 } else {
   			 if (valido(userForm, passwdForm)) {
   				 logado = true;
   				 session.setAttribute("session.user", userForm);
   			 } else {
   				 logado = false;
   			 }
 
   		 }
   	 }
   	 return logado;
    }
 
    public boolean valido(String userForm, String passwdForm) {
   	 boolean res = false;
   	 UserManager um = new UserManager();
   	 res = um.login(userForm, passwdForm);
   	 standar=um.standar(userForm);
   	 return res;
 
    }
 
}


en pos.domain tenemos que crear un UserManager.java que tendra el siguiente codigo:
package pos.domain;

import pos.data.*;

public class UserManager {
    
    IUserDAO us = new JDBCUserDAO();
    
    public boolean login(String user, String passwd){
   	 
   	 boolean res= false;
   	 res = us.autenticate(user, passwd);
   	 return res;
   	 
    }
    public boolean standar(String user){
   	 boolean stan=true;
   	 stan = us.isStandar(user);
   	 return stan;
    }

}

por ultimo, en pos.data creamos la interfaz IUserDAO y la clase JDBCUserDAO con los siguientes codigos:

IUserDAO:

package pos.data;

public interface IUserDAO {
    
    boolean autenticate(String user, String passwd);
    boolean isStandar(String user);

}

JDBCUserDAO:

package pos.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import pos.domain.Product;

public class JDBCUserDAO implements IUserDAO {

    Connection conn = ConnectionManager.getInstance().checkOut();
    @Override
    public boolean autenticate(String user, String passwd) {

   	 
   	 
   	 boolean res=false;
   	 PreparedStatement stmt = null;
    	ResultSet result = null;
    	Product p = null;
    	String sql = "SELECT * FROM Usuario WHERE (usuario = ? AND password = ?) ";

    	try {
        	stmt = conn.prepareStatement(sql);
        	stmt.setString(1, user);
        	stmt.setString(2, passwd);
        	result = stmt.executeQuery();

        	res = result.next();
       	 
    	} catch (SQLException e) {
        	System.out.println("Message: " + e.getMessage());
        	System.out.println("SQLState: " + e.getSQLState());
        	System.out.println("ErrorCode: " + e.getErrorCode());
  	 
	}
    	return res;
    }

    @Override
    public boolean isStandar(String user) {
   	 
   		 
   		 boolean resul=false;
   		 int stand;
   		 PreparedStatement stmt = null;
        	ResultSet result = null;
        	Product p = null;
        	String sql = "SELECT * FROM Usuario WHERE (usuario = ?) ";

        	try {
            	stmt = conn.prepareStatement(sql);
            	stmt.setString(1, user);
            	result = stmt.executeQuery();
            	result.next();

            	stand = result.getInt("standard");
           	 
            	if (stand==0){
           		 resul=false;
            	}
            	else{
           		 resul=true;
            	}
           		 
         	 
        	} catch (SQLException e) {
            	System.out.println("Message: " + e.getMessage());
            	System.out.println("SQLState: " + e.getSQLState());
            	System.out.println("ErrorCode: " + e.getErrorCode());
      	 
    	}
        	return resul;
   	 }
    

}

Con esto, ya tenemos la autentificacion por usuario en BBDD y podemos ver si un usuario es vip o standard... Ahora queda crear la pagina vip.jsp (Mañana la subo, si no la subis antes ustedes... xD)


Ok, hasta aqui lo de ayer, a partir de aqui explico lo que hay que hacer ahora:
Tenemos que crear varios jsp que son: vip.jsp, carritovip.jsp, confirmarVip.jsp, eliminarVip.jsp y printCarritoVip.jsp. Os pongo los codigos de todas las .jsp, los probais y debe de marchar¡¡¡¡¡ Mucho OJO, y escribir los nombres de las jsp tal y como las describo porque si no , no rulará xD, es lo que tiene la distincion entre mayusculas y minusculas.
*****************vip.jsp****************

<%@ page language="java" import="pos.domain.*,java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//w3c//dtd html 4.0 transitional//en">
<html>
<head>
<title>Productos</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<style type="text/css">
<!--
    #cabecera td{background-color: rgb(238, 238, 238);}
      #productos td{
   	 border-top-width: 1px;
	border-top-style: solid;
		 border-top-color: rgb(153, 0, 51);
   }
-->
</style>
</head>
<body>

<div id="top">
<jsp:include  page="head.html"/>
</div>

<div id="content">
<table summary ="Listado de Productos" cellSpacing="1" cellPadding="6" width="770" align="center" border="0">
    <tr valign ="middle" align="center">
   	 <td  colspan="6"><b>PRODUCTOS</b></td>
    </tr>
    <tr valign ="middle" align="center" id="cabecera">
   	 <td>&nbsp;</td><td>Descripción</td><td>Precio</td> <td>Precio VIP</td> <td>Añadir</td>
    </tr>
<%
    	List products = ProductStore.getInstance().getProducts();
    	for (Iterator iter = products.iterator(); iter.hasNext();) {
        	Product p = (Product) iter.next();
%>
   		 <tr align="center" id="productos">
   			 <td>--</td>
   			 <td> <%=p.getDescription()%> </td>
   			 <td> <%=p.getPrice()%></td>
   			 <td> <%=p.getPrice()*0.9%></td>
   			 <td> <a href="FrontController?res=carritovip.jsp?pid=<%=p.getProductID()%>"><img src='img/carro.gif'> </a></td>
   		 </tr>
<%
   	 }
%>
</table>
</div>
</body>
</html>

******************** carritovip.jsp *****************
<%@ page language="java" import="pos.domain.*" %>
<!DOCTYPE HTML PUBLIC "-//w3c//dtd html 4.0 transitional//en">
<html>
<head>
<title>Productos</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<style type="text/css">
<!--
    #cabecera td{background-color: rgb(238, 238, 238);}
      #productos td{
   	 border-top-width: 1px;
    	border-top-style: solid;
		 border-top-color: rgb(153, 0, 51);
   }
-->
</style>
</head>
<body>

<%
   // extraigo del el parámetro indicándome el producto que se va a añadir al carro
    String pid = request.getParameter("pid");
    Order sessionCart = null;

    // si el parámetro no es nulo (se acceder directamente a carrito) o si su longitud no es mayor a cero
    if(pid!=null && pid.length()>0)
   {
   	 Detail detail = new Detail();
   	 detail.setNote("session");
   	 detail.setProduct(ProductStore.getInstance().getProduct(pid));
   	 detail.setQuantity(1);
   	 
    
   	 //saco si esque existe el carrito de la sessión
   	 //el carrito será un objeto de tipo Order
   	 sessionCart = (Order)session.getAttribute("session.cart");
   	 // es la primera vez que se añade un elemento
   	 if(sessionCart == null)  {
   		sessionCart = new Order();
   		sessionCart.setOrderID(""+System.currentTimeMillis());
   	 }
   	 sessionCart.addDetail(detail);
   	 session.setAttribute("session.cart", sessionCart);
  }
    else   {
    System.out.println("PRODUCTO NULO");
    
   }
%>
<div id="top">
<jsp:include  page="head.html"/>
</div>
<div id="content">
<jsp:include page="printCarritoVip.jsp?botones=1"  />
</div>
</body>
</html>








 ***************** confirmarVip.jsp *******************
<%@ page language="java" import="pos.domain.*" %>
<!DOCTYPE HTML PUBLIC "-//w3c//dtd html 4.0 transitional//en">
<html>
<head>
<title>Productos</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<style type="text/css">
<!--
    #cabecera td{background-color: rgb(238, 238, 238);}
      #productos td{
   	 border-top-width: 1px;
    	border<%
}
else{

%>
<jsp:include page="printCarritoVip.jsp?botones=0"/>

<form action="FrontController?res=pagar.jsp" method="post">
<div id="left">
<jsp:include page="pago.html"/>
</div>
<div id="right">
<jsp:include page="direccion.html"/>

<%
}

%>

</div>
</form>

</div>
</body>
</html>




********************** eliminarVip.jsp **********************


<%@ page language="java" import="pos.domain.*" %>
<!DOCTYPE HTML PUBLIC "-//w3c//dtd html 4.0 transitional//en">
<html>
<head>
<title>Productos</title>
<link rel="stylesheet" type="text/css" href="style/style.css" />
<style type="text/css">
<!--
    #cabecera td{background-color: rgb(238, 238, 238);}
      #productos td{
   	 border-top-width: 1px;
    	border-top-style: solid;
		 border-top-color: rgb(153, 0, 51);
   }
→
</style>
</head>
<body>

<%
   // extraigo del el parámetro indicándome l producto que se va a eliminar del carro
   // independientemente del número de items que haya, se elimina el producto
    String pid = request.getParameter("pid");
    Order sessionCart = null;

   // si el parámetro no es nulo (se acceder directamente a carrito) o si su longitud no es mayor a cero
    if(pid!=null && pid.length()>0)
 {

   	 sessionCart = (Order)session.getAttribute("session.cart");
   	 if(sessionCart != null)
   	 {
   		 sessionCart.removeDetail(pid);   	 
   	 }
    }
%>
<div id="top">
<jsp:include  page="head.html"/>
</div>
<div id="content">
<jsp:include page="printCarritoVip.jsp?botones=1"  />
</div>
</body>
</html>






******************* printCarritoVip.jsp***********************

<%@ page language="java" import="pos.domain.*,java.util.*" %>

<table summary ="Listado de Productos" cellSpacing="1" cellPadding="6" width="770" align="center" border="0">
    <tr valign ="middle" align="center">
   	 <td id = "colchones" colspan="6"><b>SU PEDIDO</b></td>
    </tr>
    <tr valign ="middle" align="center" id="cabecera">
   	 <td>&nbsp;</td><td>Descripción</td><td>Cantidad</td><td>Precio VIP</td><td>Total</td><td>Eliminar</td>
    </tr>
<%
   	 Order sessionCart = (Order)session.getAttribute("session.cart");

    	double importeTotal = 0;
   	 if(sessionCart != null)
   	 {
    	Collection litems = sessionCart.getDetails();
    	Iterator li = litems.iterator();
    	while (li.hasNext()) {
   		 Detail detailSession= (Detail) li.next();
   		 Product p = detailSession.getProduct();
   		 String description = p.getDescription();
   		 int amount = detailSession.getQuantity();
   		 int price = p.getPrice();
   		 double precio = price*0.9;
   		 String pid = p.getProductID();
   		 double    total = precio*amount;
   		 
%>
   		 <tr align="center" id="productos">
   			 <td>--</td>    <td> <%=description%> </td>    <td> <%=amount%> </td><td> <%=precio%></td>    <td> <%=total%></td>
   			 <td> <a href="FrontController?res=eliminarVip.jsp?pid=<%=pid%>">
   			  	<img src='img/eliminar.jpg'></a>
   		 	</td>
   			 </tr>
<%
   	 importeTotal+=total;
   	 }
    	}
    	else
    	{%>
   		 <tr align="center" id="productos">
   		 <td colspan='6'>NO HAY PRODUCTOS</td>
   		 </tr>
    	<%}
%>

   		 <tr align="center" id="productos">
   			 <td colspan='5' align="right">    <b>Importe Total</b></td>
   			 <td> <%=importeTotal%> </td>
   		 </tr>

    <%if(!request.getParameter("botones").equals("0")){%>
   		 <tr align="center" id="productos">
   			 <td colspan='3'>
   			 <a href="FrontController?res=vip.jsp"><img src='img/seguir.jpg'></a>
   			 </td>
   			 <td colspan='3'>
   			 <a href="FrontController?res=confirmarVip.jsp"><img src='img/confirmar.jpg'></a>
   			 </td>
   		 </tr>
<%}
%>
</table>
