// lib/features/sessions/presentation/pages/filter_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

/// Filter Screen
/// صفحة التصفية
class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String? _selectedType;
  String? _selectedLocation;
  double _priceRangeStart = 500;
  double _priceRangeEnd = 1000;
  double _ageRangeStart = 20;
  double _ageRangeEnd = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFF26805),
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'تصفية',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Type Filter
            DropdownButtonFormField<String>(
              value: _selectedType,
              decoration: InputDecoration(
                labelText: 'النوع',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              items: ['ذكر', 'أنثى'].map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) => setState(() => _selectedType = value),
            ),
            const SizedBox(height: 24),

            // Location Filter
            DropdownButtonFormField<String>(
              value: _selectedLocation,
              decoration: InputDecoration(
                labelText: 'الموقع',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              items: ['القاهرة', 'الجيزة', 'الإسكندرية'].map((location) {
                return DropdownMenuItem(value: location, child: Text(location));
              }).toList(),
              onChanged: (value) => setState(() => _selectedLocation = value),
            ),
            const SizedBox(height: 24),

            // Price Range
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('السعر: ${_priceRangeStart.toInt()}p - ${_priceRangeEnd.toInt()}p'),
                RangeSlider(
                  values: RangeValues(_priceRangeStart, _priceRangeEnd),
                  min: 0,
                  max: 2000,
                  divisions: 40,
                  labels: RangeLabels(
                    '${_priceRangeStart.toInt()}p',
                    '${_priceRangeEnd.toInt()}p',
                  ),
                  onChanged: (values) {
                    setState(() {
                      _priceRangeStart = values.start;
                      _priceRangeEnd = values.end;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Age Range
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('السن: ${_ageRangeStart.toInt()}y - ${_ageRangeEnd.toInt()}y'),
                RangeSlider(
                  values: RangeValues(_ageRangeStart, _ageRangeEnd),
                  min: 18,
                  max: 60,
                  divisions: 42,
                  labels: RangeLabels(
                    '${_ageRangeStart.toInt()}y',
                    '${_ageRangeEnd.toInt()}y',
                  ),
                  onChanged: (values) {
                    setState(() {
                      _ageRangeStart = values.start;
                      _ageRangeEnd = values.end;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Apply Filter Button
            ElevatedButton(
              onPressed: () {
                // TODO: Apply filters and navigate back
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
              ),
              child: const Text(
                'تطبيق التصفية',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}