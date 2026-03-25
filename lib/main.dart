import 'package:fitness_app/pages/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.lightGreenAccent),
      ),
      debugShowCheckedModeBanner: true,
      // initialRoute: RouteManager.homepage,
      // onGenerateRoute: RouteManager.generateRoute,
      home: const HomePage(),
    );
  }
}
