class Producto {
  final int id;
  final String? nombre;
  int? cantidad;
  final double precio;

  Producto({
    required this.id,
    this.nombre,
    this.cantidad,
    required this.precio,
  });
}