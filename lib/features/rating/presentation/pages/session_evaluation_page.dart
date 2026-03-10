// lib/features/rating/presentation/pages/session_evaluation_page.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Session Evaluation Screen
/// تقييم الجلسة
class SessionEvaluationPage extends StatefulWidget {
  final String? date;
  final String? time;
  final String? caregiverName;

  const SessionEvaluationPage({
    super.key,
    this.date,
    this.time,
    this.caregiverName,
  });

  @override
  State<SessionEvaluationPage> createState() => _SessionEvaluationPageState();
}

class _SessionEvaluationPageState extends State<SessionEvaluationPage> {
  int _cleanlinessRating = 4;
  int _interactionRating = 4;
  int _serviceQualityRating = 4;
  int _overallRating = 4;
  String _experienceType = 'ممتاز';
  final TextEditingController _commentController = TextEditingController();

  final List<String> _experienceTypes = [
    'ممتاز',
    'جيد جداً',
    'جيد',
    'مقبول',
    'ضعيف',
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFF26805),
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'تقييم الجلسة',
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
            // Time, Date and Caregiver Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Caregiver Name
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'جليسة',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.caregiverName ?? 'فاطمة أحمد',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Time and Date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'الوقت و التاريخ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.time ?? '12:05'} ${widget.date ?? '2025-12-18'}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Cleanliness Rating
            _buildRatingCategory(
              label: 'النظافة',
              emoji: '🧹',
              rating: _cleanlinessRating,
              onRatingChanged: (rating) {
                setState(() => _cleanlinessRating = rating);
              },
            ),
            const SizedBox(height: 20),

            // Interaction Rating
            _buildRatingCategory(
              label: 'التعامل',
              emoji: '👤',
              rating: _interactionRating,
              onRatingChanged: (rating) {
                setState(() => _interactionRating = rating);
              },
            ),
            const SizedBox(height: 20),

            // Service Quality Rating
            _buildRatingCategory(
              label: 'جودة الخدمة',
              emoji: '🏅',
              rating: _serviceQualityRating,
              onRatingChanged: (rating) {
                setState(() => _serviceQualityRating = rating);
              },
            ),
            const SizedBox(height: 20),

            // Overall Rating
            _buildRatingCategory(
              label: 'التقييم العام',
              emoji: '⭐',
              rating: _overallRating,
              onRatingChanged: (rating) {
                setState(() => _overallRating = rating);
              },
            ),
            const SizedBox(height: 24),

            // Comment Section
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'التعليق:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              maxLines: 4,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: 'أضف تعليقك هنا...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Experience Type
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownButton<String>(
                        value: _experienceType,
                        underline: Container(),
                        icon: const Icon(Icons.arrow_drop_down),
                        items: _experienceTypes.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(
                              type,
                              textDirection: TextDirection.rtl,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() => _experienceType = newValue);
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '⭐',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'نوع التجربة:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                // Save and Exit Button (Blue)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _saveEvaluation(exit: true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'حفظ وخروج',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Save and Continue Button (Green)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _saveEvaluation(exit: false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'حفظ ومتابعة',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingCategory({
    required String label,
    required String emoji,
    required int rating,
    required Function(int) onRatingChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Stars
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => onRatingChanged(index + 1),
              child: Icon(
                Icons.star,
                size: 28,
                color: index < rating ? Colors.amber : Colors.grey[300],
              ),
            );
          }),
        ),
        const SizedBox(width: 12),
        // Label with emoji
        Row(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 8),
            Text(
              '$label:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ],
    );
  }

  void _saveEvaluation({required bool exit}) {
    // TODO: Save evaluation to backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(exit ? 'تم حفظ التقييم' : 'تم حفظ التقييم بنجاح'),
        backgroundColor: Colors.green,
      ),
    );
    if (exit) {
      Navigator.of(context).pop();
    }
  }
}

