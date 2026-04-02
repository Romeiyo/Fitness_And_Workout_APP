import 'package:flutter/material.dart';

/// Reusable container for input fields with consistent styling
/// Used for BMI calculator inputs (height and weight)
class InputContainer extends StatelessWidget {
  final String title;               // Field title (e.g., "Height")
  final IconData icon;              // Icon representing the field
  final String unit;                // Unit of measurement (e.g., "cm", "kg")
  final TextEditingController controller;  // Text controller for input
  final String hintText;            // Placeholder text
  final String? Function(String?)? validator;  // Validation function
  
  const InputContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.unit,
    required this.controller,
    required this.hintText,
    this.validator,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      // Card styling with shadow
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and title
            Row(
              children: [
                Icon(icon, color: Colors.blue, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Text field with unit suffix
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixText: unit,  // Shows "cm" or "kg" at the end of the field
                suffixStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              validator: validator,
            ),
          ],
        ),
      ),
    );
  }
}