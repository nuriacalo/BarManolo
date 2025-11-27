import 'package:flutter/material.dart';
import 'package:t4_1/model/LineaProducto.dart';
import 'package:t4_1/view/seleccionarProductoScreen.dart';
import 'package:t4_1/model/pedido.dart';

class CrearPedidosScreen extends StatefulWidget {
  const CrearPedidosScreen({super.key});

  @override
  State<CrearPedidosScreen> createState() => _CrearPedidosScreenState();
}

class _CrearPedidosScreenState extends State<CrearPedidosScreen> {
  final _mesaController = TextEditingController();
  List<LineaPedido> _lineasPedido = [];

  @override
  void dispose() {
    _mesaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear un Pedido Nuevo')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _mesaController,
              decoration: InputDecoration(
                labelText: 'Número de Mesa',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.table_restaurant),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Añadir Producto'),
              onPressed: () async {
                final numMesa = _mesaController.text;
                if (numMesa.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Por favor, ingrese un número de mesa válido.',
                      ),
                    ),
                  );
                  return;
                }
                final productosSeleccionados =
                    await Navigator.push<List<LineaPedido>>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeleccionarProductoScreen(
                          idMesa: int.tryParse(numMesa) ?? 0,
                        ),
                      ),
                    );
                if (mounted && productosSeleccionados != null) {
                  setState(() {
                    _lineasPedido = productosSeleccionados;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Resumen Provisional',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _lineasPedido.length,
                itemBuilder: (context, index) {
                  final linea = _lineasPedido[index];
                  return ListTile(
                    title: Text(linea.producto.nombre ?? 'Sin nombre'),
                    subtitle: Text('Cantidad: ${linea.cantidad}'),
                    trailing: Text(
                      '${(linea.producto.precio * linea.cantidad).toStringAsFixed(2)} €',
                    ),
                  );
                },
              ),
            ),
            // O total calcúlase aquí, xusto antes de mostrarse.
            Builder(
              builder: (context) {
                final totalProvisional = _lineasPedido.fold<double>(
                  0.0,
                  (sum, item) => sum + (item.producto.precio * item.cantidad),
                );
                return Text(
                  'Total Provisional: ${totalProvisional.toStringAsFixed(2)} €',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context), // Cancelar
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed:
                      (_lineasPedido.isEmpty || _mesaController.text.isEmpty)
                      ? null
                      : () {
                          final pedido = Pedido(
                            id: 0,
                            idMesa: int.parse(_mesaController.text),
                            lineasPedido: _lineasPedido,
                          );
                          Navigator.pushNamed(
                            context,
                            '/resumen', // Usamos a nova ruta nomeada.
                            arguments: pedido,
                          );
                        },
                  child: const Text('Ver Resumen'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final numMesa = _mesaController.text;
                    if (numMesa.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('O número de mesa é obrigatorio.'),
                        ),
                      );
                      return;
                    }
                    if (_lineasPedido.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Debe engadir polo menos un produto.'),
                        ),
                      );
                      return;
                    }

                    final pedidoCompleto = Pedido(
                      id: 0,
                      idMesa: int.parse(numMesa),
                      lineasPedido: _lineasPedido,
                    );
                    if (mounted) {
                      Navigator.pop(context, pedidoCompleto);
                    }
                  },
                  child: const Text('Guardar Pedido'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
