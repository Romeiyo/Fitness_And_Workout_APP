import 'package:fitness_app/widgets/custom_button.dart';
import 'package:fitness_app/widgets/input_container.dart';
import 'package:fitness_app/widgets/result_container.dart';
import 'package:flutter/material.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  
  double? _bmiResult;
  String? _bmiCategory;
  String? _errorMessage;
  
  void _calculateBMI() {
    setState(() {
      _errorMessage = null;
    });
    
    String heightText = _heightController.text.trim();
    String weightText = _weightController.text.trim();
    
    if (heightText.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your height';
      });
      return;
    }
    
    if (weightText.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your weight';
      });
      return;
    }
    
    double? heightInCm = double.tryParse(heightText);
    double? weightInKg = double.tryParse(weightText);
    
    if (heightInCm == null) {
      setState(() {
        _errorMessage = 'Please enter a valid height (e.g., 175)';
      });
      return;
    }
    
    if (weightInKg == null) {
      setState(() {
        _errorMessage = 'Please enter a valid weight (e.g., 70.5)';
      });
      return;
    }
    
    if (heightInCm <= 0) {
      setState(() {
        _errorMessage = 'Height must be greater than 0';
      });
      return;
    }
    
    if (weightInKg <= 0) {
      setState(() {
        _errorMessage = 'Weight must be greater than 0';
      });
      return;
    }
    
    double heightInMeters = heightInCm / 100;
    
    double bmi = weightInKg / (heightInMeters * heightInMeters);
    String category = _getBMICategory(bmi);
    
    setState(() {
      _bmiResult = bmi;
      _bmiCategory = category;
    });
    
    FocusScope.of(context).unfocus();
  }
  
  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }
  
  void _clearFields() {
    setState(() {
      _heightController.clear();
      _weightController.clear();
      _bmiResult = null;
      _bmiCategory = null;
      _errorMessage = null;
    });
    
    FocusScope.of(context).unfocus();
    
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
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}