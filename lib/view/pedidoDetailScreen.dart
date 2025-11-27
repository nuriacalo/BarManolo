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
    final Pedido? pedidoActual = pedidoViewModel.pedidos
        .cast<Pedido?>()
        .firstWhere(
          (p) => p?.id == pedido.id,
          orElse: () => null,
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
                          leading: SizedBox(
                            width: 56,
                            child: Image.network(
                                productoActual.imagenUrl ?? 'https://via.placeholder.com/150',
                                fit: BoxFit.cover),
                          ),
                          title: Text(
                            productoActual.nombre ?? 'Producto sin nombre',
                          ),
                          subtitle: Text(
                            'Cantidad: ${lineaActual.cantidad}',
                          ),
                          trailing: Text(
                            '${(productoActual.precio * lineaActual.cantidad).toStringAsFixed(2)} €',
                          )
                        );
                      },
                    ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(bottom: 30),
              alignment: Alignment.topCenter,
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
