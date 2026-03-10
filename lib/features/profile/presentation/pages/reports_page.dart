// lib/features/profile/presentation/pages/reports_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';

/// Reports Screen
/// التقارير
class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  // Sample data for the table
  final List<Map<String, dynamic>> _sessionsData = const [
    {
      'date': '2025-12-17',
      'time': '12:05',
      'elderly': 'فاطمة علي',
      'caregiver': 'فاطمة أحمد',
      'isRated': true,
    },
    {
      'date': '2025-12-18',
      'time': '12:05',
      'elderly': 'فاطمة علي',
      'caregiver': 'فاطمة أحمد',
      'isRated': false,
    },
    {
      'date': '2025-12-19',
      'time': '12:05',
      'elderly': 'فاطمة علي',
      'caregiver': 'فاطمة أحمد',
      'isRated': false,
    },
    {
      'date': '2025-12-20',
      'time': '12:05',
      'elderly': 'فاطمة علي',
      'caregiver': 'فاطمة أحمد',
      'isRated': false,
    },
    {
      'date': '2025-12-21',
      'time': '12:05',
      'elderly': 'فاطمة علي',
      'caregiver': 'فاطمة أحمد',
      'isRated': true,
    },
    {
      'date': '2025-12-21',
      'time': '14:16',
      'elderly': 'محمد عبدالله',
      'caregiver': 'نورا حسن',
      'isRated': true,
    },
    {
      'date': '2025-12-22',
      'time': '12:05',
      'elderly': 'فاطمة علي',
      'caregiver': 'فاطمة أحمد',
      'isRated': false,
    },
    {
      'date': '2025-12-22',
      'time': '14:16',
      'elderly': 'محمد عبدالله',
      'caregiver': 'نورا حسن',
      'isRated': false,
    },
    {
      'date': '2025-12-23',
      'time': '12:05',
      'elderly': 'فاطمة علي',
      'caregiver': 'فاطمة أحمد',
      'isRated': false,
    },
    {
      'date': '2025-12-23',
      'time': '14:16',
      'elderly': 'محمد عبدالله',
      'caregiver': 'نورا حسن',
      'isRated': false,
    },
  ];

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
          'التقارير',
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
            // Sessions Table
            const Text(
              'سجل الجلسات',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 16),
            _buildSessionsTable(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionsTable(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey[100]),
          columns: [
            DataColumn(
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_drop_down, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    'الإجراءات',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            DataColumn(
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_drop_down, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    'جليسة',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            DataColumn(
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_drop_down, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    'كبار السن',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            DataColumn(
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_drop_down, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    'وقت البده',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            DataColumn(
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_drop_down, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    'التاريخ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ],
          rows: _sessionsData.map((session) {
            return DataRow(
              cells: [
                // الإجراءات
                DataCell(
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        context.push(
                          '${RouteNames.sessionEvaluation}?date=${session['date']}&time=${session['time']}&caregiverName=${session['caregiver']}',
                        );
                      },
                      child: Icon(
                        Icons.star,
                        color: (session['isRated'] as bool) ? Colors.amber : Colors.grey[400],
                        size: 24,
                      ),
                    ),
                  ),
                ),
                // جليسة
                DataCell(
                  Center(
                    child: Text(
                      session['caregiver'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                // كبار السن
                DataCell(
                  Center(
                    child: Text(
                      session['elderly'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                // وقت البده
                DataCell(
                  Center(
                    child: Text(
                      session['time'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                // التاريخ
                DataCell(
                  Center(
                    child: Text(
                      session['date'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }

  Widget _buildActionCell(
    BuildContext context,
    bool isRated,
    String date,
    String time,
    String caregiverName,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: GestureDetector(
          onTap: () {
            context.push(
              '${RouteNames.sessionEvaluation}?date=$date&time=$time&caregiverName=$caregiverName',
            );
          },
          child: Icon(
            Icons.star,
            color: isRated ? Colors.amber : Colors.grey[400],
            size: 24,
          ),
        ),
      ),
    );
  }
}
