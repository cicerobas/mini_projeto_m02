import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mini_projeto_m02/app/data/repositories/auth_repository.dart';
import 'package:mini_projeto_m02/core/app_injection.dart';
import 'package:mini_projeto_m02/core/app_routes.dart';
import 'package:mini_projeto_m02/core/app_widget.dart';
import 'package:mini_projeto_m02/core/result.dart';

void bootstrap() async {
  runZonedGuarded(() async {
    final wb = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: wb);

    await setupDepInjection();

    final user = await depInjection<AuthRepository>().getSavedUser();
    final initialRoute = switch (user) {
      Success(value: final user) => user != null ? AppRoutes.home : AppRoutes.login,
      Failure() => AppRoutes.login,
    };

    FlutterNativeSplash.remove();

    runApp(AppWidget(initialRoute: initialRoute));
  }, (error, stack) {});
}
