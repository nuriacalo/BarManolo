import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/view/home.dart';
import 'package:t4_1/view/pedidoDetailScreen.dart';
import 'package:t4_1/viewmodel/PedidoViewModel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PedidoViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/home': (context) => MyHomePage(title: "Bar Manolo"),
        '/pedidoDetail': (context) => PedidoDetailScreen(
          pedido: ModalRoute.of(context)!.settings.arguments as dynamic,
        ),
      },
      title: 'Bar Manolo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 179, 44, 96),
        ),
      ),
      home: const MyHomePage(title: 'Bar Manolo'),
    );
  }
}
