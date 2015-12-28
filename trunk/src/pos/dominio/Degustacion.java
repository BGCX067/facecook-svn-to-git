package pos.dominio;

import java.util.Date;
import java.util.List;

public class Degustacion {

	private String nombre;
	private String lugar;
	private Date fecha;
	private Integer hora;
	private String descripcion;
	

	public void a–adirDegustadores (List<usuario>amigos) {
	}


	public String getNombre() {
		return nombre;
	}


	public void setNombre(String nombre) {
		this.nombre = nombre;
	}


	public String getLugar() {
		return lugar;
	}


	public void setLugar(String lugar) {
		this.lugar = lugar;
	}


	public Date getFecha() {
		return fecha;
	}


	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}


	public Integer getHora() {
		return hora;
	}


	public void setHora(Integer hora) {
		this.hora = hora;
	}


	public String getDescripcion() {
		return descripcion;
	}


	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	
}
