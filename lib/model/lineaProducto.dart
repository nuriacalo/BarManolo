import 'package:t4_1/model/producto.dart';

class LineaPedido {
  final Producto producto;
  int cantidad;

  LineaPedido({required this.producto, this.cantidad = 1});
}
