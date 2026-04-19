import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> with TickerProviderStateMixin {
  String? _selectedMood;
  bool _boardGenerated = false;
  int _boardVariant = 0;
  int _savedBoardsCount = 7;

  late AnimationController _cardAnimController;
  late Animation<double> _cardFadeAnim;
  late Animation<Offset> _cardSlideAnim;

  late AnimationController _boardAnimController;
  late Animation<double> _boardFadeAnim;

  final List<Map<String, String>> _moods = [
    {'emoji': '😌', 'label': 'Peaceful'},
    {'emoji': '💪', 'label': 'Empowered'},
    {'emoji': '🌸', 'label': 'Romantic'},
    {'emoji': '✨', 'label': 'Magical'},
    {'emoji': '🔥', 'label': 'Energized'},
    {'emoji': '🌊', 'label': 'Calm'},
  ];

  final Map<String, Map<String, dynamic>> _moodData = {
    'Peaceful': {
      'title': 'Peaceful Energy',
      'emoji': '😌',
      'subtitle': 'Cultivate inner tranquility and harmony',
      'quote': 'I am calm, centered, and at peace with myself.',
      'benefits': ['Reduced stress', 'Better sleep', 'Mental clarity'],
      'activities': ['Meditation', 'Nature walks', 'Deep breathing'],
    },
    'Empowered': {
      'title': 'Empowered Energy',
      'emoji': '💪',
      'subtitle': 'Harness your inner strength and confidence',
      'quote': 'I am strong, capable, and ready to conquer anything.',
      'benefits': [
        'Increased confidence',
        'Better decision-making',
        'Self-belief',
      ],
      'activities': ['Goal setting', 'Affirmations', 'Power poses'],
    },
    'Romantic': {
      'title': 'Romantic Energy',
      'emoji': '🌸',
      'subtitle': 'Open your heart to love and beauty',
      'quote': 'Love flows through me and touches everything I do.',
      'benefits': ['Heart opening', 'Deeper connections', 'Self-love'],
      'activities': ['Love letter', 'Rose bath', 'Partner meditation'],
    },
    'Magical': {
      'title': 'Magical Energy',
      'emoji': '✨',
      'subtitle': 'Tap into your mystical, creative power',
      'quote': 'Magic is believing in yourself — anything is possible.',
      'benefits': ['Creative flow', 'Intuition boost', 'Inspiration'],
      'activities': ['Tarot pull', 'Moon gazing', 'Creative art'],
    },
    'Energized': {
      'title': 'Energized Energy',
      'emoji': '🔥',
      'subtitle': 'Channel your vibrant, passionate fire',
      'quote': 'Energy flows where intention goes.',
      'benefits': ['High motivation', 'Physical vitality', 'Enthusiasm'],
      'activities': ['Dance workout', 'Cold shower', 'Power walk'],
    },
    'Calm': {
      'title': 'Calm Energy',
      'emoji': '🌊',
      'subtitle': 'Flow with gentle, soothing waves',
      'quote': 'In the midst of chaos, keep stillness inside of you.',
      'benefits': ['Emotional balance', 'Patience', 'Groundedness'],
      'activities': ['Yoga', 'Tea ceremony', 'Journaling'],
    },
  };

  // Board images data — different visual sets per mood
  final Map<String, List<List<Map<String, dynamic>>>> _boardImages = {
    'Peaceful': [
      [
        {
          'gradient': [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
          'emoji': '🌿',
          'text': 'Forest Serenity',
        },
        {
          'gradient': [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
          'emoji': '💧',
          'text': 'Still Waters',
        },
        {
          'gradient': [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
          'emoji': '🪷',
          'text': 'Lotus Garden',
        },
        {
          'gradient': [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
          'emoji': '🌅',
          'text': 'Golden Hour',
        },
      ],
      [
        {
          'gradient': [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
          'emoji': '🌙',
          'text': 'Moonlit Path',
        },
        {
          'gradient': [Color(0xFFF1F8E9), Color(0xFFDCEDC8)],
          'emoji': '🍃',
          'text': 'Gentle Breeze',
        },
        {
          'gradient': [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
          'emoji': '☁️',
          'text': 'Cloud Drift',
        },
        {
          'gradient': [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
          'emoji': '🌸',
          'text': 'Cherry Bloom',
        },
      ],
      [
        {
          'gradient': [Color(0xFFF9FBE7), Color(0xFFF0F4C3)],
          'emoji': '🦋',
          'text': 'Butterfly Meadow',
        },
        {
          'gradient': [Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
          'emoji': '🐢',
          'text': 'Slow Living',
        },
        {
          'gradient': [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
          'emoji': '🕯️',
          'text': 'Candle Glow',
        },
        {
          'gradient': [Color(0xFFEDE7F6), Color(0xFFD1C4E9)],
          'emoji': '✨',
          'text': 'Starlit Peace',
        },
      ],
    ],
    'Empowered': [
      [
        {
          'gradient': [Color(0xFFFCE4EC), Color(0xFFEF9A9A)],
          'emoji': '🦁',
          'text': 'Inner Lion',
        },
        {
          'gradient': [Color(0xFFFFF3E0), Color(0xFFFFCC80)],
          'emoji': '⚡',
          'text': 'Lightning Power',
        },
        {
          'gradient': [Color(0xFFE8EAF6), Color(0xFF9FA8DA)],
          'emoji': '🏔️',
          'text': 'Mountain Top',
        },
        {
          'gradient': [Color(0xFFE0F2F1), Color(0xFF80CBC4)],
          'emoji': '💎',
          'text': 'Diamond Will',
        },
      ],
      [
        {
          'gradient': [Color(0xFFF3E5F5), Color(0xFFCE93D8)],
          'emoji': '👑',
          'text': 'Crown Energy',
        },
        {
          'gradient': [Color(0xFFE8F5E9), Color(0xFFA5D6A7)],
          'emoji': '🌱',
          'text': 'Growth Mindset',
        },
        {
          'gradient': [Color(0xFFFFF8E1), Color(0xFFFFD54F)],
          'emoji': '🔥',
          'text': 'Fierce Focus',
        },
        {
          'gradient': [Color(0xFFE3F2FD), Color(0xFF90CAF9)],
          'emoji': '🚀',
          'text': 'Launch Pad',
        },
      ],
      [
        {
          'gradient': [Color(0xFFFFEBEE), Color(0xFFEF5350)],
          'emoji': '❤️‍🔥',
          'text': 'Burning Heart',
        },
        {
          'gradient': [Color(0xFFFFF9C4), Color(0xFFFFEB3B)],
          'emoji': '☀️',
          'text': 'Solar Power',
        },
        {
          'gradient': [Color(0xFFE1F5FE), Color(0xFF81D4FA)],
          'emoji': '🌊',
          'text': 'Wave Rider',
        },
        {
          'gradient': [Color(0xFFF1F8E9), Color(0xFF66BB6A)],
          'emoji': '🗻',
          'text': 'Peak State',
        },
      ],
    ],
    'Romantic': [
      [
        {
          'gradient': [Color(0xFFFCE4EC), Color(0xFFF48FB1)],
          'emoji': '🌹',
          'text': 'Rose Garden',
        },
        {
          'gradient': [Color(0xFFF3E5F5), Color(0xFFCE93D8)],
          'emoji': '💜',
          'text': 'Purple Love',
        },
        {
          'gradient': [Color(0xFFFFF3E0), Color(0xFFFFCC80)],
          'emoji': '🕯️',
          'text': 'Candlelit Eve',
        },
        {
          'gradient': [Color(0xFFE8EAF6), Color(0xFF9FA8DA)],
          'emoji': '💌',
          'text': 'Love Note',
        },
      ],
      [
        {
          'gradient': [Color(0xFFFFEBEE), Color(0xFFE57373)],
          'emoji': '💕',
          'text': 'Heart Strings',
        },
        {
          'gradient': [Color(0xFFF9FBE7), Color(0xFFE6EE9C)],
          'emoji': '🌻',
          'text': 'Sunflower',
        },
        {
          'gradient': [Color(0xFFE0F7FA), Color(0xFF80DEEA)],
          'emoji': '🐚',
          'text': 'Ocean Kiss',
        },
        {
          'gradient': [Color(0xFFFFF8E1), Color(0xFFFFE082)],
          'emoji': '⭐',
          'text': 'Star Crossed',
        },
      ],
    ],
    'Magical': [
      [
        {
          'gradient': [Color(0xFFEDE7F6), Color(0xFFB39DDB)],
          'emoji': '🔮',
          'text': 'Crystal Ball',
        },
        {
          'gradient': [Color(0xFFE8EAF6), Color(0xFF7986CB)],
          'emoji': '🌌',
          'text': 'Galaxy Portal',
        },
        {
          'gradient': [Color(0xFFFCE4EC), Color(0xFFF48FB1)],
          'emoji': '🦄',
          'text': 'Unicorn Dream',
        },
        {
          'gradient': [Color(0xFFFFF8E1), Color(0xFFFFD54F)],
          'emoji': '⭐',
          'text': 'Stardust',
        },
      ],
      [
        {
          'gradient': [Color(0xFFE1F5FE), Color(0xFF4FC3F7)],
          'emoji': '🪄',
          'text': 'Magic Wand',
        },
        {
          'gradient': [Color(0xFFF3E5F5), Color(0xFFAB47BC)],
          'emoji': '🌙',
          'text': 'Moonspell',
        },
        {
          'gradient': [Color(0xFFE8F5E9), Color(0xFF81C784)],
          'emoji': '🍀',
          'text': 'Lucky Charm',
        },
        {
          'gradient': [Color(0xFFFFEBEE), Color(0xFFEF9A9A)],
          'emoji': '🎀',
          'text': 'Fairy Wish',
        },
      ],
    ],
    'Energized': [
      [
        {
          'gradient': [Color(0xFFFFF3E0), Color(0xFFFF9800)],
          'emoji': '⚡',
          'text': 'Thunder Bolt',
        },
        {
          'gradient': [Color(0xFFFFEBEE), Color(0xFFE53935)],
          'emoji': '🔥',
          'text': 'Flame On',
        },
        {
          'gradient': [Color(0xFFFFF9C4), Color(0xFFFDD835)],
          'emoji': '💥',
          'text': 'Power Burst',
        },
        {
          'gradient': [Color(0xFFE8F5E9), Color(0xFF43A047)],
          'emoji': '🏃',
          'text': 'Full Sprint',
        },
      ],
      [
        {
          'gradient': [Color(0xFFE3F2FD), Color(0xFF42A5F5)],
          'emoji': '🌪️',
          'text': 'Tornado Force',
        },
        {
          'gradient': [Color(0xFFF3E5F5), Color(0xFFAB47BC)],
          'emoji': '🎆',
          'text': 'Fireworks',
        },
        {
          'gradient': [Color(0xFFE0F2F1), Color(0xFF26A69A)],
          'emoji': '🐆',
          'text': 'Cheetah Speed',
        },
        {
          'gradient': [Color(0xFFFFF8E1), Color(0xFFFFB300)],
          'emoji': '🌟',
          'text': 'Super Nova',
        },
      ],
      [
        {
          'gradient': [Color(0xFFFFCDD2), Color(0xFFE57373)],
          'emoji': '🎯',
          'text': 'Bulls Eye',
        },
        {
          'gradient': [Color(0xFFC8E6C9), Color(0xFF66BB6A)],
          'emoji': '🌿',
          'text': 'Wild Energy',
        },
        {
          'gradient': [Color(0xFFBBDEFB), Color(0xFF64B5F6)],
          'emoji': '🏋️',
          'text': 'Iron Will',
        },
        {
          'gradient': [Color(0xFFFFE0B2), Color(0xFFFFB74D)],
          'emoji': '☀️',
          'text': 'Solar Flare',
        },
      ],
    ],
    'Calm': [
      [
        {
          'gradient': [Color(0xFFE0F7FA), Color(0xFF80DEEA)],
          'emoji': '🌊',
          'text': 'Ocean Calm',
        },
        {
          'gradient': [Color(0xFFE8F5E9), Color(0xFFA5D6A7)],
          'emoji': '🍵',
          'text': 'Tea Ritual',
        },
        {
          'gradient': [Color(0xFFE3F2FD), Color(0xFF90CAF9)],
          'emoji': '☁️',
          'text': 'Cloud Nine',
        },
        {
          'gradient': [Color(0xFFF3E5F5), Color(0xFFCE93D8)],
          'emoji': '🪻',
          'text': 'Lavender Field',
        },
      ],
      [
        {
          'gradient': [Color(0xFFFFF8E1), Color(0xFFFFE082)],
          'emoji': '🌻',
          'text': 'Sunny Calm',
        },
        {
          'gradient': [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
          'emoji': '🫧',
          'text': 'Bubble Float',
        },
        {
          'gradient': [Color(0xFFF1F8E9), Color(0xFFC5E1A5)],
          'emoji': '🌾',
          'text': 'Wheat Field',
        },
        {
          'gradient': [Color(0xFFE0F2F1), Color(0xFF80CBC4)],
          'emoji': '🐋',
          'text': 'Deep Blue',
        },
      ],
    ],
  };

  @override
  void initState() {
    super.initState();
    _cardAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _cardFadeAnim = CurvedAnimation(
      parent: _cardAnimController,
      curve: Curves.easeInOut,
    );
    _cardSlideAnim =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _cardAnimController, curve: Curves.easeOut),
        );

    _boardAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _boardFadeAnim = CurvedAnimation(
      parent: _boardAnimController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _cardAnimController.dispose();
    _boardAnimController.dispose();
    super.dispose();
  }

  void _generateBoard() {
    setState(() {
      _boardGenerated = true;
      _boardVariant = 0;
    });
    _cardAnimController.reset();
    _cardAnimController.forward();
    _boardAnimController.reset();
    _boardAnimController.forward();
  }

  void _refreshBoard() {
    final images = _boardImages[_selectedMood];
    if (images == null) return;
    _boardAnimController.reverse().then((_) {
      setState(() {
        _boardVariant = (_boardVariant + 1) % images.length;
      });
      _boardAnimController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AI Mood Board ✦',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Generate visual inspiration for your current vibe ✨',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),

              // Mood Selector Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'How are you feeling?',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                          ),
                        ),
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.textSecondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.1,
                      children: _moods.map((mood) {
                        final isSelected = _selectedMood == mood['label'];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMood = mood['label'];
                              _boardGenerated = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkBackground
                                  : AppColors.backgroundCard,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  mood['emoji']!,
                                  style: const TextStyle(fontSize: 28),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  mood['label']!,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _selectedMood != null
                            ? _generateBoard
                            : null,
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: AppColors.primary.withValues(
                            alpha: 0.3,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.auto_awesome, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Generate Mood Board',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Mood Detail Card (animated)
              if (_boardGenerated && _selectedMood != null) ...[
                FadeTransition(
                  opacity: _cardFadeAnim,
                  child: SlideTransition(
                    position: _cardSlideAnim,
                    child: _buildMoodDetail(isDark),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Bottom Stats (Saved Boards & Journal It)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.history,
                            size: 22,
                            color: AppColors.primary,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Saved Boards',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$_savedBoardsCount',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'View history',
                            style: GoogleFonts.dmSans(
                              fontSize: 11,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.menu_book,
                            size: 22,
                            color: AppColors.primary,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Journal It',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Reflect on your mood and save insights to your journal',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                              fontSize: 11,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Board Section with images
              if (_boardGenerated && _selectedMood != null) ...[
                FadeTransition(
                  opacity: _cardFadeAnim,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your $_selectedMood Board',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.textPrimary,
                            ),
                          ),
                          GestureDetector(
                            onTap: _refreshBoard,
                            child: AnimatedRotation(
                              turns: _boardVariant * 0.5,
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                Icons.refresh,
                                size: 22,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Board Image Grid
                      FadeTransition(
                        opacity: _boardFadeAnim,
                        child: _buildBoardImageGrid(isDark),
                      ),
                      const SizedBox(height: 16),
                      // Save Collection Banner
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.accentPink.withValues(alpha: 0.3),
                              AppColors.backgroundCard,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Love your mood board? Save it to your collection!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            OutlinedButton(
                              onPressed: () {
                                setState(() => _savedBoardsCount++);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Board saved to your collection!',
                                      style: GoogleFonts.dmSans(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor: AppColors.primary,
                                  ),
                                );
                              },
                              child: Text(
                                'Save Collection',
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBoardImageGrid(bool isDark) {
    final images = _boardImages[_selectedMood];
    if (images == null || images.isEmpty) return const SizedBox.shrink();

    final currentSet = images[_boardVariant % images.length];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: currentSet.length,
      itemBuilder: (context, index) {
        final item = currentSet[index];
        final gradientColors = item['gradient'] as List<Color>;

        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 300 + (index * 100)),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: 0.8 + (0.2 * value),
              child: Opacity(opacity: value, child: child),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? gradientColors
                          .map((c) => Color.lerp(c, AppColors.darkCard, 0.5)!)
                          .toList()
                    : gradientColors,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: gradientColors.last.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item['emoji'] as String,
                  style: const TextStyle(fontSize: 36),
                ),
                const SizedBox(height: 8),
                Text(
                  item['text'] as String,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMoodDetail(bool isDark) {
    final data = _moodData[_selectedMood]!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accentPink.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                data['emoji'] as String,
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'] as String,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      data['subtitle'] as String,
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkBackground
                  : AppColors.backgroundCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "'${data['quote'] as String}'",
              style: GoogleFonts.playfairDisplay(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkBackground.withValues(alpha: 0.5)
                  : const Color(0xFFFFF8F0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('📈', style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 4),
                          Text(
                            'Benefits',
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ...(data['benefits'] as List<String>).map(
                        (b) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  b,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    color: isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('✦', style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 4),
                          Text(
                            'Try',
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ...(data['activities'] as List<String>).map(
                        (a) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  a,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    color: isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
