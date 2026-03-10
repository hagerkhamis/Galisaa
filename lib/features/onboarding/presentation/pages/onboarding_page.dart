// lib/features/onboarding/presentation/pages/onboarding_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/routes/route_names.dart';
import '../../../../core/utils/storage_helper.dart';
import '../widgets/onboarding_content.dart';
import '../models/onboarding_data.dart';

/// Onboarding Screen
/// 3 screens للتعريف بالتطبيق
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    const OnboardingData(
      image: 'assets/images/intro2.png', 
      title: 'جليسه.... جنبك وقت و ما تحتاج',
      description: '',
    ),
    const OnboardingData(
      image: 'assets/images/intro3.png',
      title: 'أهلا بك في جليسة',
      description: 'رعاية تحس بيك في كل وقت ومكان',
    ),
    const OnboardingData(
      image: 'assets/images/intro4.png',
      title: 'لماذا جليسة؟',
      description: 'رعاية تحس بيك، في كل وقت ومكان',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToLogin();
    }
  }

  Future<void> _goToLogin() async {
    await StorageHelper.setOnboardingCompleted();
    if (!mounted) return;
    context.go(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF26805),
      body: Container(
        color: const Color(0xFFF26805),
        child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  // First onboarding page should match the provided design exactly
                  if (index == 0) {
                    final data = _pages[index];
                    return Container(
                      color: const Color(0xFFF26805),
                      child: Stack(
                        children: [
                          // Left-aligned image with rounded right corners and lower top offset
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: FractionallySizedBox(
                              widthFactor: 0.68,
                              heightFactor: 1.0,
                              alignment: Alignment.bottomLeft,
                              child: Transform.translate(
                                offset: const Offset(0, 24),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    bottomRight: Radius.circular(40),
                                  ),
                                  child: Image.asset(
                                    data.image,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.bottomLeft,
                                    errorBuilder: (ctx, err, st) => Container(
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Top-right stacked title (Arabic) in white
                          Positioned(
                            top: 28,
                            right: 18,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.34,
                              ),
                              child: Text(
                                data.title,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  height: 1.02,
                                ),
                              ),
                            ),
                          ),

                          // Small red dot on the left-middle area of the image
                          Positioned(
                            left: MediaQuery.of(context).size.width * 0.08,
                            bottom: MediaQuery.of(context).size.height * 0.28,
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xFFCE2B2B),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // Second page: full-image onboarding (no overlays)
                  if (index == 1) {
                    final data = _pages[index];
                    return Container(
                      color: Colors.transparent,
                      child: Image.asset(
                        data.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        errorBuilder: (ctx, err, st) => Container(
                          color: Colors.grey[200],
                        ),
                      ),
                    );
                  }

                  // Third page: full-image onboarding (no overlays)
                  if (index == 2) {
                    final data = _pages[index];
                    return Container(
                      color: Colors.transparent,
                      child: Image.asset(
                        data.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        errorBuilder: (ctx, err, st) => Container(
                          color: Colors.grey[200],
                        ),
                      ),
                    );
                  }

                  return OnboardingContent(data: _pages[index]);
                },
              ),
            ),
            // Page Indicators (customized to match provided design)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: _currentPage == 0
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // small white dot
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // orange rounded capsule
                          Container(
                            width: 36,
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF26805),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      )
                    : (_currentPage == 1 || _currentPage == 2)
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(3, (i) {
                              final bool active = i == _currentPage;
                              return Container(
                                width: active ? 12 : 8,
                                height: active ? 12 : 8,
                                margin: const EdgeInsets.symmetric(horizontal: 6),
                                decoration: BoxDecoration(
                                  color: active
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _pages.length,
                              (index) => Container(
                                width: _currentPage == index ? 24 : 8,
                                height: 8,
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: _currentPage == index
                                      ? const Color(0xFFF26805)
                                      : const Color(0xFFF26805).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
              ),
            ),
            const SizedBox(height: 32),
            // Skip/Next Button: hide for first two pages to allow swipe-only navigation
            if (_currentPage > 1) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _currentPage == _pages.length - 1
                        ? _goToLogin
                        : _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF26805),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1 ? 'ابدأ الآن' : 'التالي',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ] else ...[
              const SizedBox(height: 24),
            ],
          ],
        ),
        ),
      ),
    );
  }
}

