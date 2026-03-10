// lib/features/profile/presentation/pages/privacy_policy_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

/// Privacy Policy Screen
/// سياسة الخصوصية
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
          'سياسة الخصوصية',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'سياسة الخصوصية',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: '1. جمع المعلومات',
              content:
                  'نقوم بجمع المعلومات التي تقدمها لنا مباشرة عند استخدامك لخدماتنا، بما في ذلك معلومات التسجيل والحساب، ومعلومات الاتصال، ومعلومات الملف الشخصي.',
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: '2. استخدام المعلومات',
              content:
                  'نستخدم المعلومات التي نجمعها لتقديم وصيانة وتحسين خدماتنا، ولإرسال الإشعارات والمعلومات المهمة، ولتوفير الدعم الفني للعملاء.',
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: '3. مشاركة المعلومات',
              content:
                  'لا نبيع أو نؤجر معلوماتك الشخصية لأطراف ثالثة. قد نشارك معلوماتك فقط في الحالات المنصوص عليها في هذه السياسة أو مع موافقتك الصريحة.',
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: '4. الأمان',
              content:
                  'نطبق تدابير أمنية مناسبة لحماية معلوماتك الشخصية من الوصول غير المصرح به أو التغيير أو الإفشاء أو التدمير.',
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: '5. حقوقك',
              content:
                  'لديك الحق في الوصول إلى معلوماتك الشخصية وتصحيحها أو حذفها، والاعتراض على معالجتها، وطلب نقل بياناتك.',
            ),
            const SizedBox(height: 32),
            Text(
              'آخر تحديث: ${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.black87,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
