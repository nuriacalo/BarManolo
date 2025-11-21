import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/model/mesa.dart';
import 'package:t4_1/model/producto.dart';

class Crearpedido extends ChangeNotifier {
  Map<int, Pedido> _pedidos = {};
  int _nextPedidoId = 1;

  List<Pedido> get pedidos => _pedidos.values.toList();

  void addPedido(Mesa mesa, List<Producto> productos) {
    final nuevoPedido = Pedido(
      id: _nextPedidoId,
      idMesa: mesa.id,
      idProducto: productos.map((p) => p.id).toList(),
      totalProductos: productos.length,
      totalPrecio: productos.fold(0, (sum, item) => sum + item.precio),
    );
    _pedidos[_nextPedidoId] = nuevoPedido;
    _nextPedidoId++;
    notifyListeners();
  }

  void removeProducto(int pedidoId, Producto producto) {
    if (_pedidos.containsKey(pedidoId)) {
      final pedido = _pedidos[pedidoId]!;
      if (pedido.idProducto.contains(producto.id)) {
        pedido.idProducto.remove(producto.id);
        pedido.totalProductos = pedido.idProducto.length;
        pedido.totalPrecio -= producto.precio;
        notifyListeners();
      }
    }
  }

  void addProducto(int pedidoId, Producto producto) {
    if (!_pedidos.containsKey(pedidoId)) {
      return;
    }
    final pedido = _pedidos[pedidoId]!;
    pedido.totalPrecio += producto.precio;
    pedido.totalProductos++;

    if (pedido.idProducto.contains(producto.id)) {
      producto.cantidad = (producto.cantidad ?? 0) + 1;
    } else {
      pedido.idProducto.add(producto.id);
      producto.cantidad = 1;
      pedido.totalProductos = pedido.idProducto.length;
      pedido.totalPrecio = pedido.totalPrecio + producto.precio;
    }
    notifyListeners();
  }
}
