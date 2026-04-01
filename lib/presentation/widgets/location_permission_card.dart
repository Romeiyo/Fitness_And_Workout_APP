import 'package:flutter/material.dart';

class LocationPermissionCard extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;
  
  const LocationPermissionCard({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        children: [
          Icon(Icons.location_off, size: 48, color: Colors.red.shade400),
          const SizedBox(height: 12),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red.shade700),
          ),
          const SizedBox(height: 16),
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