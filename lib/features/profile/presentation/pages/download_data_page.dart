// lib/features/profile/presentation/pages/download_data_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

/// Download Data Screen
/// تنزيل بياناتي
class DownloadDataPage extends StatefulWidget {
  const DownloadDataPage({super.key});

  @override
  State<DownloadDataPage> createState() => _DownloadDataPageState();
}

class _DownloadDataPageState extends State<DownloadDataPage> {
  bool _isDownloading = false;

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
          'تنزيل بياناتي',
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
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.download,
                    size: 64,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'تنزيل بياناتك',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'يمكنك طلب نسخة من جميع بياناتك الشخصية. سيتم إرسال رابط التنزيل إلى بريدك الإلكتروني.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'البيانات المتضمنة:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 16),
            _buildDataItem(Icons.person, 'المعلومات الشخصية'),
            const SizedBox(height: 12),
            _buildDataItem(Icons.list_alt, 'الطلبات والحجوزات'),
            const SizedBox(height: 12),
            _buildDataItem(Icons.message, 'الرسائل والمحادثات'),
            const SizedBox(height: 12),
            _buildDataItem(Icons.assessment, 'التقارير والسجلات'),
            const SizedBox(height: 12),
            _buildDataItem(Icons.settings, 'الإعدادات والتفضيلات'),
            const SizedBox(height: 32),
            if (_isDownloading)
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              )
            else
              ElevatedButton(
                onPressed: () {
                  setState(() => _isDownloading = true);
                  // Simulate download
                  Future.delayed(const Duration(seconds: 2), () {
                    if (!mounted) return;
                    setState(() => _isDownloading = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم إرسال رابط التنزيل إلى بريدك الإلكتروني'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'طلب تنزيل البيانات',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              'ملاحظة: قد يستغرق تحضير بياناتك حتى 24 ساعة. ستحصل على رابط تنزيل صالح لمدة 7 أيام.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataItem(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
        ],
      ),
    );
  }
}
