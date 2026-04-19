import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class MeditateScreen extends StatefulWidget {
  const MeditateScreen({super.key});

  @override
  State<MeditateScreen> createState() => _MeditateScreenState();
}

class _MeditateScreenState extends State<MeditateScreen> {
  String _selectedFilter = 'All';
  final _searchController = TextEditingController();
  bool _inSession = false;
  Map<String, String>? _activeMeditation;

  final List<String> _filters = ['All', 'Calm', 'Release', 'Sleep', 'Energy'];

  final List<Map<String, String>> _meditations = [
    {'name': 'Morning Grounding', 'duration': '5 min', 'tag': 'Calm'},
    {'name': 'Soft Body Scan', 'duration': '10 min', 'tag': 'Release'},
    {'name': 'Moonlit Reflection', 'duration': '15 min', 'tag': 'Sleep'},
    {'name': 'Inner Fire', 'duration': '8 min', 'tag': 'Energy'},
    {'name': 'Evening Unwind', 'duration': '12 min', 'tag': 'Calm'},
    {'name': 'Heart Opening', 'duration': '7 min', 'tag': 'Release'},
    {'name': 'Deep Rest', 'duration': '20 min', 'tag': 'Sleep'},
    {'name': 'Power Flow', 'duration': '6 min', 'tag': 'Energy'},
  ];

  List<Map<String, String>> get _filteredMeditations {
    final query = _searchController.text.toLowerCase();
    return _meditations.where((m) {
      final matchesFilter =
          _selectedFilter == 'All' || m['tag'] == _selectedFilter;
      final matchesSearch =
          query.isEmpty || m['name']!.toLowerCase().contains(query);
      return matchesFilter && matchesSearch;
    }).toList();
  }

  void _startSession(Map<String, String> meditation) {
    setState(() {
      _activeMeditation = meditation;
      _inSession = true;
    });
  }

  void _endSession() {
    setState(() {
      _inSession = false;
      _activeMeditation = null;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.backgroundLight,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _inSession && _activeMeditation != null
            ? _MeditationSession(
                key: const ValueKey('session'),
                meditation: _activeMeditation!,
                onEnd: _endSession,
              )
            : _buildLibrary(isDark),
      ),
    );
  }

  Widget _buildLibrary(bool isDark) {
    return SafeArea(
      key: const ValueKey('library'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Meditation Library',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Find your inner peace 🧘✨',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search meditations...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary,
                    ),
                    filled: true,
                    fillColor: isDark ? AppColors.darkCard : Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final filter = _filters[index];
                      final isSelected = _selectedFilter == filter;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedFilter = filter),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : (isDark ? AppColors.darkCard : Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            border: isSelected
                                ? null
                                : Border.all(
                                    color: isDark
                                        ? AppColors.darkTextSecondary
                                              .withValues(alpha: 0.3)
                                        : AppColors.textSecondary.withValues(
                                            alpha: 0.3,
                                          ),
                                  ),
                          ),
                          child: Text(
                            filter,
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : (isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.textPrimary),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredMeditations.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final med = _filteredMeditations[index];
                return _buildMeditationCard(med, isDark);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeditationCard(Map<String, String> med, bool isDark) {
    Color tagColor;
    switch (med['tag']) {
      case 'Calm':
        tagColor = const Color(0xFF4CAF50);
        break;
      case 'Release':
        tagColor = const Color(0xFFFF7043);
        break;
      case 'Sleep':
        tagColor = const Color(0xFF5C6BC0);
        break;
      case 'Energy':
        tagColor = const Color(0xFFFFB300);
        break;
      default:
        tagColor = AppColors.primary;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  med['name']!,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      med['duration']!,
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: tagColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        med['tag']!,
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: tagColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 38,
            child: ElevatedButton(
              onPressed: () => _startSession(med),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Start',
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MeditationSession extends StatefulWidget {
  final Map<String, String> meditation;
  final VoidCallback onEnd;

  const _MeditationSession({
    super.key,
    required this.meditation,
    required this.onEnd,
  });

  @override
  State<_MeditationSession> createState() => _MeditationSessionState();
}

class _MeditationSessionState extends State<_MeditationSession>
    with SingleTickerProviderStateMixin {
  late int _totalSeconds;
  late int _remainingSeconds;
  bool _isPaused = false;
  Timer? _timer;
  late AnimationController _breatheController;

  final List<String> _breatheTexts = [
    'Breathe...',
    'Inhale...',
    'Exhale...',
    'Relax...',
  ];
  int _breatheIndex = 0;

  @override
  void initState() {
    super.initState();
    final durStr = widget.meditation['duration'] ?? '5 min';
    final minutes = int.tryParse(durStr.replaceAll(RegExp(r'[^0-9]'), '')) ?? 5;
    _totalSeconds = minutes * 60;
    _remainingSeconds = _totalSeconds;

    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && _remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
          if (_remainingSeconds % 4 == 0) {
            _breatheIndex = (_breatheIndex + 1) % _breatheTexts.length;
          }
        });
      }
      if (_remainingSeconds <= 0) {
        timer.cancel();
        widget.onEnd();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _breatheController.dispose();
    super.dispose();
  }

  String get _formattedTime {
    final m = (_remainingSeconds ~/ 60).toString().padLeft(1, '0');
    final s = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  double get _progress =>
      _totalSeconds > 0 ? 1 - (_remainingSeconds / _totalSeconds) : 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF8B0000), Color(0xFFA52A2A), Color(0xFF8B0000)],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Close button
            Positioned(
              top: 12,
              right: 16,
              child: GestureDetector(
                onTap: widget.onEnd,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ),
            ),
            // Main content
            Column(
              children: [
                const Spacer(flex: 2),
                // Title
                Text(
                  widget.meditation['name'] ?? 'Meditation',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                // Circular timer
                AnimatedBuilder(
                  animation: _breatheController,
                  builder: (context, child) {
                    final scale = 1.0 + (_breatheController.value * 0.05);
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.1),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _formattedTime,
                            style: GoogleFonts.dmSans(
                              fontSize: 48,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _breatheTexts[_breatheIndex],
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Progress bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _progress,
                      minHeight: 4,
                      backgroundColor: Colors.white.withValues(alpha: 0.15),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 1),
                // Pause/Resume button
                GestureDetector(
                  onTap: () {
                    setState(() => _isPaused = !_isPaused);
                    if (_isPaused) {
                      _breatheController.stop();
                    } else {
                      _breatheController.repeat(reverse: true);
                    }
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isPaused ? Icons.play_arrow : Icons.pause,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // End Session button
                SizedBox(
                  width: 180,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: widget.onEnd,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'End Session',
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
