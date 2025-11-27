import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/data/pedidos_data.dart';

class PedidoViewModel extends ChangeNotifier {
  final Map<int, Pedido> _pedidos = {};
  int _nextPedidoId = 1;

  PedidoViewModel() {
    for (var pedido in listaDePedidos) {
      agregarPedido(pedido);
    }
  }

  List<Pedido> get pedidos => _pedidos.values.toList();

  void agregarPedido(Pedido pedido) {
    Pedido? pedidoExistente;
    try {
      pedidoExistente = _pedidos.values.firstWhere(
        (p) => p.idMesa == pedido.idMesa,
      );
    } catch (e) {
      pedidoExistente = null;
    }

    if (pedidoExistente != null) {
      for (var nuevaLinea in pedido.lineasPedido) {
        final index = pedidoExistente.lineasPedido.indexWhere(
          (l) => l.producto.id == nuevaLinea.producto.id,
        );

        if (index != -1) {
          pedidoExistente.lineasPedido[index].cantidad += nuevaLinea.cantidad;
        } else {
          pedidoExistente.lineasPedido.add(nuevaLinea);
        }
      }
    } else {
      final nuevoPedidoConId = Pedido(
        id: _nextPedidoId,
        idMesa: pedido.idMesa,
        lineasPedido: pedido.lineasPedido,
      );
      _pedidos[_nextPedidoId] = nuevoPedidoConId;
      _nextPedidoId++;
    }

    notifyListeners();
  }

  void eliminarPedido(int id) {
    _pedidos.remove(id);
    notifyListeners();
  }

  void aumentarCantidad(int pedidoId, int productoId) {
    final pedido = _pedidos[pedidoId];
    if (pedido != null) {
      final lineaIndex = pedido.lineasPedido.indexWhere(
        (l) => l.producto.id == productoId,
      );
      if (lineaIndex != -1) {
        pedido.lineasPedido[lineaIndex].cantidad++;
        notifyListeners();
      }
    }
  }

  void disminuirCantidad(int pedidoId, int productoId) {
    final pedido = _pedidos[pedidoId];
    if (pedido != null) {
      final lineaIndex = pedido.lineasPedido.indexWhere(
        (l) => l.producto.id == productoId,
      );
      if (lineaIndex != -1) {
        if (pedido.lineasPedido[lineaIndex].cantidad > 1) {
          pedido.lineasPedido[lineaIndex].cantidad--;
        } else {
          pedido.lineasPedido.removeAt(lineaIndex);
        }
        notifyListeners();
      }
    }
  }
}
