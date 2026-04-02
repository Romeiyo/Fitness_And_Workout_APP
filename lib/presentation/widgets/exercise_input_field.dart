import 'package:flutter/material.dart';

/// Reusable widget for exercise input fields
/// Supports both text input and dropdown selection
class ExerciseInputField extends StatelessWidget {
  // Text field properties
  final TextEditingController? controller;
  final String title;
  final IconData icon;
  final String hintText;
  final String? suffixText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  
  // Dropdown properties
  final bool isDropdown;
  final List<DropdownMenuItem<String>>? dropdownItems;
  final String? dropdownValue;
  final ValueChanged<String?>? onDropdownChanged;
  
  const ExerciseInputField({
    super.key,
    required this.title,
    required this.icon,
    required this.hintText,
    this.controller,
    this.suffixText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isDropdown = false,
    this.dropdownItems,
    this.dropdownValue,
    this.onDropdownChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      // Card-like container with shadow
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
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
            // Input field - either dropdown or text field
            isDropdown 
                ? DropdownButtonFormField<String>(
                    initialValue: dropdownValue,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: dropdownItems,
                    onChanged: onDropdownChanged,
                    validator: validator,
                  )
                : TextFormField(
                    controller: controller,
                    keyboardType: keyboardType,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixText: suffixText,  // Optional unit (e.g., "kg", "sets")
                    ),
                    validator: validator,
                  ),
          ],
        ),
      ),
    );
  }
}