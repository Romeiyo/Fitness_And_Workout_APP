import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/workout_tracking_provider.dart';
import '../../domain/workout_phase.dart';
import '../widgets/location_permission_card.dart';
import '../widgets/workout_summary_card.dart';
import '../widgets/custom_button.dart';  // Reuse your existing button

class OutdoorWorkoutScreen extends StatelessWidget {
  const OutdoorWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outdoor Workout'),
        backgroundColor: Colors.greenAccent,
        elevation: 2,
      ),
      body: Consumer<WorkoutTrackingProvider>(
        builder: (context, provider, child) {
          // Show loading state
          if (provider.isLoadingLocation && provider.workoutPhase == WorkoutPhase.idle) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Starting GPS...'),
                ],
              ),
            );
          }
          
          // Show different UI based on workout phase
          switch (provider.workoutPhase) {
            case WorkoutPhase.idle:
              return _buildIdlePhase(context, provider);
            case WorkoutPhase.active:
              return _buildActivePhase(context, provider);
            case WorkoutPhase.finished:
              return _buildFinishedPhase(context, provider);
          }
        },
      ),
    );
  }
  
  Widget _buildIdlePhase(BuildContext context, WorkoutTrackingProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero icon
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.green, Colors.lightGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.directions_run,
              size: 80,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          
          const Text(
            'Track Your Outdoor Workout',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          
          Text(
            'GPS will track your distance and time\n'
            'Perfect for running, walking, or cycling',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          
          // Error message if any
          if (provider.errorMessage != null)
            LocationPermissionCard(
              errorMessage: provider.errorMessage!,
              onRetry: () => provider.startWorkout(),
            ),
          
          const SizedBox(height: 20),
          
          // Start button - reuse your CustomButton
          CustomButton(
            onTap: () => provider.startWorkout(),
            label: 'Start Run',
          ),
        ],
      ),
    );
  }
  
  Widget _buildActivePhase(BuildContext context, WorkoutTrackingProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timer display
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  'ELAPSED TIME',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  provider.formattedTime,
                  style: const TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Current location card
          if (provider.currentPosition != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      const Text(
                        'Current Position',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lat: ${provider.currentPosition!.latitude.toStringAsFixed(6)} | '
                    'Lon: ${provider.currentPosition!.longitude.toStringAsFixed(6)}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20),
          
          // Error message if GPS fails during workout
          if (provider.errorMessage != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.orange.shade700, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      provider.errorMessage!,
                      style: TextStyle(color: Colors.orange.shade700),
                    ),
                  ),
                ],
              ),
            ),
          
          const SizedBox(height: 20),
          
          // Update Location button (proves tracker is active)
          OutlinedButton.icon(
            onPressed: () => provider.updateLocation(),
            icon: const Icon(Icons.refresh),
            label: const Text('Update Location'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          const SizedBox(height: 12),
          
          // Finish button
          CustomButton(
            onTap: provider.canFinish ? () => provider.finishWorkout() : null,
            label: 'Finish Run',
          ),
        ],
      ),
    );
  }
  
  Widget _buildFinishedPhase(BuildContext context, WorkoutTrackingProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Completion checkmark
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: const Icon(
              Icons.check_circle,
              size: 80,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),
          
          const Text(
            'Workout Complete!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          
          // Summary card with stats
          WorkoutSummaryCard(
            formattedTime: provider.formattedTime,
            formattedDistance: provider.formattedDistance,
            formattedPace: provider.formattedPace,
            onNewWorkout: () => provider.resetWorkout(),
          ),
          
          const SizedBox(height: 20),
          
          // Start and end locations if available
          if (provider.startPosition != null && provider.endPosition != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Route Details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start: ${provider.startPosition!.latitude.toStringAsFixed(6)}, '
                    '${provider.startPosition!.longitude.toStringAsFixed(6)}',
                    style: const TextStyle(fontSize: 11),
                  ),
                  Text(
                    'End: ${provider.endPosition!.latitude.toStringAsFixed(6)}, '
                    '${provider.endPosition!.longitude.toStringAsFixed(6)}',
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}