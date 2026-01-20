import 'package:flutter/material.dart';
import 'package:t4_1/data/productos_data.dart';
import 'package:t4_1/viewmodel/SeleccionarProductoViewModel.dart';
import 'package:t4_1/model/LineaProducto.dart';
import 'package:provider/provider.dart';

/// Pantalla para seleccionar productos para un pedido
class SeleccionarProductoScreen extends StatefulWidget {
  final int idMesa;
  final List<LineaPedido> lineasExistentes;

  const SeleccionarProductoScreen({
    super.key,
    required this.idMesa,
    this.lineasExistentes = const [],
  });

  @override
  State<SeleccionarProductoScreen> createState() =>
      _SeleccionarProductoScreenState();
}

class _SeleccionarProductoScreenState extends State<SeleccionarProductoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SeleccionarProductoViewModel>().limpiar();
      if (widget.lineasExistentes.isNotEmpty) {
        context.read<SeleccionarProductoViewModel>().inicializarConLineas(
          widget.lineasExistentes,
        );
      }
      context.read<SeleccionarProductoViewModel>().seleccionarMesa(
        widget.idMesa,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SeleccionarProductoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar productos (Mesa ${widget.idMesa})'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text("Selecciona productos", style: TextStyle(fontSize: 18)),
          /// Lista de productos disponibles
          Expanded(
            child: ListView.builder(
              itemCount: listaDeProductos.length,
              itemBuilder: (_, index) {
                final producto = listaDeProductos[index];
                final linea = vm.lineasPedido.firstWhere(
                  (l) => l.producto.id == producto.id,
                  orElse: () => LineaPedido(producto: producto, cantidad: 0),
                );
                return ListTile(
                  leading: SizedBox(
                    width: 56,
                    height: 56,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        producto.imagenUrl ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(producto.nombre ?? "Sin nombre"),
                  subtitle: Text("${producto.precio.toStringAsFixed(2)} €"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => vm.eliminarProducto(producto),
                      ),
                      Text(
                        "${linea.cantidad}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => vm.agregarProducto(producto),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: OverflowBar(
              alignment: MainAxisAlignment.spaceAround,
              spacing: 8.0,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text('Cancelar'),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Confirmar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: vm.lineasPedido.isEmpty
                      ? null
                      : () => Navigator.pop(context, vm.lineasPedido),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
