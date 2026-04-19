import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'main_shell.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _isLogin = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  late AnimationController _entryController;
  late Animation<double> _fadeEntry;
  late Animation<Offset> _slideEntry;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeEntry = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOut,
    );
    _slideEntry = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entryController, curve: Curves.easeOut));
    _entryController.forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MainShell(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.backgroundLight,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  'Theta',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Welcome back to your sanctuary',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),
                FadeTransition(
                  opacity: _fadeEntry,
                  child: SlideTransition(
                    position: _slideEntry,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: isDark
                            ? []
                            : [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Tab switcher
                          Container(
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkBackground
                                  : AppColors.backgroundCard,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => _isLogin = true),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _isLogin
                                            ? (isDark
                                                  ? AppColors.darkCard
                                                  : Colors.white)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(26),
                                      ),
                                      child: Text(
                                        'Log In',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.dmSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: _isLogin
                                              ? AppColors.primary
                                              : (isDark
                                                    ? AppColors
                                                          .darkTextSecondary
                                                    : AppColors.textSecondary),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => _isLogin = false),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: !_isLogin
                                            ? (isDark
                                                  ? AppColors.darkCard
                                                  : Colors.white)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(26),
                                      ),
                                      child: Text(
                                        'Create Account',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.dmSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: !_isLogin
                                              ? AppColors.primary
                                              : (isDark
                                                    ? AppColors
                                                          .darkTextSecondary
                                                    : AppColors.textSecondary),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: !_isLogin
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      _buildLabel('Name'),
                                      const SizedBox(height: 8),
                                      TextField(
                                        controller: _nameController,
                                        decoration: const InputDecoration(
                                          hintText: 'Your name',
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      _buildLabel('Date of Birth'),
                                      const SizedBox(height: 8),
                                      TextField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText: 'mm/dd/yyyy',
                                          suffixIcon: Icon(
                                            Icons.calendar_today_outlined,
                                            size: 18,
                                            color: isDark
                                                ? AppColors.darkTextSecondary
                                                : AppColors.textSecondary,
                                          ),
                                        ),
                                        onTap: () async {
                                          await showDatePicker(
                                            context: context,
                                            initialDate: DateTime(2000),
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime.now(),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ),
                          _buildLabel('Email'),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: 'your@email.com',
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildLabel('Password'),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: '••••••••',
                            ),
                          ),
                          if (_isLogin) ...[
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Forgot password?',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _submit,
                              child: Text(
                                _isLogin ? 'Log In' : 'Create Account',
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: isDark
                                      ? AppColors.darkTextSecondary.withValues(
                                          alpha: 0.3,
                                        )
                                      : AppColors.textSecondary.withValues(
                                          alpha: 0.3,
                                        ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  'Or continue with',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    color: isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: isDark
                                      ? AppColors.darkTextSecondary.withValues(
                                          alpha: 0.3,
                                        )
                                      : AppColors.textSecondary.withValues(
                                          alpha: 0.3,
                                        ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: _submit,
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    side: BorderSide(
                                      color: isDark
                                          ? AppColors.darkTextSecondary
                                                .withValues(alpha: 0.3)
                                          : AppColors.textSecondary.withValues(
                                              alpha: 0.3,
                                            ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'G',
                                        style: GoogleFonts.dmSans(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: isDark
                                              ? AppColors.darkTextPrimary
                                              : AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Google',
                                        style: GoogleFonts.dmSans(
                                          fontSize: 14,
                                          color: isDark
                                              ? AppColors.darkTextPrimary
                                              : AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: _submit,
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    side: BorderSide(
                                      color: isDark
                                          ? AppColors.darkTextSecondary
                                                .withValues(alpha: 0.3)
                                          : AppColors.textSecondary.withValues(
                                              alpha: 0.3,
                                            ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.apple,
                                        size: 20,
                                        color: isDark
                                            ? AppColors.darkTextPrimary
                                            : AppColors.textPrimary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Apple',
                                        style: GoogleFonts.dmSans(
                                          fontSize: 14,
                                          color: isDark
                                              ? AppColors.darkTextPrimary
                                              : AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      text,
      style: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
      ),
    );
  }
}
