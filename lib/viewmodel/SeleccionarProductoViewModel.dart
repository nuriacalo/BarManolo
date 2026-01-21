import 'package:flutter/foundation.dart';
import 'package:t4_1/model/LineaProducto.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/model/producto.dart';


/// ViewModel para gestionar la selección temporal de productos al crear un pedido.
class SeleccionarProductoViewModel extends ChangeNotifier {
  int? _idMesaSeleccionada;
  List<LineaPedido> _lineasPedidoActuales = [];

  int? get idMesa => _idMesaSeleccionada;
  List<LineaPedido> get lineasPedido => _lineasPedidoActuales;

  double get totalActual => _lineasPedidoActuales.fold(
    0,
    (sum, item) => sum + (item.producto.precio * item.cantidad),
  );

  void seleccionarMesa(int idMesa) {
    _idMesaSeleccionada = idMesa;
    notifyListeners();
  }

  /// Si el producto ya existe, aumenta su cantidad.
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

  /// Disminuye la cantidad o elimina el producto si llega a 0.
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

  /// Crea el objeto Pedido si hay mesa y productos seleccionados.
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

  /// Inicializa con líneas existentes (útil al editar un pedido).
  void inicializarConLineas(List<LineaPedido> lineas) {
    _lineasPedidoActuales =
        lineas.map((l) => LineaPedido(producto: l.producto, cantidad: l.cantidad)).toList();
    notifyListeners();
  }
}
