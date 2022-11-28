import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mvvm_desgin_app/presentation/resource/routes_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/theme_manager.dart';

class MyApp extends StatefulWidget {
  MyApp._intrenal();
  static final MyApp _instance=MyApp._intrenal();
  factory MyApp()=> _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesGenerator.getRpute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}

