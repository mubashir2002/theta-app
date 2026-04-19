import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  int _currentTextIndex = 0;
  late final AnimationController _animController;
  late final Animation<Offset> _slideIn;
  late final Animation<Offset> _slideOut;
  late final Animation<double> _fadeIn;
  late final Animation<double> _fadeOut;
  Timer? _autoSlideTimer;
  bool _sliding = false;

  final List<String> _texts = [
    'Meditate. Reflect. Track. Grow.',
    'Your sanctuary for mind and soul.',
    'Self-care made beautiful.',
    'Embrace your journey to wellness.',
  ];

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideOut = Tween<Offset>(begin: Offset.zero, end: const Offset(-1.0, 0))
        .animate(
          CurvedAnimation(
            parent: _animController,
            curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
          ),
        );

    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _slideIn = Tween<Offset>(begin: const Offset(1.0, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animController,
            curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
          ),
        );

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.reset();
        _sliding = false;
      }
    });

    _animController.addListener(() {
      if (_animController.value >= 0.5 && _sliding) {
        final nextIndex = (_currentTextIndex + 1) % _texts.length;
        if (_currentTextIndex != nextIndex) {
          setState(() => _currentTextIndex = nextIndex);
          _sliding = false;
        }
      }
    });

    _autoSlideTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _nextSlide();
    });
  }

  void _nextSlide() {
    if (_animController.isAnimating) return;
    _sliding = true;
    _animController.forward();
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [AppColors.darkBackground, AppColors.darkBackground]
                : [
                    const Color(0xFFFCE4EC),
                    AppColors.backgroundLight,
                    const Color(0xFFF5E0D0),
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 3),
              Text(
                'Theta',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  'Your all-in-one sanctuary for mind, body, and soul.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 60,
                child: AnimatedBuilder(
                  animation: _animController,
                  builder: (context, child) {
                    final isFirstHalf = _animController.value < 0.5;
                    return SlideTransition(
                      position: isFirstHalf ? _slideOut : _slideIn,
                      child: FadeTransition(
                        opacity: isFirstHalf ? _fadeOut : _fadeIn,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 48),
                          child: Text(
                            _texts[_currentTextIndex],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                              fontSize: 18,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const AuthScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeInOut,
                                  ),
                                  child: child,
                                );
                              },
                          transitionDuration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.dmSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const AuthScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                              child: child,
                            );
                          },
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                  );
                },
                child: Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary,
                    ),
                    children: [
                      TextSpan(
                        text: 'Log in',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _texts.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentTextIndex == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentTextIndex == index
                          ? AppColors.primary
                          : (isDark
                                ? AppColors.darkTextSecondary.withValues(
                                    alpha: 0.3,
                                  )
                                : AppColors.textSecondary.withValues(
                                    alpha: 0.3,
                                  )),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
