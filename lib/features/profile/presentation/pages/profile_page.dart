// lib/features/profile/presentation/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../core/config/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/storage_helper.dart';

/// Profile Screen - Display Elderly User Data
/// الملف الشخصي - عرض بيانات كبار السن
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  // TODO: In a real app, fetch this data from API/state management
  // These should match the data structure from ElderlySignupPage
  
  // Sample data - replace with actual fetched data
  String _name = 'ليلي المهدي';
  DateTime? _birthDate = DateTime(1994, 5, 15); // Example date
  String? _gender = 'أنثى';
  String? _phone = '01234567890';
  String? _email = 'layla@example.com';
  String? _address = 'القاهرة، مصر';
  String? _healthStatus = 'حالة صحية جيدة';
  String? _medications = 'أدوية الضغط، فيتامينات';
  String? _psychologicalState = 'مستقر';
  String? _mobility = 'يحتاج مساعدة';
  String? _chronicDiseases = 'ضغط، سكري';
  String? _careType = 'رعاية يومية';
  bool? _medicationAlert = true;
  String? _specialPreferences = 'يفضل الجليسة أن تكون من نفس المنطقة';
  String? _guardianName = 'أحمد المهدي';
  String? _guardianKinship = 'ابن';
  String? _guardianPhone = '01123456789';
  String? _guardianEmail = 'ahmed@example.com';

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
      );
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في فتح الكاميرا: $e')),
      );
    }
  }

  Future<void> _handleLogout() async {
    await StorageHelper.clearAll();
    if (!mounted) return;
    context.go(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Section with Orange Background
          Container(
            padding: const EdgeInsets.only(top: 40, bottom: 24),
            decoration: const BoxDecoration(
              color: Color(0xFFF26805),
            ),
            child: Column(
              children: [
                // Back Arrow
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go(RouteNames.home);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Profile Picture with Camera Icon
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: _selectedImage != null
                          ? ClipOval(
                              child: Image.file(
                                _selectedImage!,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipOval(
                              child: Image.asset(
                                'assets/images/Avatar.png',
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 120,
                                    height: 120,
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.person,
                                      size: 60,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Name
                Text(
                  _name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Content Section - All Elderly Data
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Personal Information Section
                  _buildSectionTitle('المعلومات الشخصية'),
                  const SizedBox(height: 16),
                  _buildInfoRow('الاسم', _name),
                  if (_birthDate != null)
                    _buildInfoRow('تاريخ الميلاد', 
                      '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}'),
                  if (_gender != null && _gender!.isNotEmpty)
                    _buildInfoRow('النوع', _gender),
                  if (_phone != null && _phone!.isNotEmpty)
                    _buildInfoRow('الهاتف', _phone),
                  if (_email != null && _email!.isNotEmpty)
                    _buildInfoRow('البريد الإلكتروني', _email),
                  if (_address != null && _address!.isNotEmpty)
                    _buildInfoRow('العنوان', _address),
                  const SizedBox(height: 32),

                  // Health Information Section
                  _buildSectionTitle('المعلومات الصحية'),
                  const SizedBox(height: 16),
                  if (_healthStatus != null && _healthStatus!.isNotEmpty)
                    _buildInfoRow('الحالة الصحية', _healthStatus),
                  if (_medications != null && _medications!.isNotEmpty)
                    _buildInfoRow('الادوية المنتظمة', _medications),
                  if (_psychologicalState != null && _psychologicalState!.isNotEmpty)
                    _buildInfoRow('الحالة النفسية', _psychologicalState),
                  if (_mobility != null && _mobility!.isNotEmpty)
                    _buildInfoRow('القدرة على الحركة', _mobility),
                  if (_chronicDiseases != null && _chronicDiseases!.isNotEmpty)
                    _buildInfoRow('الأمراض المزمنة', _chronicDiseases),
                  if (_careType != null && _careType!.isNotEmpty)
                    _buildInfoRow('نوع الرعاية المطلوبة', _careType),
                  if (_medicationAlert != null)
                    _buildInfoRow('تنبيه بالأدوية', _medicationAlert! ? 'نعم' : 'لا'),
                  const SizedBox(height: 32),

                  // Special Preferences Section
                  if (_specialPreferences != null && _specialPreferences!.isNotEmpty) ...[
                    _buildSectionTitle('التفضيلات الخاصة'),
                    const SizedBox(height: 16),
                    _buildInfoRow('التفضيلات', _specialPreferences),
                    const SizedBox(height: 32),
                  ],

                  // Guardian Information Section
                  if ((_guardianName != null && _guardianName!.isNotEmpty) ||
                      (_guardianPhone != null && _guardianPhone!.isNotEmpty) ||
                      (_guardianEmail != null && _guardianEmail!.isNotEmpty)) ...[
                    _buildSectionTitle('بيانات ولي الأمر أو المسؤول'),
                    const SizedBox(height: 16),
                    if (_guardianName != null && _guardianName!.isNotEmpty)
                      _buildInfoRow('اسم ولي الأمر', _guardianName),
                    if (_guardianKinship != null && _guardianKinship!.isNotEmpty)
                      _buildInfoRow('صلة القرابة', _guardianKinship),
                    if (_guardianPhone != null && _guardianPhone!.isNotEmpty)
                      _buildInfoRow('هاتف ولي الأمر', _guardianPhone),
                    if (_guardianEmail != null && _guardianEmail!.isNotEmpty)
                      _buildInfoRow('بريد ولي الأمر', _guardianEmail),
                    const SizedBox(height: 32),
                  ],

                  // Logout Button
                  ElevatedButton(
                    onPressed: _handleLogout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      'تسجيل خروج',
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
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    if (value == null || value.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}
