import 'package:flutter/material.dart';
import 'package:t4_1/data/productos_data.dart';
import 'package:t4_1/viewmodel/SeleccionarProductoViewModel.dart';
import 'package:t4_1/model/LineaProducto.dart';
import 'package:provider/provider.dart';

class SeleccionarProductoScreen extends StatefulWidget {
  final int idMesa;

  const SeleccionarProductoScreen({super.key, required this.idMesa});

  @override
  State<SeleccionarProductoScreen> createState() => _SeleccionarProductoScreenState();
}

class _SeleccionarProductoScreenState extends State<SeleccionarProductoScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SeleccionarProductoViewModel>(); 

    return Scaffold(
      appBar:
          AppBar(title: Text('Seleccionar productos (Mesa ${widget.idMesa})')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text("Selecciona productos", style: TextStyle(fontSize: 18)),

          Expanded(
            child: ListView.builder(
              itemCount: listaDeProductos.length,
              itemBuilder: (_, index) {
                final producto = listaDeProductos[index];

                final linea = _viewModel.lineasPedido.firstWhere(
                  (l) => l.producto.id == producto.id,
                  orElse: () => LineaPedido(producto: producto, cantidad: 0),
                );

                return ListTile(
                  leading: Image.network(producto.imagenUrl ?? ""),
                  title: Text(producto.nombre ?? "Sin nombre"),
                  subtitle: Text("${producto.precio.toStringAsFixed(2)} €"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => _viewModel.eliminarProducto(producto),
                      ),
                      Text(
                        "${linea.cantidad}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _viewModel.agregarProducto(producto),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // ------ BOTONES -------
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // cancelar → no devuelve datos
                    },
                    child: const Text("Cancelar"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: vm.lineasPedido.isEmpty ? null : () {
                      // O ViewModel xa ten a lista actualizada.
                      // Simplemente volvemos. A pantalla anterior xa está
                      // escoitando os cambios no ViewModel.
                      Navigator.pop(context, vm.lineasPedido);
                    },
                    child: const Text("Confirmar selección"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
}
