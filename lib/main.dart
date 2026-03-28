import 'package:fitness_app/data/profile_repository.dart';
import 'package:fitness_app/data/routine_repository.dart';
import 'package:fitness_app/pages/homepage.dart';
import 'package:fitness_app/domain/profile_provider.dart';
import 'package:fitness_app/domain/routine_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoutineProvider(RoutineRepository()),),
        ChangeNotifierProvider(create: (_) => ProfileProvider(ProfileRepository()),),
      ],
      child: MaterialApp(
        title: 'Fitness App',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
        ),
        debugShowCheckedModeBanner: true,
        home: const HomePage(),
      ),
    );
  }
}