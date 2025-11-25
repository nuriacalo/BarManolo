import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/viewmodel/PedidoViewModel.dart';

class PedidoDetailScreen extends StatelessWidget {
  final Pedido pedido;

  const PedidoDetailScreen({super.key, required this.pedido});
  @override
  Widget build(BuildContext context) {
    final pedidoViewModel = context.watch<PedidoViewModel>();
    final Pedido? pedidoActual = pedidoViewModel.pedidos.firstWhere(
      (pedido) => pedido.id == pedido.id,
      orElse: () => pedido,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Pedido de la Mesa ${pedido.idMesa}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumen del Pedido:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 10),
            Expanded(
              child: pedidoActual == null
                  ? Text('Pedido no encontrado.')
                  : ListView.builder(
                      itemCount: pedidoActual.lineasPedido.length,
                      itemBuilder: (context, index) {
                        final lineaActual = pedidoActual.lineasPedido[index];
                        final productoActual = lineaActual.producto;

                        return ListTile(
                          leading: Text(
                            '${(productoActual.precio * lineaActual.cantidad).toStringAsFixed(2)} €',
                          ),
                          title: Text(
                            productoActual.nombre ?? 'Producto sin nombre',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  context
                                      .read<PedidoViewModel>()
                                      .disminuirCantidad(
                                        pedidoActual.id,
                                        productoActual.id,
                                      );
                                },
                              ),
                              Text(
                                lineaActual.cantidad.toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                              IconButton(
                                icon: Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  context
                                      .read<PedidoViewModel>()
                                      .aumentarCantidad(
                                        pedidoActual.id,
                                        productoActual.id,
                                      );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            SizedBox(height: 20),
            // Muestra el total del pedido al final
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total: ${pedidoActual?.totalPrecio.toStringAsFixed(2) ?? "0.00"} €',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
