
/// Modelo de datos para un producto
class Producto {
  final int id;
  final String? nombre;
  final double precio;
  final String? imagenUrl;

  Producto({
    required this.id,
    this.nombre,
    required this.precio,
    this.imagenUrl,
  });
}
