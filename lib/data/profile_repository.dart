import 'dart:convert';
import 'package:fitness_app/models/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Repository for storing and retrieving user profile data
/// Uses SharedPreferences for persistent local storage
class ProfileRepository {
  // Key used to store profile data in SharedPreferences
  static const String _key = 'user_profile';

  /// Saves user profile to persistent storage
  /// @param profile - UserProfile object to save
  Future<void> saveProfile(UserProfile profile) async {
    // Get SharedPreferences instance (singleton)
    final prefs = await SharedPreferences.getInstance();
    
    // Convert UserProfile object to JSON string
    final jsonString = jsonEncode(profile.toJson());
    
    // Save JSON string to storage with the predefined key
    await prefs.setString(_key, jsonString);
  }

  /// Loads user profile from persistent storage
  /// @returns UserProfile object, or default profile if none exists
  Future<UserProfile> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    // If no profile exists, return default profile
    if (jsonString == null) {
      return UserProfile.defaults();
    }

    try {
      // Parse JSON string back to Map
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      // Convert Map to UserProfile object
      return UserProfile.fromJson(jsonMap);
    } catch (e) {
      // If parsing fails, return default profile and log error
      print('Error loading profile: $e');
      return UserProfile.defaults();
    }
  }

  /// Removes profile from persistent storage
  /// Used when user resets their profile data
  Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}