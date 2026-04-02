import 'package:dio/dio.dart';
import 'package:fitness_app/models/api_exercise.dart';

/// Repository for fetching exercise data from external API
/// Handles HTTP requests to the API Ninjas exercise database
class ExerciseApiRepository {
  // Dio HTTP client with configuration
  final Dio _dio = Dio(
    BaseOptions(
      // Maximum time to wait for connection to establish (10 seconds)
      connectTimeout: const Duration(seconds: 10),
      // Maximum time to wait for response after connection (10 seconds)
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  
  // Base URL for the API Ninjas exercise endpoint
  static const String _baseUrl = 'https://api.api-ninjas.com/v1/exercises';

  // API key for authentication (in production, should be stored securely)
  static const String _apiKey = 'EZ8iHoV9M5C8fYaYboWTSfyNwKP0LvpwpORYTaNW';

  /// Searches for exercises targeting a specific muscle group
  /// @param muscle - The muscle group to search for (e.g., "biceps", "chest")
  /// @returns List of ApiExercise objects matching the search
  /// @throws Exception with user-friendly error message on failure
  Future<List<ApiExercise>> searchExercises(String muscle) async {
    try {
      // Make GET request to the API endpoint
      final Response response = await _dio.get(
        _baseUrl,
        // Add query parameter: ?muscle=muscleName
        queryParameters: {'muscle': muscle},
        // Add API key to request headers for authentication
        options: Options(
          headers: {
            'X-Api-Key': _apiKey,
          },
        ),
      );

      // Parse the response data (list of JSON objects)
      final List<dynamic> data = response.data;
      
      // Convert each JSON object to an ApiExercise model
      return data
          .map((json) => ApiExercise.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      // Handle various Dio exception types with user-friendly messages
      
      // Connection timeout - user might have poor internet
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timed out. Check your internet.');
      }
      
      // Unauthorized - API key is invalid or expired
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid API key. Check your API Ninjas key.');
      }
      
      // Rate limit exceeded - too many requests in short time
      if (e.response?.statusCode == 429) {
        throw Exception('Rate limit exceeded. Wait a moment and try again.');
      }
      
      // Other server errors (500, 502, etc.)
      if (e.response != null) {
        throw Exception('Server error: ${e.response?.statusCode}');
      }
      
      // No internet connection or network unreachable
      if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection.');
      }
      
      // Any other Dio-related exception
      throw Exception('Failed to load exercises: ${e.message}');
    } catch (e) {
      // Catch-all for non-Dio exceptions (unexpected errors)
      throw Exception('Unexpected error: $e');
    }
  }
}