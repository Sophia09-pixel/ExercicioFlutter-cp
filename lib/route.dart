import 'package:exercicio_cp/screens/home.dart';
import 'package:exercicio_cp/screens/select.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/home';
  static const String select = '/select';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case select:
        return MaterialPageRoute(builder: (_) => SelectPage());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  Scaffold(body: Center(child: Text('Rota não encontrada!'))),
        );
    }
  }
}