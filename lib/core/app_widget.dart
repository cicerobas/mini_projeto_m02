import 'package:flutter/material.dart';
import 'package:mini_projeto_m02/core/app_routes.dart';

class AppWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, routes: AppRoutes.routes);
  }
}
