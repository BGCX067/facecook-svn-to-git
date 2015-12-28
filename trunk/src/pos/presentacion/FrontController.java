package pos.presentacion;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import pos.dominios.Usuario;
//import pos.dominios.UsuarioManager;

//clase copiada, para que funcionase necesita de clase usuarios en pos.dominios!!!!!!!!!!

public class FrontController extends HttpServlet {

	String user = "practica";

	String passwd = "practica";
	
	//private List<Usuario> lista = new LinkedList<Usuario>();

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
			String resource = request.getParameter("res");
			RequestDispatcher d = request.getRequestDispatcher(resource);
			if(d!=null){
				d.forward(request,response);
			}
			System.out.println("LOGADO ACCEDIENDO A " + resource);
		} else {
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
		//lista = UsuarioManager.getInstance().getUsuarios();
		//for(Usuario u :lista){
		// user= u.getNick();
		// passwd=u.getPassword();
			if((userForm.equals(this.user) && passwdForm.equals(this.passwd))){
				res=true;
	//			break;
			}
		//}
		return res;

	}

}