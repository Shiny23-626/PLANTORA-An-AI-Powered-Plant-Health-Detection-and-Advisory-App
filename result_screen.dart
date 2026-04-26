import 'dart:io';
import 'package:flutter/material.dart';
import '../services/detection_service.dart';
import '../services/medicine_service.dart';

class ResultScreen extends StatefulWidget {
  final File imageFile;
  const ResultScreen({super.key, required this.imageFile});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final DetectionService _detectionService = DetectionService();
  final MedicineService _medicineService = MedicineService();
  Map<String, dynamic>? _result;
  Map<String, dynamic>? _medicine;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _runDetection();
  }

  Future<void> _runDetection() async {
    try {
      await _medicineService.loadMedicines();
      final result = await _detectionService.predict(widget.imageFile);
      if (result.containsKey('error')) {
        setState(() { _error = result['error']; _isLoading = false; });
        return;
      }
      final medicine = _medicineService.getMedicine(result['disease']);
      setState(() {
        _result = result;
        _medicine = medicine;
        _isLoading = false;
      });
    } catch (e) {
      setState(() { _error = e.toString(); _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D9E75),
        title: const Text(
          'Detection Result',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xFF1D9E75)),
                  SizedBox(height: 16),
                  Text('Analyzing leaf...', style: TextStyle(fontSize: 16)),
                ],
              ),
            )
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Leaf image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          widget.imageFile,
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Disease result card
                      _buildResultCard(),
                      const SizedBox(height: 16),

                      // Medicine card
                      if (_medicine != null) _buildMedicineCard(),
                      const SizedBox(height: 16),

                      // Prevention card
                      if (_medicine != null) _buildPreventionCard(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildResultCard() {
    final confidence = double.tryParse(_result?['confidence'] ?? '0') ?? 0;
    final isHealthy = _result?['disease']
            .toString()
            .toLowerCase()
            .contains('healthy') ??
        false;
    final cardColor = isHealthy ? const Color(0xFF1D9E75) : const Color(0xFFD85A30);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: cardColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isHealthy ? Icons.check_circle : Icons.warning_amber,
                  color: cardColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Detection Result',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _result?['disease'] ?? 'Unknown',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: cardColor,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('Confidence: ', style: TextStyle(fontSize: 14)),
              Expanded(
                child: LinearProgressIndicator(
                  value: confidence / 100,
                  backgroundColor: Colors.grey[200],
                  color: cardColor,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${confidence.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cardColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.medication_outlined, color: Color(0xFF534AB7)),
              SizedBox(width: 8),
              Text(
                'Recommended Medicine',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _infoRow('Medicine', _medicine?['medicine'] ?? 'N/A'),
          const SizedBox(height: 10),
          _infoRow('Treatment', _medicine?['treatment'] ?? 'N/A'),
        ],
      ),
    );
  }

  Widget _buildPreventionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE1F5EE),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1D9E75).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.shield_outlined, color: Color(0xFF1D9E75)),
              SizedBox(width: 8),
              Text(
                'Prevention Tips',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF085041),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            _medicine?['prevention'] ?? 'Maintain good farming practices',
            style: const TextStyle(color: Color(0xFF0F6E56), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        Expanded(
          child: Text(value, style: const TextStyle(fontSize: 13)),
        ),
      ],
    );
  }
}