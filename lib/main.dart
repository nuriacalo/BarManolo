import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/view/crearPedidosScreen.dart';
import 'package:t4_1/view/home.dart';
import 'package:t4_1/view/pedidoDetailScreen.dart';
import 'package:t4_1/view/resumenPedidoScreen.dart';
import 'package:t4_1/view/seleccionarProductoScreen.dart';
import 'package:t4_1/viewmodel/PedidoViewModel.dart';
import 'package:t4_1/viewmodel/SeleccionarProductoViewModel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PedidoViewModel())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bar Manolo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Bar Manolo'),
        '/crearPedidosScreen': (context) => const CrearPedidosScreen(),
        '/pedidoDetail': (context) {
          final pedido = ModalRoute.of(context)!.settings.arguments as Pedido;
          return PedidoDetailScreen(pedido: pedido);
        },
        '/resumen': (context) {
          final pedido = ModalRoute.of(context)!.settings.arguments as Pedido;
          return ResumenPedidoScreen(pedido: pedido);
        },
      },
    );
  }
}
