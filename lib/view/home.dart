import 'package:flutter/material.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/viewmodel/PedidoViewModel.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/view/crearPedidosScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final pedidoViewModel = context.watch<PedidoViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(200, 207, 55, 96),
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Image.asset(
            'assets/manolo.png',
            height: 150,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Lista de Pedidos',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pedidoViewModel.pedidos.length,
              itemBuilder: (BuildContext context, int index) {
                final Pedido pedido = pedidoViewModel.pedidos[index];
                return Dismissible(
                  key: ValueKey(pedido.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    pedidoViewModel.eliminarPedido(pedido.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Pedido de Mesa ${pedido.idMesa} eliminado'),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    child: ListTile(
                      leading: const Icon(Icons.receipt_long),
                      title: Text('Pedido de la Mesa ${pedido.idMesa}'),
                      subtitle: Text('${pedido.totalProductos} productos'),
                      trailing: Text(
                        '${pedido.totalPrecio.toStringAsFixed(2)} €',
                      ),
                      onTap: () => Navigator.pushNamed(context, '/pedidoDetail',
                          arguments: pedido),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nuevoPedido = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CrearPedidosScreen()),
          );

          if (nuevoPedido != null && nuevoPedido is Pedido && mounted) {
            context.read<PedidoViewModel>().agregarPedido(nuevoPedido);
          }
        },
        tooltip: 'Añadir Pedido',
        child: const Icon(Icons.add),
      ),
    );
  }
}
