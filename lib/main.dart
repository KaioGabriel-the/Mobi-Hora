import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/login_controller.dart';
import 'app/routers.dart';


void main() {

  runApp(
    ChangeNotifierProvider(
      create: (context) => LoginController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobi Hora',

      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),

      initialRoute: AppRoutes.initial,

      routes: AppRoutes.routes,
    );
  }
}