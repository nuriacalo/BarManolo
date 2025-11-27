import 'package:flutter/material.dart';
import 'package:t4_1/model/pedido.dart';

class ResumenPedidoScreen extends StatelessWidget {
  final Pedido pedido;

  const ResumenPedidoScreen({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumen del Pedido')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mesa: ${pedido.idMesa}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text('Produtos:', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: pedido.lineasPedido.length,
                itemBuilder: (context, index) {
                  final linea = pedido.lineasPedido[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      leading: SizedBox(
                        width: 56,
                        height: 56,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            linea.producto.imagenUrl ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(linea.producto.nombre ?? 'Sin nombre'),
                      subtitle: Text('Cantidad: ${linea.cantidad}'),
                      trailing: Text(
                        '${(linea.producto.precio * linea.cantidad).toStringAsFixed(2)} €',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(24.0),
        child: Text(
          'Total Final: ${pedido.totalPrecio.toStringAsFixed(2)} €',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
