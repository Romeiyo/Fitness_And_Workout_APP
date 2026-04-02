import 'package:flutter/material.dart';

/// Widget displaying BMI calculation results
/// Shows BMI value, category, and personalized advice
class ResultContainer extends StatelessWidget {
  final double bmi;      // Calculated BMI value
  final String category; // BMI category (Underweight, Normal, etc.)
  
  const ResultContainer({
    super.key,
    required this.bmi,
    required this.category,
  });
  
  /// Returns color based on BMI category
  Color _getCategoryColor() {
    if (bmi < 18.5) return Colors.blue;      // Underweight
    if (bmi < 25) return Colors.green;       // Healthy weight
    if (bmi < 30) return Colors.orange;      // Overweight
    return Colors.red;                       // Obese
  }
  
  /// Returns personalized advice based on BMI category
  String _getAdvice() {
    if (bmi < 18.5) {
      return 'You are underweight. Consider consulting a healthcare provider for a healthy weight gain plan.';
    }
    if (bmi < 25) {
      return 'Congratulations! You are in the healthy weight range. Maintain a balanced diet and regular exercise.';
    }
    if (bmi < 30) {
      return 'You are overweight. Consider adopting a healthier lifestyle with proper diet and exercise.';
    }
    return 'You are in the obese range. Please consult a healthcare provider for a personalized weight management plan.';
  }
  
  @override
  Widget build(BuildContext context) {
    final categoryColor = _getCategoryColor();
    
    return Container(
      // Gradient background matching the category color
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [categoryColor, categoryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: categoryColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: categoryColor,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // "YOUR BMI RESULT" badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'YOUR BMI RESULT',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // BMI value (large text)
            Text(
              bmi.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.black26,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Category badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                category.toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Advice container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _getAdvice(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}