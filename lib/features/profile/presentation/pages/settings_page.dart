// lib/features/profile/presentation/pages/settings_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';

/// Settings Screen
/// الإعدادات
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
          'الإعدادات',
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
            // Notification Settings
            _buildSettingItem(
              icon: Icons.notifications,
              title: 'الإشعارات',
              onTap: () {
                context.push(RouteNames.notificationsSettings);
              },
            ),
            const SizedBox(height: 16),
            // Language Settings
            _buildSettingItem(
              icon: Icons.language,
              title: 'اللغة',
              onTap: () {
                context.push(RouteNames.languageSettings);
              },
            ),
            const SizedBox(height: 16),
            // Privacy Settings
            _buildSettingItem(
              icon: Icons.privacy_tip,
              title: 'الخصوصية',
              onTap: () {
                context.push(RouteNames.privacySettings);
              },
            ),
            const SizedBox(height: 16),
            // About
            _buildSettingItem(
              icon: Icons.info,
              title: 'حول التطبيق',
              onTap: () {
                context.push(RouteNames.about);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
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
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            // Arrow on left
            const Icon(Icons.arrow_back_ios, size: 16, color: Colors.grey),
            const Spacer(),
            // Text and Icon on right
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
