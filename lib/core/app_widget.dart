import 'package:flutter/material.dart';
import 'package:mini_projeto_m02/core/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key, required this.initialRoute});
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, initialRoute: initialRoute, routes: AppRoutes.routes);
  }
}
