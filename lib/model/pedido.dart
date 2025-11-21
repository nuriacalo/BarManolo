class Pedido {
  final int id;
  final int idMesa;
  List<int> idProducto;
  int totalProductos;
  double totalPrecio;

  Pedido({
    required this.id,
    required this.idMesa,
    required this.idProducto,
    required this.totalProductos,
    required this.totalPrecio,
  });
}
