import 'package:t4_1/data/productos_data.dart';
import 'package:t4_1/model/LineaProducto.dart';
import 'package:t4_1/model/pedido.dart';

/// Datos simulados de pedidos
final List<Pedido> listaDePedidos = [
  Pedido(
    id: 1,
    idMesa: 3,
    lineasPedido: [
      LineaPedido(producto: listaDeProductos[0], cantidad: 2),
      LineaPedido(producto: listaDeProductos[9]),
    ],
  ),
  Pedido(
    id: 2,
    idMesa: 5,
    lineasPedido: [
      LineaPedido(producto: listaDeProductos[5]),
      LineaPedido(producto: listaDeProductos[4]),
    ],
  ),
];
