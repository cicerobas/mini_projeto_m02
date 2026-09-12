import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_projeto_m02/core/app_widget.dart';

void bootstrap() async {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(AppWidget());
  }, (error, stack) {});
}
