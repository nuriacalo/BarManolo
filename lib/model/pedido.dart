class Pedido {
  final int id;
  final int idMesa;
  final List<int> idProducto;
  final int totalProductos;
  final double totalPrecio;

  Pedido({
    required this.id,
    required this.idMesa,
    required this.idProducto,
    required this.totalProductos,
    required this.totalPrecio,
  });
}
