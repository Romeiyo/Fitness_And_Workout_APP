import 'package:flutter/material.dart';

/// Reusable gradient button widget with ripple effect
/// Used throughout the app for consistent button styling
class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;  // Callback when button is tapped (null disables button)
  final String label;          // Text displayed on the button
  
  const CustomButton({
    super.key,
    this.onTap,
    required this.label,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,  // Stretch to full width
      decoration: BoxDecoration(
        // Gradient from blue to green for visual appeal
        gradient: const LinearGradient(
          colors: [Colors.blueAccent, Colors.greenAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        // Shadow for depth effect
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,  // Make Material transparent to show gradient
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,  // Handle tap (null disables)
          borderRadius: BorderRadius.circular(12),
          splashColor: Colors.cyan,   // Ripple effect color
          highlightColor: Colors.white, // Highlight when pressed
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calculate,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}