// lib/features/sessions/presentation/pages/search_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';

/// Search/Filter Screen
/// صفحة البحث/التصفية
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  final _servicePriceController = TextEditingController();
  String? _selectedLocation;
  String? _selectedType;
  String? _selectedServiceType;
  String? _selectedStartTime;
  String? _selectedEndTime;
  String? _selectedRating;

  final List<String> _locations = ['القاهرة', 'الجيزة', 'الإسكندرية', 'المنصورة'];
  final List<String> _types = ['ذكور', 'إناث'];
  final List<String> _serviceTypes = ['رعاية يومية', 'رعاية ليلية', 'رعاية 24 ساعة', 'رعاية مؤقتة'];
  final List<String> _timeOptions = ['6 AM', '8 AM', '10 AM', '12 PM', '2 PM', '4 PM', '6 PM', '8 PM', '10 PM'];
  final List<String> _ratings = ['1', '2', '3', '4', '5'];

  @override
  void dispose() {
    _servicePriceController.dispose();
    super.dispose();
  }

  Future<void> _handleSearch() async {
    if (!_formKey.currentState!.validate()) return;

    // TODO: Apply search filters and navigate to sessions list
    context.push(RouteNames.sessions);
  }

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
          onPressed: () => context.pop(),
        ),
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(50),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'ابحث عن جليستك في تطبيق جليسة.',
              hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // First Row: Location & Type
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      label: 'النوع',
                      value: _selectedType,
                      items: _types,
                      onChanged: (value) => setState(() => _selectedType = value),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDropdownField(
                      label: 'الموقع',
                      value: _selectedLocation,
                      items: _locations,
                      onChanged: (value) => setState(() => _selectedLocation = value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Second Row: Service Type & Service Prices
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _servicePriceController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        labelText: 'اسعار الخدمة',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: AppColors.primary, width: 2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDropdownField(
                      label: 'نوع الخدمة',
                      value: _selectedServiceType,
                      items: _serviceTypes,
                      onChanged: (value) => setState(() => _selectedServiceType = value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Third Row: Start Time & End Time
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      label: 'وقت الانتهاء',
                      value: _selectedEndTime,
                      items: _timeOptions,
                      onChanged: (value) => setState(() => _selectedEndTime = value),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDropdownField(
                      label: 'وقت البدء',
                      value: _selectedStartTime,
                      items: _timeOptions,
                      onChanged: (value) => setState(() => _selectedStartTime = value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Fourth Row: Rating (right aligned only)
              Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDropdownField(
                      label: 'التقييم',
                      value: _selectedRating,
                      items: _ratings,
                      onChanged: (value) => setState(() => _selectedRating = value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Search Button
              ElevatedButton(
                onPressed: _handleSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'بحث',
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
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            hintText: 'إختر',
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            filled: true,
            fillColor: Colors.white,
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
