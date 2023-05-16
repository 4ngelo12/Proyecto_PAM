class CalzadoProd {
  int id;
  String nombre;
  String categoria;
  String marca;
  double precio;
  int cantidad;
  String descripcion;

  CalzadoProd(
      this.id,
      this.nombre,
      this.categoria,
      this.marca,
      this.precio,
      this.cantidad,
      this.descripcion
      );
}

final List<CalzadoProd> calzados = [
  CalzadoProd(1, "Zapatilla nike", "Zapatilla", "Nike", 44.5, 66, "nOSE"),
  CalzadoProd(2, "Zapato", "Zapato", "Nike", 84.5, 66, "nOSE"),
  CalzadoProd(3, "Zapato ESCOLAR", "Zapato", "Nike", 74.5, 66, "nOSE"),
  CalzadoProd(4, "Zapatilla Deportiva", "Zapatilla", "Adidas", 54.5, 66, "nOSE"),
  CalzadoProd(5, "Botas", "Botas", "Puma", 104.5, 86, "nOSE"),

];