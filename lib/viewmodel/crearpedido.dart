import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/model/mesa.dart';
import 'package:t4_1/model/producto.dart';

class Crearpedido extends ChangeNotifier{
  List<Pedido> pedidos = [];

  void addPedido(Mesa mesa, List<Producto> productos) {
    final nuevoPedido = Pedido(
      id: pedidos.length + 1,
      idMesa: mesa.id,
      idProducto: productos.map((p) => p.id).toList(),
      totalProductos: productos.length,
      totalPrecio: productos.fold(0, (sum, item) => sum + item.precio),
    );
    pedidos.add(nuevoPedido);
    notifyListeners();
  }
}
