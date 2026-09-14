import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_projeto_m02/core/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key, required this.initialRoute});
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateInitialRoutes: (_) {
        return [MaterialPageRoute(builder: AppRoutes.routes[initialRoute]!)];
      },
      routes: AppRoutes.routes,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Color(0xFF673D8C))),
    );
  }
}
