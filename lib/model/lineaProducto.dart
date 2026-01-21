import 'package:t4_1/model/producto.dart';

/// Representa una línea de producto en un pedido con su cantidad.
class LineaPedido {
  final Producto producto;
  int cantidad;

  LineaPedido({required this.producto, this.cantidad = 1});
}
