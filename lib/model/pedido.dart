import 'package:t4_1/model/LineaProducto.dart';

/// Modelo de un pedido realizado en una mesa del restaurante.
class Pedido {
  final int id;
  final int idMesa;
  List<LineaPedido> lineasPedido; 

  Pedido({
    required this.id,
    required this.idMesa,
    required this.lineasPedido,
  });

  int get totalProductos => lineasPedido.fold(0, (sum, item) => sum + item.cantidad);

  double get totalPrecio => lineasPedido.fold(0, (sum, item) => sum + (item.producto.precio * item.cantidad));
}
