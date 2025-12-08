import 'package:app_projeto/screens/info/info_view.dart';
import 'package:app_projeto/screens/register/register_view.dart';
import 'package:app_projeto/screens/stop_create/stop_create_view.dart';
import 'package:app_projeto/screens/stop_detail/stop_detail_view.dart';
import 'package:app_projeto/screens/stop_map_view/stop_map_view.dart';
import 'package:app_projeto/screens/stops/stops_view.dart';
import 'package:app_projeto/screens/user_profile_view/user_profile_view.dart';
import 'package:flutter/material.dart';
import '../screens/bus_add/bus_add_view.dart';
import '../screens/bus_detail/bus_detail_view.dart';
import '../screens/bus_list/bus_list_view.dart';
import '../screens/login/login_view.dart';
import '../screens/home/home_view.dart';

class AppRoutes {
  // Nomes de rota para referências fáceis
  static const String initial = LoginView.routeName;
  static const String login = LoginView.routeName;
  static const String home = HomeView.routeName;
  static const String info = InfoView.routeName;
  static const String register = RegisterView.routeName;
  static const String stop = StopsView.routeName;
  static const String stopdetail = StopDetailView.routeName;
  static const String stopcreate = StopCreateView.routeName;
  static const String stopmap = StopMapView.routeName;
  static const String profile = UserProfileView.routeName;
  static const String buslist = BusDetailView().routeName;
  static const String bus_detail = BusDetailView.routeName;
  static const String bus_add = AddBusView().routeName;

  // O mapa de rotas que mapeia nomes de rota para widgets de tela.
  static Map<String, Widget Function(BuildContext)> routes = {
    login: (context) => const LoginView(),
    home: (context) => const HomeView(),
    info: (context) => const InfoView(),
    register: (context) => const RegisterView(),
    stop: (context) => const StopsView(),
    stopdetail: (context) => const StopDetailView(),
    stopcreate: (context) => const StopCreateView(),
    stopmap: (context) => const StopMapView(),
    profile: (context) => const UserProfileView(),
    buslist: (context) => const BusListView(),
    bus_detail: (context) => const BusDetailView(),
    bus_add: (context) => const AddBusView(),
  };
}
