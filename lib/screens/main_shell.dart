import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'home_screen.dart';
import 'meditate_screen.dart';
import 'journal_screen.dart';
import 'cycles_screen.dart';
import 'mood_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  /// Navigate to a tab from anywhere inside the shell
  static void navigateTo(BuildContext context, int index) {
    final state = context.findAncestorStateOfType<_MainShellState>();
    state?.navigateToTab(index);
  }

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  void navigateToTab(int index) {
    setState(() => _currentIndex = index);
  }

  final List<Widget> _screens = const [
    HomeScreen(),
    MeditateScreen(),
    JournalScreen(),
    CyclesScreen(),
    MoodScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.02),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_currentIndex),
          child: _screens[_currentIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          backgroundColor: isDark ? AppColors.darkCard : Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: isDark
              ? AppColors.darkTextSecondary
              : AppColors.textSecondary,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: GoogleFonts.dmSans(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.dmSans(fontSize: 11),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome_outlined),
              activeIcon: Icon(Icons.auto_awesome),
              label: 'Meditate',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              activeIcon: Icon(Icons.menu_book),
              label: 'Journal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.nightlight_outlined),
              activeIcon: Icon(Icons.nightlight),
              label: 'Cycles',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sentiment_satisfied_outlined),
              activeIcon: Icon(Icons.sentiment_satisfied),
              label: 'Mood',
            ),
          ],
        ),
      ),
    );
  }
}
