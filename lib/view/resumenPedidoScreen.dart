import 'package:flutter/material.dart';
import 'package:t4_1/model/pedido.dart';

class ResumenPedidoScreen extends StatelessWidget {
  final Pedido pedido;

  const ResumenPedidoScreen({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo do Pedido (Mesa ${pedido.idMesa})'),
      ),
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
                  return ListTile(
                    title: Text(linea.producto.nombre ?? 'Sen nome'),
                    subtitle: Text('Cantidade: ${linea.cantidad}'),
                    trailing: Text(
                      '${(linea.producto.precio * linea.cantidad).toStringAsFixed(2)} €',
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Text(
              'Total Final: ${pedido.totalPrecio.toStringAsFixed(2)} €',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
