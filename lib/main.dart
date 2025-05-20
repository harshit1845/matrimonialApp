import 'package:flutter/material.dart';
import 'package:matrimonial_app/routes/routes.dart';


void main() {
  runApp(MatrimonyApp());
}

class MatrimonyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matrimony App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
