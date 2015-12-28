package pos.dominio;

import java.util.List;

public class Menu {

	private String nombre;
	private String descripcion;
	private List<Receta> recetas;
	
	
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
	public List<Receta> getRecetas() {
		return recetas;
	}
	
	public void a–adirReceta (List<Receta> recetasElegidas){
		
	}
	
	public List<Receta> esDiario(){
		return null;
		
	}
	public List<List<Receta>> esSemanal(){
		return null;
		
	}
	
	
	
	
}
