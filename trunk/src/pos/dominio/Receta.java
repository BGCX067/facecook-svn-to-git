package pos.dominio;

import java.util.List;

public class Receta {

	private String nombre;
	private String descripcion;
	private String formato;
	private Boolean visibilidad;
	private List<Interes> categoria;
	
	
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getFormato() {
		return formato;
	}
	public void setFormato(String formato) {
		this.formato = formato;
	}
	public Boolean getVisibilidad() {
		return visibilidad;
	}
	public void setVisibilidad(Boolean visibilidad) {
		this.visibilidad = visibilidad;
	}
	public List<Interes> getCategoria() {
		return categoria;
	}
	public void setCategoria(List<Interes> categoria) {
		this.categoria = categoria;
	}
	
	
	
	
	
	
	
	
	
}
