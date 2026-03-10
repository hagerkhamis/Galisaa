// lib/features/auth/presentation/pages/elderly_signup_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../core/config/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/success_dialod.dart';

/// Elderly Sign Up Screen (Multi-step)
/// صفحة تسجيل كبار السن (متعددة الخطوات)
class ElderlySignupPage extends StatefulWidget {
  const ElderlySignupPage({super.key});

  @override
  State<ElderlySignupPage> createState() => _ElderlySignupPageState();
}

class _ElderlySignupPageState extends State<ElderlySignupPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final ImagePicker _imagePicker = ImagePicker();

  // Step 1: Documents/Images
  File? _personalPhoto;
  File? _responsibleIdFront;
  File? _responsibleIdBack;
  File? _selfieWithId;

  // Step 2: Personal Information
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _healthStatusController = TextEditingController();
  final _medicationsController = TextEditingController();
  final _chronicDiseasesController = TextEditingController();
  final _specialPreferencesController = TextEditingController();
  String? _selectedGender;
  DateTime? _birthDate;
  String? _selectedPsychologicalState;
  String? _selectedMobility;
  String? _selectedCareType;
  bool? _medicationAlert;

  // Step 3: Password, Preferences & Guardian Info
  final _guardianNameController = TextEditingController();
  final _guardianKinshipController = TextEditingController();
  final _guardianPhoneController = TextEditingController();
  final _guardianEmailController = TextEditingController();

  // Dropdown options
  final List<String> _psychologicalStates = ['مستقر', 'قلق', 'اكتئاب', 'آخر'];
  final List<String> _mobilityOptions = ['مستقل تماماً', 'يحتاج مساعدة', 'غير قادر على الحركة'];
  final List<String> _careTypes = ['رعاية يومية', 'رعاية ليلية', 'رعاية 24 ساعة', 'رعاية مؤقتة'];

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _healthStatusController.dispose();
    _medicationsController.dispose();
    _chronicDiseasesController.dispose();
    _specialPreferencesController.dispose();
    _guardianNameController.dispose();
    _guardianKinshipController.dispose();
    _guardianPhoneController.dispose();
    _guardianEmailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source, {required Function(File) onImagePicked}) async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: source);
      if (image != null) {
        onImagePicked(File(image.path));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في اختيار الصورة: $e')),
      );
    }
  }

  void _nextStep() {
    if (_currentStep < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _handleSignUp();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _handleSignUp() async {
    // TODO: Implement actual sign up logic
    if (!mounted) return;
    
    showDialog(
      context: context,
      builder: (context) => SuccessDialog(
        title: 'نجاح',
        message: 'تم إنشاء حساب كبار السن بنجاح',
        buttonText: 'دخول',
        onPressed: () {
          Navigator.of(context).pop();
          context.go(RouteNames.home);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary,
            size: 20,
          ),
          onPressed: () {
            if (_currentStep > 0) {
              _previousStep();
            } else {
              context.pop();
            }
          },
        ),
        title: const Text(
          'انشاء حساب كبار السن',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: List.generate(3, (index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                    height: 4,
                    decoration: BoxDecoration(
                      color: index <= _currentStep
                          ? AppColors.primary
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
          
          // Steps Content
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentStep = index);
              },
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildStep1Documents(),
                _buildStep2PersonalInfo(),
                _buildStep3AdditionalInfo(),
              ],
            ),
          ),
          
          // Navigation Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousStep,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        'السابق',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      _currentStep == 2 ? 'إنشاء الحساب' : 'التالي',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1Documents() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'رفع المستندات',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 32),
          
          // Personal Photo
          _buildDocumentUpload(
            label: 'الصورة الشخصية *',
            file: _personalPhoto,
            onTap: () => _pickImage(ImageSource.gallery, onImagePicked: (file) {
              setState(() => _personalPhoto = file);
            }),
          ),
          const SizedBox(height: 24),
          
          // Responsible ID Front
          _buildDocumentUpload(
            label: 'وجه بطاقة الهوية المسؤول *',
            file: _responsibleIdFront,
            onTap: () => _pickImage(ImageSource.gallery, onImagePicked: (file) {
              setState(() => _responsibleIdFront = file);
            }),
          ),
          const SizedBox(height: 24),
          
          // Responsible ID Back
          _buildDocumentUpload(
            label: 'ظهر بطاقة الهوية المسؤول *',
            file: _responsibleIdBack,
            onTap: () => _pickImage(ImageSource.gallery, onImagePicked: (file) {
              setState(() => _responsibleIdBack = file);
            }),
          ),
          const SizedBox(height: 24),
          
          // Selfie with ID
          _buildDocumentUpload(
            label: 'سيلفي مع الهوية المسؤول *',
            file: _selfieWithId,
            onTap: () => _pickImage(ImageSource.camera, onImagePicked: (file) {
              setState(() => _selfieWithId = file);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentUpload({
    required String label,
    File? file,
    required VoidCallback onTap,
    bool isRequired = true,
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
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: file != null ? AppColors.primary : Colors.grey[300]!,
                width: 1.5,
              ),
            ),
            child: file != null
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          file,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        left: 4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 24,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'اسحب وأفلت ملف هنا أو انقر',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2PersonalInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'المعلومات الشخصية والصحية',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 32),
          
          // Row 1: Name & Date of Birth
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() => _birthDate = date);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _birthDate != null
                                ? '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}'
                                : 'تاريخ الميلاد *',
                            style: TextStyle(
                              color: _birthDate != null ? Colors.black : Colors.grey[600],
                            ),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Icon(Icons.calendar_today, color: Colors.grey[400], size: 20),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _nameController,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'الإسم *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Row 2: Gender & Phone
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: InputDecoration(
                    labelText: 'النوع *',
                    hintText: 'إختر',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items: ['أنثى', 'ذكر'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, textDirection: TextDirection.rtl),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedGender = value);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'الهاتف *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Row 3: Email & Address
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _addressController,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'العنوان *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Health Status
          TextFormField(
            controller: _healthStatusController,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              labelText: 'الحالة الصحية *',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          const SizedBox(height: 16),
          
          // Regular Medications
          TextFormField(
            controller: _medicationsController,
            maxLines: 3,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              labelText: 'الادوية المنتظمة *',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 16),
          
          // Row 4: Psychological State & Mobility
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedMobility,
                  decoration: InputDecoration(
                    labelText: 'القدرة على الحركة *',
                    hintText: 'إختر',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    isDense: true,
                  ),
                  items: _mobilityOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 13)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedMobility = value);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedPsychologicalState,
                  decoration: InputDecoration(
                    labelText: 'الحالة النفسية *',
                    hintText: 'إختر',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    isDense: true,
                  ),
                  items: _psychologicalStates.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 13)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedPsychologicalState = value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Chronic Diseases
          TextFormField(
            controller: _chronicDiseasesController,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              labelText: 'الأمراض المزمنة *',
              hintText: 'بحث...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          const SizedBox(height: 16),
          
          // Care Type
          DropdownButtonFormField<String>(
            value: _selectedCareType,
            decoration: InputDecoration(
              labelText: 'نوع الرعاية المطلوبة *',
              hintText: 'إختر',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            items: _careTypes.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, textDirection: TextDirection.rtl),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => _selectedCareType = value);
            },
          ),
          const SizedBox(height: 24),
          
          // Medication Alert Question
          _buildYesNoQuestion(
            'تنبيه بالأدوية؟',
            _medicationAlert,
            (value) => setState(() => _medicationAlert = value),
          ),
        ],
      ),
    );
  }

  Widget _buildYesNoQuestion(String question, bool? value, ValueChanged<bool?> onChanged) {
    return Row(
      children: [
        Row(
          children: [
            Radio<bool?>(
              value: false,
              groupValue: value,
              onChanged: onChanged,
              activeColor: AppColors.primary,
            ),
            const Text('لا'),
            const SizedBox(width: 16),
            Radio<bool?>(
              value: true,
              groupValue: value,
              onChanged: onChanged,
              activeColor: AppColors.primary,
            ),
            const Text('نعم'),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }

  Widget _buildStep3AdditionalInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'معلومات إضافية',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 32),
          
          // Password Fields (Disabled/Auto-generated)
          TextFormField(
            enabled: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'كلمة مرور جديدة',
              hintText: 'سيتم إنشاؤها تلقائياً',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          const SizedBox(height: 16),
          
          TextFormField(
            enabled: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'تأكيد كلمة المرور',
              hintText: 'أعد إدخال كلمة المرور',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '8 أحرف على الأقل',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 32),
          
          // Special Preferences
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'تفضيلات خاصة',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _specialPreferencesController,
            maxLines: 4,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              labelText: 'تفضيلات خاصة',
              hintText: 'ادخل التفضيلات الخاصة',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 32),
          
          // Divider
          Divider(
            thickness: 1,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 32),
          
          // Guardian Section Title
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'بيانات ولي الأمر أو المسؤول (إن وجد)',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 24),
          
          // Row 1: Guardian Name & Kinship
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _guardianKinshipController,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'صلة القرابة',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _guardianNameController,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'الإسم',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Row 2: Guardian Phone & Email
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _guardianEmailController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _guardianPhoneController,
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'الهاتف',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
