import 'package:fitness_app/models/exercise.dart';
import 'package:fitness_app/routes/app_router.dart';
import 'package:fitness_app/presentation/widgets/custom_button.dart';
import 'package:fitness_app/presentation/widgets/exercise_input_field.dart';
import 'package:flutter/material.dart';

/// Screen for adding custom exercises
/// Users can create their own exercises with name, sets, reps, weight, and muscle group
class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({super.key});

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  
  // Text controllers for input fields
  final _nameController = TextEditingController();
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();
  final _weightController = TextEditingController();
  
  // Selected muscle group
  String? _selectedMuscleGroup;
  
  // Preview values for volume calculation
  int? _sets;
  int? _reps;
  double? _weight;
  
  @override
  void initState() {
    super.initState();
    // Add listeners to update preview in real-time
    _setsController.addListener(_updatePreview);
    _repsController.addListener(_updatePreview);
    _weightController.addListener(_updatePreview);
  }
  
  /// Updates preview values when input changes
  void _updatePreview() {
    setState(() {
      _sets = int.tryParse(_setsController.text);
      _reps = int.tryParse(_repsController.text);
      _weight = double.tryParse(_weightController.text);
    });
  }
  
  /// Validates and submits the form
  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedMuscleGroup != null) {
      // Create Exercise object with unique ID (timestamp)
      final exercise = Exercise(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        sets: int.parse(_setsController.text),
        reps: int.parse(_repsController.text),
        weight: double.parse(_weightController.text),
        muscleGroup: _selectedMuscleGroup!,
      );
      
      // Return exercise to previous screen
      context.pop(exercise);
    } else if (_selectedMuscleGroup == null) {
      // Show error if muscle group not selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a muscle group'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  
  @override
  void dispose() {
    // Clean up controllers
    _nameController.dispose();
    _setsController.dispose();
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Custom Exercise'),
        backgroundColor: Colors.greenAccent,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Exercise name input
              ExerciseInputField(
                title: 'Exercise Name',
                icon: Icons.fitness_center,
                hintText: 'e.g., Bench Press, Squat',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Exercise name is required';
                  }
                  if (value.trim().length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  if (value.trim().length > 50) {
                    return 'Name cannot exceed 50 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Sets input
              ExerciseInputField(
                title: 'Sets',
                icon: Icons.repeat,
                hintText: 'Number of sets (1-20)',
                controller: _setsController,
                suffixText: 'sets',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Number of sets is required';
                  }
                  final sets = int.tryParse(value);
                  if (sets == null) {
                    return 'Sets must be a whole number';
                  }
                  if (sets <= 0) {
                    return 'Sets must be greater than zero';
                  }
                  if (sets > 20) {
                    return 'Sets cannot exceed 20';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Reps input
              ExerciseInputField(
                title: 'Reps',
                icon: Icons.trending_up,
                hintText: 'Number of reps per set (1-100)',
                controller: _repsController,
                suffixText: 'reps',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Number of reps is required';
                  }
                  final reps = int.tryParse(value);
                  if (reps == null) {
                    return 'Reps must be a whole number';
                  }
                  if (reps <= 0) {
                    return 'Reps must be greater than zero';
                  }
                  if (reps > 100) {
                    return 'Reps cannot exceed 100';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Weight input
              ExerciseInputField(
                title: 'Weight (kg)',
                icon: Icons.fitness_center,
                hintText: 'Weight in kilograms (0-500)',
                controller: _weightController,
                suffixText: 'kg',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Weight is required';
                  }
                  final weight = double.tryParse(value);
                  if (weight == null) {
                    return 'Weight must be a valid number';
                  }
                  if (weight < 0) {
                    return 'Weight cannot be negative';
                  }
                  if (weight > 500) {
                    return 'Weight cannot exceed 500kg';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Muscle group dropdown
              ExerciseInputField(
                title: 'Target Muscle Group',
                icon: Icons.fitness_center,
                hintText: 'Select Muscle Group...',
                isDropdown: true,
                dropdownValue: _selectedMuscleGroup,
                dropdownItems: const [
                  DropdownMenuItem(value: 'Chest', child: Text('Chest')),
                  DropdownMenuItem(value: 'Back', child: Text('Back')),
                  DropdownMenuItem(value: 'Legs', child: Text('Legs')),
                  DropdownMenuItem(value: 'Arms', child: Text('Arms')),
                  DropdownMenuItem(value: 'Shoulders', child: Text('Shoulders')),
                  DropdownMenuItem(value: 'Core', child: Text('Core')),
                ],
                onDropdownChanged: (value) {
                  setState(() {
                    _selectedMuscleGroup = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a muscle group';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              
              // Volume preview (live calculation)
              _buildVolumePreview(),
              const SizedBox(height: 24),
              
              // Submit button
              CustomButton(
                onTap: _submitForm,
                label: 'Save Exercise',
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Builds the volume preview widget
  /// Shows calculated volume (sets × reps × weight) in real-time
  Widget _buildVolumePreview() {
    String volumeText;
    Color textColor;
    
    if (_sets != null && _reps != null && _weight != null) {
      double volume = _sets! * _reps! * _weight!;
      volumeText = '${_sets!} x ${_reps!} x ${_weight!.toStringAsFixed(1)} = ${volume.toStringAsFixed(1)} kg';
      textColor = Colors.green;  // Green when all values are entered
    } else {
      volumeText = '-- x -- x -- = -- kg';
      textColor = Colors.grey;   // Grey when values are incomplete
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Total Volume',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            volumeText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}