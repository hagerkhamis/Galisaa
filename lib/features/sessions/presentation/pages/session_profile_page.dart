// lib/features/sessions/presentation/pages/session_profile_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Session Profile Screen - Display Elderly User Data
/// الملف الشخصي - عرض بيانات كبار السن
class SessionProfilePage extends StatefulWidget {
  const SessionProfilePage({super.key});

  @override
  State<SessionProfilePage> createState() => _SessionProfilePageState();
}

class _SessionProfilePageState extends State<SessionProfilePage> {
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
                // AppBar with back arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(width: 48), // Balance for centered title
                  ],
                ),
                const SizedBox(height: 16),
                // Profile Picture
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: ClipOval(
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
                  ],
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
