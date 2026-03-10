// lib/features/profile/presentation/pages/privacy_settings_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';

/// Privacy Settings Screen
/// إعدادات الخصوصية
class PrivacySettingsPage extends StatelessWidget {
  const PrivacySettingsPage({super.key});

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
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: const Text(
          'الخصوصية',
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
            _buildPrivacyItem(
              icon: Icons.lock_outline,
              title: 'سياسة الخصوصية',
              onTap: () {
                context.push(RouteNames.privacyPolicy);
              },
            ),
            const SizedBox(height: 16),
            _buildPrivacyItem(
              icon: Icons.security,
              title: 'أمان الحساب',
              onTap: () {
                context.push(RouteNames.accountSecurity);
              },
            ),
            const SizedBox(height: 16),
            _buildPrivacyItem(
              icon: Icons.delete_outline,
              title: 'حذف الحساب',
              onTap: () {
                context.push(RouteNames.deleteAccount);
              },
            ),
            const SizedBox(height: 16),
            _buildPrivacyItem(
              icon: Icons.download,
              title: 'تنزيل بياناتي',
              onTap: () {
                context.push(RouteNames.downloadData);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.arrow_back_ios, size: 16, color: Colors.grey),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(width: 16),
            Icon(icon, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
