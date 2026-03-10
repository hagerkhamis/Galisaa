// lib/features/requests/presentation/pages/request_details_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

/// Request Details Screen
/// تفاصيل العرض
class RequestDetailsPage extends StatefulWidget {
  const RequestDetailsPage({super.key});

  @override
  State<RequestDetailsPage> createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
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
          ),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: const Text(
          'تفاصيل الطلب',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          // Customer Name
          _buildDetailRow(
            icon: Icons.person_outline,
            label: 'احمد السيد عمر',
          ),
          const Divider(height: 1, color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 20),

          // Time Slot
          _buildDetailRow(
            icon: Icons.access_time_outlined,
            label: '6 Am_8 Pm',
          ),
          const Divider(height: 1, color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 20),

          // Location
          _buildDetailRow(
            icon: Icons.location_on_outlined,
            label: 'القاهرة-الجيزة',
          ),
          const Divider(height: 1, color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 20),

          // Phone Number
          _buildDetailRow(
            icon: Icons.phone_outlined,
            label: '+20 123 456 789',
          ),
          const Divider(height: 1, color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 20),

          // Age
          _buildDetailRow(
            icon: Icons.people_outline,
            label: '30 سنه',
          ),
          
          const SizedBox(height: 64),

          // Approve Button
          ElevatedButton(
            onPressed: () {
              // TODO: Implement approve logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم الموافقة على الطلب')),
              );
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
              'موافقة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDetailRow({required IconData icon, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(width: 12),
          Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
        ],
      ),
    );
  }
}