import 'package:flutter/material.dart';
import 'package:mini_projeto_m02/app/view/home_view.dart';

class AppRoutes {
  static const home = '/';

  static final routes = <String, Widget Function(BuildContext)>{home: (context) => HomeView()};
}
