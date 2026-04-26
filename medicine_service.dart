import 'dart:convert';
import 'package:flutter/services.dart';

class MedicineService {
  Map<String, dynamic> _medicines = {};

  Future<void> loadMedicines() async {
    try {
      final data = await rootBundle.loadString('assets/medicines.json');
      _medicines = json.decode(data);
    } catch (e) {
      print('Error loading medicines: $e');
    }
  }

  Map<String, dynamic> getMedicine(String diseaseName) {
    if (_medicines.containsKey(diseaseName)) {
      return _medicines[diseaseName];
    }
    // Try partial match
    for (var key in _medicines.keys) {
      if (diseaseName.toLowerCase().contains(key.toLowerCase()) ||
          key.toLowerCase().contains(diseaseName.toLowerCase())) {
        return _medicines[key];
      }
    }
    return {
      'medicine': 'Consult local agricultural expert',
      'treatment': 'Take the plant sample to your nearest agriculture office',
      'prevention': 'Maintain proper spacing, avoid overwatering',
    };
  }
}
