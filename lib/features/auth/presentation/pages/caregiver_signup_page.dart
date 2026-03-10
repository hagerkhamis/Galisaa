// lib/features/auth/presentation/pages/caregiver_signup_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../core/config/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/success_dialod.dart';

/// Caregiver Sign Up Screen (Multi-step)
/// صفحة تسجيل جليسة (متعددة الخطوات)
class CaregiverSignupPage extends StatefulWidget {
  const CaregiverSignupPage({super.key});

  @override
  State<CaregiverSignupPage> createState() => _CaregiverSignupPageState();
}

class _CaregiverSignupPageState extends State<CaregiverSignupPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final ImagePicker _imagePicker = ImagePicker();

  // Step 1: Documents/Images
  File? _profileImage;
  File? _idImage;
  File? _selfieWithId;
  File? _cvDocument;

  // Step 2: Personal Information
  final _nameController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _addressController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _phone2Controller = TextEditingController();
  final _educationController = TextEditingController();
  final _languagesController = TextEditingController();
  String? _selectedMaritalStatus;
  String? _selectedGender;
  DateTime? _birthDate;
  String? _selectedAvailability;

  // Step 2: Questions (Yes/No)
  bool? _hasExperience;
  bool? _canGiveMedicine;
  bool? _canBatheAndChange;
  bool? _canHelpWithMobility;
  bool? _canCook;
  bool? _canHandleMedicalDevices;

  // Step 3: Additional Info
  final _skillsController = TextEditingController();
  final _coursesController = TextEditingController();
  final _notesController = TextEditingController();
  String? _selectedGeographicArea;
  
  // Schedule (Dynamic List)
  List<Map<String, dynamic>> _schedules = [];
  
  // Service Prices (Dynamic List)
  List<Map<String, dynamic>> _servicePrices = [];
  
  // Dropdown options
  final List<String> _days = ['السبت', 'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة'];
  final List<String> _serviceTypes = ['رعاية يومية', 'رعاية ليلية', 'رعاية 24 ساعة', 'رعاية مؤقتة'];
  final List<String> _geographicAreas = ['الرياض', 'جدة', 'الدمام', 'المدينة المنورة', 'مكة المكرمة'];

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _nationalityController.dispose();
    _addressController.dispose();
    _idNumberController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _phone2Controller.dispose();
    _educationController.dispose();
    _languagesController.dispose();
    _skillsController.dispose();
    _coursesController.dispose();
    _notesController.dispose();
    // Dispose service price controllers
    for (var price in _servicePrices) {
      final controller = price['controller'] as TextEditingController?;
      controller?.dispose();
    }
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
        message: 'تم إنشاء حساب الجليسة بنجاح',
        buttonText: 'دخول',
        onPressed: () {
          Navigator.of(context).pop();
          context.go(RouteNames.caregiverProfile);
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
        centerTitle: true,
        title: Text(
          'إنشاء حساب جليسة',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
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
          
          // Profile Image
          _buildDocumentUpload(
            label: 'الصورة *',
            file: _profileImage,
            onTap: () => _pickImage(ImageSource.gallery, onImagePicked: (file) {
              setState(() => _profileImage = file);
            }),
          ),
          const SizedBox(height: 24),
          
          // ID Image
          _buildDocumentUpload(
            label: 'صورة الهوية *',
            file: _idImage,
            onTap: () => _pickImage(ImageSource.gallery, onImagePicked: (file) {
              setState(() => _idImage = file);
            }),
          ),
          const SizedBox(height: 24),
          
          // Selfie with ID
          _buildDocumentUpload(
            label: 'سيلفي مع الهوية *',
            file: _selfieWithId,
            onTap: () => _pickImage(ImageSource.camera, onImagePicked: (file) {
              setState(() => _selfieWithId = file);
            }),
          ),
          const SizedBox(height: 24),
          
          // CV Document
          _buildDocumentUpload(
            label: 'السيرة الذاتية و شهادات الدورات',
            file: _cvDocument,
            onTap: () => _pickImage(ImageSource.gallery, onImagePicked: (file) {
              setState(() => _cvDocument = file);
            }),
            isRequired: false,
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
            'المعلومات الشخصية',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 32),
          
          // Row 1: Date of Birth & Name
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
                    hintText: 'أدخل الاسم',
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
          
          // Row 2: ID Number & Nationality
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _idNumberController,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'رقم الهوية *',
                    hintText: 'أدخل رقم الهوية',
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
                  controller: _nationalityController,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'الجنسية *',
                    hintText: 'ادخل الجنسية',
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
          
          // Row 3: Gender & Address
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
                  controller: _addressController,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'العنوان *',
                    hintText: 'أدخل العنوان',
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
          
          // Row 4: Marital Status & Email
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedMaritalStatus,
                  decoration: InputDecoration(
                    labelText: 'الحالة الاجتماعية *',
                    hintText: 'إختر',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items: ['أعزب', 'متزوج', 'أرمل', 'مطلق'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, textDirection: TextDirection.rtl),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedMaritalStatus = value);
                  },
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
                    labelText: 'البريد الإلكتروني *',
                    hintText: 'أدخل البريد الإلكتروني',
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
          
          // Row 5: Phone 2 & Phone
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _phone2Controller,
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'هاتف 2',
                    hintText: 'أدخل رقم هاتف 2',
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
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'الهاتف *',
                    hintText: 'أدخل الهاتف',
                    
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
          
          // Row 6: Languages & Education
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _languagesController,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'اللغات *',
                    hintText: 'ادخل اللغات',
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
                  controller: _educationController,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'المؤهل الدراسي *',
                    hintText: 'ادخل المؤهل الدراسي',
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
          
          // Availability
          DropdownButtonFormField<String>(
            value: _selectedAvailability,
            decoration: InputDecoration(
              labelText: 'التفرغ *',
              hintText: 'إختر',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            items: ['كامل', 'جزئي', 'عند الطلب'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, textDirection: TextDirection.rtl),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => _selectedAvailability = value);
            },
          ),
          const SizedBox(height: 24),
          
          // Questions
          _buildYesNoQuestion(
            'هل لديك خبرة سابقة في رعاية كبار السن؟ *',
            _hasExperience,
            (value) => setState(() => _hasExperience = value),
          ),
          const SizedBox(height: 16),
          _buildYesNoQuestion(
            'هل تستطيعين إعطاء الأدوية؟',
            _canGiveMedicine,
            (value) => setState(() => _canGiveMedicine = value),
          ),
          const SizedBox(height: 16),
          _buildYesNoQuestion(
            'هل تستطيعين الاستحمام والتبديل؟',
            _canBatheAndChange,
            (value) => setState(() => _canBatheAndChange = value),
          ),
          const SizedBox(height: 16),
          _buildYesNoQuestion(
            'هل تستطيعين المساعدة في التنقل؟',
            _canHelpWithMobility,
            (value) => setState(() => _canHelpWithMobility = value),
          ),
          const SizedBox(height: 16),
          _buildYesNoQuestion(
            'هل تستطيعين الطهي؟',
            _canCook,
            (value) => setState(() => _canCook = value),
          ),
          const SizedBox(height: 16),
          _buildYesNoQuestion(
            'هل تستطيعين التعامل مع الأجهزة الطبية البسيطة؟',
            _canHandleMedicalDevices,
            (value) => setState(() => _canHandleMedicalDevices = value),
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title with icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'معلومات إضافية',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          
          // Skills Section
          _buildSectionHeader('المهارات والحالات', isRequired: true),
          const SizedBox(height: 12),
          TextFormField(
            controller: _skillsController,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              labelText: 'نوع الحالات التي تم التعامل معها',
              hintText: 'أدخل المهارات والحالات...',
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
            ),
          ),
          const SizedBox(height: 28),
          
          // Courses Section
          _buildSectionHeader('الشهادات والدورات'),
          const SizedBox(height: 12),
          TextFormField(
            controller: _coursesController,
            maxLines: 4,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              labelText: 'الدورات أو الشهادات في رعاية كبار السن',
              hintText: 'ادخل السيرة الذاتية وشهادات الدورات...',
              
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
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 28),
          
          // Schedule Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionHeader('الجدول الزمني', isSmall: true),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _schedules.add({
                      'day': null,
                      'startTime': null,
                      'endTime': null,
                    });
                  });
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('إضافة جدول', style: TextStyle(fontSize: 14)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Schedule List
          ...List.generate(_schedules.length, (index) {
            return _buildScheduleItem(index);
          }),
          
          if (_schedules.isEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: const Text(
                'لا توجد جداول مضافة. اضغط على "إضافة جدول" لإضافة جدول زمني.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 28),
          
          // Geographic Area Section
          _buildSectionHeader('المنطقة الجغرافية'),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedGeographicArea,
            decoration: InputDecoration(
              labelText: 'اختر المنطقة الجغرافية',
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            items: _geographicAreas.map((area) {
              return DropdownMenuItem(
                value: area,
                child: Text(area, textDirection: TextDirection.rtl),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => _selectedGeographicArea = value);
            },
          ),
          const SizedBox(height: 28),
          
          // Service Prices Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionHeader('أسعار الخدمات', isSmall: true),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _servicePrices.add({
                      'serviceType': null,
                      'price': null,
                      'controller': null,
                    });
                  });
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('إضافة سعر', style: TextStyle(fontSize: 14)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Service Prices List
          ...List.generate(_servicePrices.length, (index) {
            return _buildServicePriceItem(index);
          }),
          
          if (_servicePrices.isEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: const Text(
                'لا توجد أسعار مضافة. اضغط على "إضافة سعر" لإضافة أسعار الخدمات.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 28),
          
          // Notes Section
          _buildSectionHeader('ملاحظات إضافية'),
          const SizedBox(height: 12),
          TextFormField(
            controller: _notesController,
            maxLines: 4,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              labelText: 'ملاحظات',
              hintText: 'أدخل أي ملاحظات إضافية...',
              
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
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  
  Widget _buildSectionHeader(String title, {bool isRequired = false, bool isSmall = false}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isRequired)
            const Text(
              '*',
              style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          Text(
            title,
            style: TextStyle(
              fontSize: isSmall ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
  
  Widget _buildScheduleItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!, width: 1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() => _schedules.removeAt(index));
                  },
                  child: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'جدول ${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _schedules[index]['day'],
                      decoration: InputDecoration(
                        labelText: 'اليوم',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                        isDense: true,
                      ),
                      style: const TextStyle(fontSize: 13),
                      items: _days.map((day) {
                        return DropdownMenuItem(
                          value: day,
                          child: Text(day, textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 13)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _schedules[index]['day'] = value);
                      },
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() {
                            _schedules[index]['startTime'] = '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.access_time, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                _schedules[index]['startTime'] ?? 'وقت البدء',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _schedules[index]['startTime'] != null ? Colors.black : Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() {
                            _schedules[index]['endTime'] = '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.access_time, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                _schedules[index]['endTime'] ?? 'وقت الانتهاء',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _schedules[index]['endTime'] != null ? Colors.black : Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildServicePriceItem(int index) {
    // Initialize controller if not exists
    if (_servicePrices[index]['controller'] == null) {
      _servicePrices[index]['controller'] = TextEditingController(
        text: _servicePrices[index]['price']?.toString() ?? '',
      );
    }
    final priceController = _servicePrices[index]['controller'] as TextEditingController;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!, width: 1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    final controller = _servicePrices[index]['controller'] as TextEditingController?;
                    controller?.dispose();
                    setState(() => _servicePrices.removeAt(index));
                  },
                  child: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'سعر خدمة ${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _servicePrices[index]['serviceType'],
                  decoration: InputDecoration(
                    labelText: 'إختر',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    isDense: true,
                  ),
                  items: _serviceTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type, textDirection: TextDirection.rtl),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _servicePrices[index]['serviceType'] = value);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: 'ادخل السعر',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    isDense: true,
                  ),
                  onChanged: (value) {
                    _servicePrices[index]['price'] = value;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
