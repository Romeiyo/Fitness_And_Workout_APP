import 'package:fitness_app/routes/routes.dart';
import 'package:fitness_app/widgets/workout_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
   const HomePage({super.key});
 
   @override
   State<HomePage> createState() => _HomePageState();
 }
 
 class _HomePageState extends State<HomePage> {

   static const String appName = "Fitness & Workout Tracker";
   String? optionalMessage;

   final List<Map<String, String>> workoutCategories = [
     {'exercise': 'Aerobic Exercises', 'image': 'assets/aerobic.jpg',},
     {'exercise': 'Balance Exercises', 'image': 'assets/balance.jpg',},
     {'exercise': 'Cardio Exercises', 'image': 'assets/cardio.jpg',},
     {'exercise': 'Flexibility Exercises', 'image': 'assets/flexibility.jpg',},
     {'exercise': 'Mobility Training', 'image': 'assets/mobility.jpg',},
     {'exercise': 'Strength Workout', 'image': 'assets/strength.jpg',},
     {'exercise': 'Stretching Exercises', 'image': 'assets/stretching.jpg',},
     {'exercise': 'Warm-Up Exercises', 'image': 'assets/warmup.jpg',},
     {'exercise': 'Yoga Exercises', 'image': 'assets/yoga.jpg',},
   ];

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
           IconButton(onPressed: () {
            Navigator.of(context).pushNamed(RouteManager.bmiCalculator);
           },
             icon: Icon(Icons.calculate),
           ),
           IconButton(onPressed: () {},
             icon: Icon(Icons.person),
           )
         ],
       ),

       body: Padding(
           padding: const EdgeInsets.all(16.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Container(
              
              height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('assets/day.jpg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 8,
                    offset: const Offset(0, 2)
                  )
                ]
              ),

              child: 
                  Stack(
                    children: [
                      Center(
                        child: Text(
                          'Featured Workout of the Day',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 4
                              ..color = Colors.white70,                        
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Featured Workout of the Day',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.02,
                        child: FloatingActionButton.small(
                          onPressed: () {},
                          child: Text('Start'),
                        ),
                      ),
                    ]
                  ), 
             ),

             SizedBox(height: 5,),

             Text(optionalMessage ?? 'Welcome to the Fitness App Random User...'),

             const SizedBox(height: 5,),

             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
                     'Workout Categories'
                 ),
                 Text(
                   '${workoutCategories.length} Categories',
                 ),
               ],
             ),

             const SizedBox(height: 20,),

             Expanded(
                 child: LayoutBuilder(
                     builder: (context, constraints) {
                       int crossAxisCount;
                       if (constraints.maxWidth >= 900)
                         {
                           crossAxisCount = 4;
                         }
                       else if (constraints.maxWidth >= 600)
                         {
                           crossAxisCount = 3;
                         }
                       else
                         {
                           crossAxisCount = 2;
                         }

                       return GridView.builder(
                         itemCount: workoutCategories.length,
                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                             crossAxisCount: crossAxisCount,
                             crossAxisSpacing: 12,
                             mainAxisSpacing: 12,
                             childAspectRatio: 0.85,
                           ),
                           itemBuilder: (context, index) {
                            final train = workoutCategories[index];
                            return WorkoutTile(
                                 exercise: train['exercise']!,
                                 image: train['image']!,
                            );
                           },
                       );
                     }
                 )
             ),
           ],
         )
       ),

       floatingActionButton: FloatingActionButton(
         onPressed: () {
           setState(() {
             workoutCategories.add({
               'exercise': 'Pilates',
               'image': 'assets/pilates.jpg',
             });
           });
           ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text('Workout Categories count: ${workoutCategories.length}')),
           );
         },
         child: const Icon(Icons.add),
       ),
     );
   }
 }
 