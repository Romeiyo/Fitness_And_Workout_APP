import 'package:geolocator/geolocator.dart';

/// Service for handling GPS location operations
/// Provides methods to get current position and calculate distances
class LocationService {
  /// Gets the current device position with high accuracy
  /// Checks and requests location permissions if needed
  /// @returns Position object with latitude, longitude, etc.
  /// @throws Exception with user-friendly message if location unavailable
  Future<Position> getCurrentPosition() async {
    // Check if location services (GPS) are enabled on device
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled. Please enable GPS in your device settings.');
    }

    // Check current location permission status
    LocationPermission permission = await Geolocator.checkPermission();
    
    // If permission is denied, request it from user
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied. Tap Start Run to try again.');
      }
    }
    
    // If permission is permanently denied, user must enable in settings
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission is permanently denied. Please enable it in your device settings.');
    }
    
    try {
      // Get current position with high accuracy settings
      return await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );
    } catch (e) {
      throw Exception('Failed to get GPS location: $e');
    }
  }
  
  /// Calculates distance between two geographic coordinates
  /// Uses Haversine formula to compute great-circle distance
  /// @param startLat - Starting point latitude
  /// @param startLon - Starting point longitude
  /// @param endLat - Ending point latitude
  /// @param endLon - Ending point longitude
  /// @returns Distance in meters between the two points
  double calculateDistance(
    double startLat,
    double startLon,
    double endLat,
    double endLon,
  ) {
    // Geolocator.distanceBetween calculates geodesic distance using WGS84 ellipsoid
    return Geolocator.distanceBetween(startLat, startLon, endLat, endLon);
  }
}