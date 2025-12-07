import 'package:app_projeto/screens/info/info_view.dart';
import 'package:app_projeto/screens/register/register_view.dart';
import 'package:flutter/material.dart';
import '../screens/login/login_view.dart';
import '../screens/home/home_view.dart';

class AppRoutes {
  // Nomes de rota para referências fáceis
  static const String initial = LoginView.routeName; // Usa a rota da View
  static const String login = LoginView.routeName;
  static const String home = HomeView.routeName;
  static const String info = InfoView.routeName;
  static const String register = RegisterView.routeName;

  // O mapa de rotas que mapeia nomes de rota para widgets de tela.
  static Map<String, Widget Function(BuildContext)> routes = {
    login: (context) => const LoginView(),
    home: (context) => const HomeView(),
    info: (context) => const InfoView(),
    register: (context) => const RegisterView(),
  };
}