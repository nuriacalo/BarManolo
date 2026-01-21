import 'package:t4_1/model/LineaProducto.dart';

/// Modelo de datos que representa un pedido realizado en una mesa del bar.
class Pedido {
  final int id;
  final int idMesa;
  List<LineaPedido> lineasPedido; 

  Pedido({
    required this.id,
    required this.idMesa,
    required this.lineasPedido,
  });

  /// Calcula el total de productos sumando las cantidades
  int get totalProductos => lineasPedido.fold(0, (sum, item) => sum + item.cantidad);

  /// Calcula el precio total del pedido
  double get totalPrecio => lineasPedido.fold(0, (sum, item) => sum + (item.producto.precio * item.cantidad));
}
