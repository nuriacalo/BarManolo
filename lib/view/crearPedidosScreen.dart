import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/model/LineaProducto.dart';
import 'package:t4_1/viewmodel/PedidoViewModel.dart';
import 'package:t4_1/view/seleccionarProductoScreen.dart';
import 'package:t4_1/model/pedido.dart';

/// Pantalla para crear un nuevo pedido
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

  /// Función para validar el número de mesa
  String? _validarNumeroMesa(String? value) {
    if (value == null || value.isEmpty) {
      return 'El número de mesa es obligatorio';
    }
    final numero = int.tryParse(value);
    if (numero == null) {
      return 'Debe ser un número válido';
    }
    if (numero <= 0) {
      return 'El número debe ser positivo';
    }
    if (numero > 100) {
      return 'El número de mesa debe ser menor a 100';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear un Pedido Nuevo')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _mesaController,
              decoration: InputDecoration(
                labelText: 'Número de Mesa',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.table_restaurant),
                helperText: 'Ingrese el número de mesa (1-100)',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: _validarNumeroMesa,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Añadir Producto'),
              onPressed: () async {
                final numMesa = _mesaController.text;
                if (numMesa.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Por favor, ingrese un número de mesa válido.',
                      ),
                    ),
                  );
                  return;
                }

                final pedidoVM = context.read<PedidoViewModel>();
                final idMesaInt = int.tryParse(numMesa) ?? 0;

                Pedido? pedidoExistente;
                try {
                  pedidoExistente = pedidoVM.pedidos.firstWhere(
                    (p) => p.idMesa == idMesaInt,
                  );
                } catch (e) {
                  pedidoExistente = null;
                }

                /// SnackBar informativo si la mesa ya tiene pedido
                if (pedidoExistente != null && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'La Mesa $idMesaInt ya tiene un pedido. Se añadirán los productos.',
                      ),
                      backgroundColor: Colors.blue,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }

                /// Navegar a la pantalla de selección de productos
                final productosSeleccionados =
                    await Navigator.push<List<LineaPedido>>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeleccionarProductoScreen(
                          idMesa: idMesaInt,
                          lineasExistentes: pedidoExistente?.lineasPedido ?? [],
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

            /// Total provisional
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

            /// Botones de acción
            OverflowBar(
              alignment: MainAxisAlignment.end,
              spacing: 8.0,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text('Cancelar'),
                  onPressed: () => Navigator.pop(context),
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.visibility_outlined),
                  label: const Text('Resumen'),
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
                            '/resumen',
                            arguments: pedido,
                          );
                        },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Guardar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
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
