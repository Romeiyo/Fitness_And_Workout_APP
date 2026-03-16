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
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({this.optionalMessage, super.key});

  static const String appName = "Fitness & Tracker Tracker";
  final String? optionalMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.lightGreenAccent, Colors.lightBlueAccent]),
          ),
        ),
        title: const Text(appName),
        leading: const Icon(Icons.fitness_center),
        actions: [
          IconButton(onPressed: () {}, 
          icon: Icon(Icons.search),
          ),
          IconButton(onPressed: () {}, 
          icon: Icon(Icons.person),
          )
        ],
      ),

      body: Center(
        child: Text(optionalMessage ?? 'Welcome to your Fitness & Workout App...'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        ),
    );
  }
}

