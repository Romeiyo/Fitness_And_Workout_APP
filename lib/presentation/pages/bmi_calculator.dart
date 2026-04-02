import 'package:fitness_app/presentation/widgets/custom_button.dart';
import 'package:fitness_app/presentation/widgets/input_container.dart';
import 'package:fitness_app/presentation/widgets/result_container.dart';
import 'package:flutter/material.dart';

/// BMI Calculator screen
/// Allows users to calculate their Body Mass Index based on height and weight
class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  // Text controllers for input fields
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  
  // State for calculation results
  double? _bmiResult;
  String? _bmiCategory;
  String? _errorMessage;
  
  /// Calculates BMI based on entered height and weight
  /// Formula: weight (kg) / (height in meters)²
  void _calculateBMI() {
    // Clear previous error
    setState(() {
      _errorMessage = null;
    });
    
    String heightText = _heightController.text.trim();
    String weightText = _weightController.text.trim();
    
    // Validate height is entered
    if (heightText.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your height';
      });
      return;
    }
    
    // Validate weight is entered
    if (weightText.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your weight';
      });
      return;
    }
    
    // Parse inputs to numbers
    double? heightInCm = double.tryParse(heightText);
    double? weightInKg = double.tryParse(weightText);
    
    // Validate height format
    if (heightInCm == null) {
      setState(() {
        _errorMessage = 'Please enter a valid height (e.g., 175)';
      });
      return;
    }
    
    // Validate weight format
    if (weightInKg == null) {
      setState(() {
        _errorMessage = 'Please enter a valid weight (e.g., 70.5)';
      });
      return;
    }
    
    // Validate height is positive
    if (heightInCm <= 0) {
      setState(() {
        _errorMessage = 'Height must be greater than 0';
      });
      return;
    }
    
    // Validate weight is positive
    if (weightInKg <= 0) {
      setState(() {
        _errorMessage = 'Weight must be greater than 0';
      });
      return;
    }
    
    // Convert cm to meters for BMI calculation
    double heightInMeters = heightInCm / 100;
    
    // Calculate BMI
    double bmi = weightInKg / (heightInMeters * heightInMeters);
    String category = _getBMICategory(bmi);
    
    // Update state with results
    setState(() {
      _bmiResult = bmi;
      _bmiCategory = category;
    });
    
    // Dismiss keyboard after calculation
    FocusScope.of(context).unfocus();
  }
  
  /// Determines BMI category based on WHO standards
  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }
  
  /// Clears all input fields and results
  void _clearFields() {
    setState(() {
      _heightController.clear();
      _weightController.clear();
      _bmiResult = null;
      _bmiCategory = null;
      _errorMessage = null;
    });
    
    // Dismiss keyboard
    FocusScope.of(context).unfocus();
    
    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fields cleared'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.cyan,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: Colors.greenAccent,
        actions: [
          // Clear button
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: _clearFields,
            tooltip: 'Clear all fields',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Height input field
              InputContainer(
                title: 'Height',
                icon: Icons.height,
                unit: 'cm',
                controller: _heightController,
                hintText: 'Enter height in centimeters (e.g., 175)',
                validator: (value) {
                  if (value == null || value.trim().isEmpty){
                    return "Please enter your height";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Weight input field
              InputContainer(
                title: 'Weight',
                icon: Icons.fitness_center,
                unit: 'kg',
                controller: _weightController,
                hintText: 'Enter weight in kilograms (e.g., 70.5)',
                validator: (value) {
                  if (value == null || value.trim().isEmpty){
                    return "Please enter your weight";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Display error message if any
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: Colors.red.shade700, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              
              const SizedBox(height: 20),
          
              // Calculate button
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      onTap: _calculateBMI,
                      label: 'Calculate BMI',
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Display results if calculated
              if (_bmiResult != null)
                ResultContainer(
                  bmi: _bmiResult!,
                  category: _bmiCategory!,
                ),
            ],
          ),
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    // Clean up controllers to prevent memory leaks
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}