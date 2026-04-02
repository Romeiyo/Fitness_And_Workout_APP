import 'package:flutter/material.dart';

/// Widget displayed when location permission is denied
/// Shows error message and retry button
class LocationPermissionCard extends StatelessWidget {
  final String errorMessage;  // Detailed error message to display
  final VoidCallback onRetry; // Callback when retry button is pressed
  
  const LocationPermissionCard({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      // Red-themed container for error messages
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        children: [
          // Large location-off icon
          Icon(Icons.location_off, size: 48, color: Colors.red.shade400),
          const SizedBox(height: 12),
          // Error message text
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red.shade700),
          ),
          const SizedBox(height: 16),
          // Retry button
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
            ),
          ),
        ],
      ),
    );
  }
}