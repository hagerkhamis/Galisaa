// lib/features/profile/presentation/pages/caregiver_profile_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../core/config/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/storage_helper.dart';

/// Caregiver Profile Screen
/// الملف الشخصي للجليسة
class CaregiverProfilePage extends StatefulWidget {
  const CaregiverProfilePage({super.key});

  @override
  State<CaregiverProfilePage> createState() => _CaregiverProfilePageState();
}

class _CaregiverProfilePageState extends State<CaregiverProfilePage> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  // TODO: In a real app, fetch this data from API/state management
  String _name = 'ليلي المهدي';
  double _rating = 4.7;

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في اختيار الصورة: $e')),
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
          // Orange Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              bottom: 24,
            ),
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Column(
              children: [
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
                            size: 20,
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

          // White Content Section with Menu Items
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        // Current Orders Menu Item
                        _buildMenuItem(
                          icon: Icons.description_outlined,
                          title: 'الطلبات الجاريه',
                          customIcon: _buildOverlappingDocumentsIcon(),
                          onTap: () {
                            context.push(RouteNames.myBookings);
                          },
                        ),
                        // Previous Orders Menu Item
                        _buildMenuItem(
                          icon: Icons.description_outlined,
                          title: 'الطلبات السابقة',
                          customIcon: _buildDocumentWithCheckIcon(),
                          onTap: () {
                            context.push(RouteNames.previousOrders);
                          },
                        ),
                        // Reports Menu Item
                        _buildMenuItem(
                          icon: Icons.description_outlined,
                          title: 'التقارير',
                          customIcon: _buildDocumentWithLinesIcon(),
                          onTap: () {
                            context.push(RouteNames.reports);
                          },
                        ),
                        // Settings Menu Item
                        _buildMenuItem(
                          icon: Icons.settings_outlined,
                          title: 'الاعدادات',
                          onTap: () {
                            context.push(RouteNames.settings);
                          },
                        ),
                        // Rating Menu Item
                        _buildMenuItem(
                          icon: Icons.star_outline,
                          title: 'التقييم',
                          onTap: () {
                            context.push(RouteNames.reports);
                          },
                        ),
                      ],
                    ),
                  ),
                  // Logout Button
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: ElevatedButton(
                      onPressed: _handleLogout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'تسجيل خروج',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
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

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? customIcon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Arrow on left
            const Icon(
              Icons.arrow_back_ios,
              size: 16,
              color: Colors.grey,
            ),
            const Spacer(),
            // Text in center
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(width: 16),
            // Icon on right
            customIcon ??
                Icon(
                  icon,
                  color: AppColors.primary,
                  size: 24,
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlappingDocumentsIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        children: [
          Positioned(
            left: 3,
            top: 2,
            child: Icon(
              Icons.description_outlined,
              color: AppColors.primary.withOpacity(0.7),
              size: 20,
            ),
          ),
          Icon(
            Icons.description_outlined,
            color: AppColors.primary,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentWithCheckIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        children: [
          Icon(
            Icons.description_outlined,
            color: AppColors.primary,
            size: 24,
          ),
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentWithLinesIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        children: [
          Icon(
            Icons.description_outlined,
            color: AppColors.primary,
            size: 24,
          ),
          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 1.5,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 2.5),
                  Container(
                    width: 10,
                    height: 1.5,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 2.5),
                  Container(
                    width: 10,
                    height: 1.5,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

