import 'dart:async';
import 'package:fitness_app/domain/exercise_search_provider.dart';
import 'package:fitness_app/models/api_exercise.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Screen for searching exercises from external API
/// Users can search by muscle group and view exercise details
class ExerciseSearchScreen extends StatefulWidget {
  const ExerciseSearchScreen({super.key});

  @override
  State<ExerciseSearchScreen> createState() => _ExerciseSearchScreenState();
}

class _ExerciseSearchScreenState extends State<ExerciseSearchScreen> {
  // Text controller for search input
  final TextEditingController _searchController = TextEditingController();
  
  // Debounce timer to prevent excessive API calls
  // Waits 500ms after user stops typing before searching
  Timer? _debounceTimer;
  
  @override
  void dispose() {
    // Cancel timer and dispose controller to prevent memory leaks
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  /// Handles search input changes with debouncing
  /// Only searches after user stops typing for 500ms
  void _onSearchChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: 500), () {
        _performSearch(value);
      });
  }
  
  /// Performs the actual search
  void _performSearch(String query) {
    if (query.trim().isNotEmpty) {
      context.read<ExerciseSearchProvider>().searchExercises(query);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Exercises'),
        backgroundColor: Colors.greenAccent,
        actions: [
          // Clear button
          IconButton(
            onPressed: () {
              _searchController.clear();
              context.read<ExerciseSearchProvider>().clearResults();
            },
            icon: const Icon(Icons.clear_all),
            tooltip: 'Clear',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    onSubmitted: _performSearch,
                    decoration: InputDecoration(
                      hintText: 'Search by muscle (e.g., biceps, chest)',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Consumer<ExerciseSearchProvider>(
                  builder: (context, provider, child) {
                    return ElevatedButton(
                      onPressed: provider.isLoading 
                          ? null 
                          : () => _performSearch(_searchController.text),
                      child: const Text('Search'),
                    );
                  },
                ),
              ],
            ),
          ),
          
          // Search results area
          Expanded(
            child: Consumer<ExerciseSearchProvider>(
              builder: (context, provider, child) {
                // Show loading indicator
                if (provider.isLoading) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Searching for exercises...'),
                      ],
                    ),
                  );
                }
                
                // Show error message
                if (provider.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          provider.errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => provider.retry(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                
                // Show initial empty state
                if (provider.lastQuery.isEmpty && !provider.hasResults) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('Search for exercises by muscle group'),
                        SizedBox(height: 8),
                        Text('Try: biceps, chest, quadriceps'),
                      ],
                    ),
                  );
                }
                
                // Show no results message
                if (!provider.hasResults && provider.lastQuery.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.sentiment_dissatisfied, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text('No exercises found for "${provider.lastQuery}"'),
                        const SizedBox(height: 8),
                        const Text('Try a different muscle group'),
                      ],
                    ),
                  );
                }
                
                // Display search results
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.searchResults.length,
                  itemBuilder: (context, index) {
                    final exercise = provider.searchResults[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(
                          exercise.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 8,
                              children: [
                                // Muscle group chip
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    exercise.muscle,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                // Difficulty chip
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    exercise.difficulty,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                // Equipment chip
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    exercise.equipment,
                                    style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          _showExerciseDetails(context, exercise);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  /// Shows exercise details in a dialog
  void _showExerciseDetails(BuildContext context, ApiExercise exercise) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(exercise.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Instructions:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(exercise.instructions),
              const SizedBox(height: 16),
              const Text('Equipment:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(exercise.equipment),
              const SizedBox(height: 16),
              const Text('Type:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(exercise.type),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}