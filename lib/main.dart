import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'theme/theme_notifier.dart';
import 'screens/splash_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const ThetaApp());
}

class ThetaApp extends StatefulWidget {
  const ThetaApp({super.key});

  @override
  State<ThetaApp> createState() => _ThetaAppState();
}

class _ThetaAppState extends State<ThetaApp> {
  final ThemeNotifier _themeNotifier = ThemeNotifier();

  @override
  void initState() {
    super.initState();
    _themeNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _themeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeNotifierProvider(
      notifier: _themeNotifier,
      child: MaterialApp(
        title: 'Theta',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeNotifier.themeMode,
        home: const SplashScreen(),
      ),
    );
  }
}
