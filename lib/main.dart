import 'package:fitness_app/pages/homepage.dart';
import 'package:fitness_app/providers/routine_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoutineProvider(),
      child: MaterialApp(
        title: 'Fitness App',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.lightGreenAccent),
        ),
        debugShowCheckedModeBanner: true,
        home: const HomePage(),
      ),
    );
  }
}
