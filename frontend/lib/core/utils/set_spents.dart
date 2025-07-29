import 'package:frontend/services/shared_preferences_service.dart';

Future<void> setSpents(String value) async {
  final prefs = await SharedPreferencesService.getInstance();
  await prefs.saveData('estimatedValue', value);
}
