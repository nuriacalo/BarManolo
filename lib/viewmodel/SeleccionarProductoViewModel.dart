import 'package:flutter/foundation.dart';
import 'package:t4_1/model/LineaProducto.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/model/producto.dart';


/// ViewModel para gestionar la selección de productos y la mesa asociada.
class SeleccionarProductoViewModel extends ChangeNotifier {
  int? _idMesaSeleccionada;
  List<LineaPedido> _lineasPedidoActuales = [];

  int? get idMesa => _idMesaSeleccionada;
  List<LineaPedido> get lineasPedido => _lineasPedidoActuales;

/// Calcula el total actual del pedido basado en las líneas de pedido.
  double get totalActual => _lineasPedidoActuales.fold(
    0,
    (sum, item) => sum + (item.producto.precio * item.cantidad),
  );

/// Selecciona una mesa por su ID.
  void seleccionarMesa(int idMesa) {
    _idMesaSeleccionada = idMesa;
    notifyListeners();
  }

/// Agrega un producto al pedido actual.
/// Si el producto ya está en el pedido, aumenta su cantidad.
  void agregarProducto(Producto producto) {
    final index = _lineasPedidoActuales.indexWhere(
      (linea) => linea.producto.id == producto.id,
    );

    if (index != -1) {
      _lineasPedidoActuales[index].cantidad++;
    } else {
      _lineasPedidoActuales.add(LineaPedido(producto: producto, cantidad: 1));
    }
    notifyListeners();
  }

/// Elimina un producto del pedido actual.
/// Si la cantidad es mayor a 1, disminuye la cantidad en 1.
/// De lo contrario, lo elimina del pedido.
  void eliminarProducto(Producto producto) {
    final index = _lineasPedidoActuales.indexWhere(
      (linea) => linea.producto.id == producto.id,
    );
    if (index != -1) {
      if (_lineasPedidoActuales[index].cantidad > 1) {
        _lineasPedidoActuales[index].cantidad--;
      } else {
        _lineasPedidoActuales.removeAt(index);
      }
      notifyListeners();
    }
  }

  /// Finaliza el pedido actual y devuelve un objeto Pedido si es válido.
  Pedido? finalizarPedido() {
    if (_idMesaSeleccionada != null && _lineasPedidoActuales.isNotEmpty) {
      return Pedido(
        id: 0,
        idMesa: _idMesaSeleccionada!,
        lineasPedido: _lineasPedidoActuales,
      );
    }
    return null;
  }

  void limpiar() {
    _idMesaSeleccionada = null;
    _lineasPedidoActuales = [];
    notifyListeners();
  }

  void inicializarConLineas(List<LineaPedido> lineas) {
    // Creamos una copia para no modificar la lista original del otro ViewModel
    _lineasPedidoActuales =
        lineas.map((l) => LineaPedido(producto: l.producto, cantidad: l.cantidad)).toList();
    notifyListeners();
  }
}
