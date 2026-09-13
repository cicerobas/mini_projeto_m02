import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projeto_m02/app/bloc/login/login_bloc.dart';
import 'package:mini_projeto_m02/app/view/home_view.dart';
import 'package:mini_projeto_m02/app/view/login_view.dart';
import 'package:mini_projeto_m02/core/app_injection.dart';

class AppRoutes {
  static const home = '/';
  static const login = '/login';

  static final routes = <String, Widget Function(BuildContext)>{
    home: (context) => HomeView(),
    login: (context) => BlocProvider(create: (_) => depInjection<LoginBloc>(), child: const LoginView()),
  };
}
