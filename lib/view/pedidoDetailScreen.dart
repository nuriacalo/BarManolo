import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/viewmodel/PedidoViewModel.dart';

class PedidoDetailScreen extends StatelessWidget {
  final Pedido pedido;

  const PedidoDetailScreen({super.key, required this.pedido});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pedido de la Mesa ${pedido.idMesa}')),
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Resumen del Pedido:',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: pedido.lineasPedido.length,
                    itemBuilder: (context, index) {
                      final lineaActual = pedido.lineasPedido[index];
                      final productoActual = lineaActual.producto;
                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: SizedBox(
                            width: 56,
                            height: 56, 
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                productoActual.imagenUrl ?? '...',
                                fit: BoxFit.cover, 
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            ),
                          ),
                          title: Text(
                            productoActual.nombre ?? 'Producto sin nombre',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Cantidad: ${lineaActual.cantidad}',
                          ),
                          trailing: Text(
                            '${(productoActual.precio * lineaActual.cantidad).toStringAsFixed(2)} €',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            decoration: BoxDecoration(color: Colors.grey.shade200),
            child: Text(
              'Total: ${pedido.totalPrecio.toStringAsFixed(2)} €',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
