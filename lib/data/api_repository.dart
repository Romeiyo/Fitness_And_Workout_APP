import 'package:dio/dio.dart';
import 'package:fitness_app/models/api_exercise.dart';

class ExerciseApiRepository {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  
  static const String _baseUrl = 'https://api.api-ninjas.com/v1/exercises';

  static const String _apiKey = 'EZ8iHoV9M5C8fYaYboWTSfyNwKP0LvpwpORYTaNW';

  Future<List<ApiExercise>> searchExercises(String muscle) async {
    try {
      
      final Response response = await _dio.get(
        _baseUrl,
        queryParameters: {'muscle': muscle},
        options: Options(
          headers: {
            'X-Api-Key': _apiKey,
          },
        ),
      );

      final List<dynamic> data = response.data;
      
      return data
          .map((json) => ApiExercise.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timed out. Check your internet.');
      }
      
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid API key. Check your API Ninjas key.');
      }
      
      if (e.response?.statusCode == 429) {
        throw Exception('Rate limit exceeded. Wait a moment and try again.');
      }
      
      if (e.response != null) {
        throw Exception('Server error: ${e.response?.statusCode}');
      }
      
      if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection.');
      }
      
      throw Exception('Failed to load exercises: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}