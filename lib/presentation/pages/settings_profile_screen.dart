import 'package:fitness_app/domain/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsProfileScreen extends StatefulWidget {
  const SettingsProfileScreen({super.key});

  @override
  State<SettingsProfileScreen> createState() => _SettingsProfileScreenState();
}

class _SettingsProfileScreenState extends State<SettingsProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightGoalController = TextEditingController();
  
  String? _nameError;
  String? _ageError;
  String? _weightGoalError;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProfileProvider>(context, listen: false);
      _nameController.text = provider.name;
      _ageController.text = provider.age > 0 ? provider.age.toString() : '';
      _weightGoalController.text = provider.weightGoal > 0 
          ? provider.weightGoal.toStringAsFixed(1) 
          : '';
    });
  }
  
  void _validateAndSaveName() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _nameError = 'Name cannot be empty';
      });
    } else {
      setState(() {
        _nameError = null;
      });
      Provider.of<ProfileProvider>(context, listen: false).updateName(name);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name saved'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
  
  void _validateAndSaveAge() {
    final ageText = _ageController.text.trim();
    if (ageText.isEmpty) {
      setState(() {
        _ageError = null;
      });
      Provider.of<ProfileProvider>(context, listen: false).updateAge(0);
      return;
    }
    
    final age = int.tryParse(ageText);
    if (age == null) {
      setState(() {
        _ageError = 'Please enter a valid number';
      });
    } else if (age < 1 || age > 120) {
      setState(() {
        _ageError = 'Age must be between 1 and 120';
      });
    } else {
      setState(() {
        _ageError = null;
      });
      Provider.of<ProfileProvider>(context, listen: false).updateAge(age);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Age saved'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
  
  void _validateAndSaveWeightGoal() {
    final weightText = _weightGoalController.text.trim();
    if (weightText.isEmpty) {
      setState(() {
        _weightGoalError = null;
      });
      Provider.of<ProfileProvider>(context, listen: false).updateWeightGoal(0.0);
      return;
    }
    
    final weight = double.tryParse(weightText);
    if (weight == null) {
      setState(() {
        _weightGoalError = 'Please enter a valid number';
      });
    } else if (weight <= 0) {
      setState(() {
        _weightGoalError = 'Weight goal must be positive';
      });
    } else {
      setState(() {
        _weightGoalError = null;
      });
      Provider.of<ProfileProvider>(context, listen: false).updateWeightGoal(weight);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Weight goal saved'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
  
  void _showResetProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reset Profile Data'),
        content: const Text(
          'This will clear your name, age, and weight goal. '
          'Your app preferences (units, timer, notifications) will remain unchanged. '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await Provider.of<ProfileProvider>(context, listen: false)
                  .resetProfile();
              
              _nameController.text = 'Guest';
              _ageController.clear();
              _weightGoalController.clear();
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile data cleared'),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Reset Profile'),
          ),
        ],
      ),
    );
  }
  
  void _showResetEverythingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reset Everything'),
        content: const Text(
          'This will clear ALL your data including:'
          '\n\n• Your name, age, and weight goal'
          '\n• Weight unit preference'
          '\n• Rest timer setting'
          '\n• Notifications preference'
          '\n\nAll settings will return to default values. '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await Provider.of<ProfileProvider>(context, listen: false)
                  .resetEverything();
              
              _nameController.text = 'Guest';
              _ageController.clear();
              _weightGoalController.clear();
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All data cleared'),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Reset Everything'),
          ),
        ],
      ),
    );
  }
  
  String _formatRestTimer(int seconds) {
    if (seconds >= 60) {
      final minutes = seconds ~/ 60;
      final remainingSeconds = seconds % 60;
      if (remainingSeconds == 0) {
        return '$minutes min';
      }
      return '$minutes min $remainingSeconds sec';
    }
    return '$seconds sec';
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightGoalController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Profile'),
        backgroundColor: Colors.greenAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.blue.shade700, size: 28),
                        const SizedBox(width: 12),
                        const Text(
                          'Profile Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.save, color: Colors.blue),
                          onPressed: _validateAndSaveName,
                        ),
                        errorText: _nameError,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        hintText: 'Enter your age (1-120)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.save, color: Colors.blue),
                          onPressed: _validateAndSaveAge,
                        ),
                        errorText: _ageError,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Consumer<ProfileProvider>(
                      builder: (context, provider, child) {
                        return TextFormField(
                          controller: _weightGoalController,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            labelText: 'Weight Goal',
                            hintText: 'Enter your target weight',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.save, color: Colors.blue),
                              onPressed: _validateAndSaveWeightGoal,
                            ),
                            suffixText: provider.weightUnit,
                            errorText: _weightGoalError,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.settings, color: Colors.green.shade700, size: 28),
                        const SizedBox(width: 12),
                        const Text(
                          'App Preferences',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    const Text(
                      'Weight Unit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Consumer<ProfileProvider>(
                      builder: (context, provider, child) {
                        return SegmentedButton<String>(
                          segments: const [
                            ButtonSegment(value: 'kg', label: Text('kg'), icon: Icon(Icons.fitness_center, size: 18)),
                            ButtonSegment(value: 'lbs', label: Text('lbs'), icon: Icon(Icons.fitness_center, size: 18)),
                          ],
                          selected: {provider.weightUnit},
                          onSelectionChanged: (Set<String> selection) {
                            final newUnit = selection.first;
                            provider.updateWeightUnit(newUnit);
                          },
                        );
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Rest Timer Slider
                    const Text(
                      'Rest Timer Duration',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Consumer<ProfileProvider>(
                      builder: (context, provider, child) {
                        return Column(
                          children: [
                            Slider(
                              value: provider.restTimer.toDouble(),
                              min: 15,
                              max: 300,
                              divisions: 19, // (300-15)/15 = 19 steps
                              label: _formatRestTimer(provider.restTimer),
                              onChanged: (double value) {
                                provider.previewRestTimer(value.toInt());
                              },
                              onChangeEnd: (double value) {
                                // Save only when dragging ends
                                provider.updateRestTimer(value.toInt());
                              },
                            ),
                            Text(
                              _formatRestTimer(provider.restTimer),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Notifications Toggle
                    Consumer<ProfileProvider>(
                      builder: (context, provider, child) {
                        return SwitchListTile(
                          title: const Text(
                            'Enable Notifications',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: const Text('Receive workout reminders and tips'),
                          value: provider.notificationsEnabled,
                          onChanged: (bool value) {
                            provider.updateNotificationsEnabled(value);
                          },
                          activeThumbColor: Colors.green,
                          contentPadding: EdgeInsets.zero,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Reset Buttons Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning_amber, color: Colors.red.shade700, size: 28),
                        const SizedBox(width: 12),
                        const Text(
                          'Danger Zone',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    OutlinedButton.icon(
                      onPressed: () => _showResetProfileDialog(context),
                      icon: const Icon(Icons.person_remove),
                      label: const Text('Reset Profile Data'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    ElevatedButton.icon(
                      onPressed: () => _showResetEverythingDialog(context),
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Reset Everything'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

