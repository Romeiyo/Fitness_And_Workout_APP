import 'package:fitness_app/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Fitness App',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.lightGreenAccent),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteManager.homepage,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
