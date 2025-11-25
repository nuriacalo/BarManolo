import 'package:flutter/material.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/viewmodel/PedidoViewModel.dart';
import 'package:provider/provider.dart';

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(
              image: AssetImage('assets/manolo.png'),
              width: 400,
              height: 300,
            ),
            Text(
              'Lista de Pedidos',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Container(
              height: 300,
              width: 350,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: ListView.builder(
                itemCount: pedidoViewModel.pedidos.length,
                itemBuilder: (BuildContext context, int index) {
                  final Pedido pedido = pedidoViewModel.pedidos[index];
                  return Dismissible(
                    key: ValueKey(pedido.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      pedidoViewModel.eliminarPedido(pedido.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Pedido de Mesa ${pedido.idMesa} eliminado',
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.receipt_long),
                      title: Text('Pedido de la Mesa ${pedido.idMesa}'),
                      subtitle: Text('${pedido.totalProductos} productos'),
                      trailing: Text(
                        '${pedido.totalPrecio.toStringAsFixed(2)} €',
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/pedidoDetail',
                          arguments: pedido,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Esta línea daría error hasta que creemos la pantalla y la ruta
          // Navigator.pushNamed(context, '/seleccionarProducto');
          print("Botón para añadir pedido pulsado!"); // Placeholder temporal
        },
        tooltip: 'Añadir Pedido',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
