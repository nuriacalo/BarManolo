import 'package:t4_1/model/producto.dart';

/// Modelo de datos para representar una línea de producto en un pedido
class LineaPedido {
  final Producto producto;
  int cantidad;

  LineaPedido({required this.producto, this.cantidad = 1});
}
