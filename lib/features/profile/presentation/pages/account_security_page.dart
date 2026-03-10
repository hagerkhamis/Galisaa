// lib/features/profile/presentation/pages/account_security_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

/// Account Security Screen
/// أمان الحساب
class AccountSecurityPage extends StatefulWidget {
  const AccountSecurityPage({super.key});

  @override
  State<AccountSecurityPage> createState() => _AccountSecurityPageState();
}

class _AccountSecurityPageState extends State<AccountSecurityPage> {
  bool _twoFactorAuth = false;
  bool _biometricAuth = true;

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
          'أمان الحساب',
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
            _buildSecurityItem(
              icon: Icons.lock_outline,
              title: 'تغيير كلمة المرور',
              subtitle: 'قم بتحديث كلمة المرور الخاصة بك',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تغيير كلمة المرور')),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildSwitchTile(
              icon: Icons.security,
              title: 'المصادقة الثنائية',
              subtitle: 'طبقة إضافية من الحماية لحسابك',
              value: _twoFactorAuth,
              onChanged: (value) {
                setState(() => _twoFactorAuth = value);
              },
            ),
            const SizedBox(height: 16),
            _buildSwitchTile(
              icon: Icons.fingerprint,
              title: 'المصادقة البيومترية',
              subtitle: 'استخدم بصمة الإصبع أو التعرف على الوجه',
              value: _biometricAuth,
              onChanged: (value) {
                setState(() => _biometricAuth = value);
              },
            ),
            const SizedBox(height: 16),
            _buildSecurityItem(
              icon: Icons.devices,
              title: 'الأجهزة المتصلة',
              subtitle: 'عرض وإدارة الأجهزة المتصلة بحسابك',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('الأجهزة المتصلة')),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildSecurityItem(
              icon: Icons.history,
              title: 'سجل تسجيل الدخول',
              subtitle: 'عرض سجل أنشطة تسجيل الدخول',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('سجل تسجيل الدخول')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityItem({
    required IconData icon,
    required String title,
    required String subtitle,
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

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const Spacer(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Icon(icon, color: AppColors.primary),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
