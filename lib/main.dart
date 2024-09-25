import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_flutter_challenger_v2/bindings/initial_bindings.dart';
import 'package:tractian_flutter_challenger_v2/routes/app_routes.dart';

void main() {
  InitialBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Asset Tree Viewer',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}