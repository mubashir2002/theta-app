import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';

class HoroscopeScreen extends StatefulWidget {
  final Function(int)? onTabTap;
  const HoroscopeScreen({super.key, this.onTabTap});

  @override
  State<HoroscopeScreen> createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends State<HoroscopeScreen>
    with SingleTickerProviderStateMixin {
  String? _selectedSign;
  String? _selectedMood;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  final List<Map<String, dynamic>> _signs = [
    {
      'name': 'Aries',
      'symbol': '♈',
      'color': Color(0xFFE57373),
      'dates': 'Mar 21 - Apr 19',
    },
    {
      'name': 'Taurus',
      'symbol': '♉',
      'color': Color(0xFFFF8A65),
      'dates': 'Apr 20 - May 20',
    },
    {
      'name': 'Gemini',
      'symbol': '♊',
      'color': Color(0xFFFFD54F),
      'dates': 'May 21 - Jun 20',
    },
    {
      'name': 'Cancer',
      'symbol': '♋',
      'color': Color(0xFFFFB74D),
      'dates': 'Jun 21 - Jul 22',
    },
    {
      'name': 'Leo',
      'symbol': '♌',
      'color': Color(0xFFFFCA28),
      'dates': 'Jul 23 - Aug 22',
    },
    {
      'name': 'Virgo',
      'symbol': '♍',
      'color': Color(0xFF9575CD),
      'dates': 'Aug 23 - Sep 22',
    },
    {
      'name': 'Libra',
      'symbol': '♎',
      'color': Color(0xFF64B5F6),
      'dates': 'Sep 23 - Oct 22',
    },
    {
      'name': 'Scorpio',
      'symbol': '♏',
      'color': Color(0xFFCE93D8),
      'dates': 'Oct 23 - Nov 21',
    },
    {
      'name': 'Sagittarius',
      'symbol': '♐',
      'color': Color(0xFF4DB6AC),
      'dates': 'Nov 22 - Dec 21',
    },
    {
      'name': 'Capricorn',
      'symbol': '♑',
      'color': Color(0xFF81C784),
      'dates': 'Dec 22 - Jan 19',
    },
    {
      'name': 'Aquarius',
      'symbol': '♒',
      'color': Color(0xFF4FC3F7),
      'dates': 'Jan 20 - Feb 18',
    },
    {
      'name': 'Pisces',
      'symbol': '♓',
      'color': Color(0xFFF48FB1),
      'dates': 'Feb 19 - Mar 20',
    },
  ];

  final List<Map<String, String>> _moods = [
    {'emoji': '😌', 'label': 'Peaceful'},
    {'emoji': '💪', 'label': 'Empowered'},
    {'emoji': '🌸', 'label': 'Romantic'},
    {'emoji': '✨', 'label': 'Magical'},
    {'emoji': '🔥', 'label': 'Energized'},
    {'emoji': '🌊', 'label': 'Calm'},
  ];

  final Map<String, Map<String, dynamic>> _readings = {
    'Aries': {
      'reading':
          'Your bold energy is amplified today. The universe supports your ambitions — take that leap of faith you\'ve been contemplating.',
      'love':
          'Passion runs high today. Express your feelings boldly. If single, an exciting encounter may spark unexpected chemistry.',
      'career':
          'Leadership opportunities arise. Trust your instincts and take charge of that project. Your confidence inspires others.',
      'wellness':
          'Channel your fiery energy into physical activity. A vigorous workout will help you feel centered and powerful.',
      'luckyNumber': '9',
      'luckyColor': 'Crimson Red',
    },
    'Taurus': {
      'reading':
          'Stability surrounds you today. Ground yourself in the simple pleasures and let your patient nature guide important decisions.',
      'love':
          'Deepen your bonds through quality time. A heartfelt conversation strengthens your closest relationship.',
      'career':
          'Financial insights come naturally today. Trust your practical instincts when evaluating new opportunities.',
      'wellness':
          'Indulge in sensory pleasures — a warm bath, good food, or time in nature will restore your energy.',
      'luckyNumber': '6',
      'luckyColor': 'Emerald Green',
    },
    'Gemini': {
      'reading':
          'Your mind is buzzing with brilliant ideas. Communication flows easily — share your thoughts and watch magic unfold.',
      'love':
          'Witty conversations lead to deeper connections. Your charm is irresistible today — use it wisely.',
      'career':
          'Networking brings unexpected opportunities. A casual conversation could lead to your next big breakthrough.',
      'wellness':
          'Feed your curious mind with a new book or podcast. Mental stimulation is your best medicine today.',
      'luckyNumber': '5',
      'luckyColor': 'Electric Yellow',
    },
    'Cancer': {
      'reading':
          'Your intuition is exceptionally strong today. Trust your gut feelings — they\'re guiding you toward emotional breakthroughs.',
      'love':
          'Nurture your loved ones with your caring energy. A home-cooked meal or surprise gesture will deepen bonds.',
      'career':
          'Your empathetic nature shines at work. Colleagues seek your advice — your wisdom is valued more than you know.',
      'wellness':
          'Create a cozy sanctuary for yourself. Self-nurturing activities like cooking or crafting bring deep comfort.',
      'luckyNumber': '2',
      'luckyColor': 'Pearl White',
    },
    'Leo': {
      'reading':
          'Today brings a beautiful opportunity for self-reflection and inner growth. The moon\'s position encourages you to trust your intuition.',
      'love':
          'Romance is in the air. If you\'re in a relationship, communicate openly. Single? A meaningful connection may be closer than you think.',
      'career':
          'Your creativity shines today. Don\'t be afraid to share your innovative ideas with colleagues. Recognition is on the horizon.',
      'wellness':
          'Focus on grounding practices. A walk in nature or meditation will help balance your energy.',
      'luckyNumber': '7',
      'luckyColor': 'Rose Gold',
    },
    'Virgo': {
      'reading':
          'Details matter today. Your analytical mind sees what others miss — use this superpower to solve a lingering problem.',
      'love':
          'Show love through acts of service. Small, thoughtful gestures speak louder than grand romantic displays.',
      'career':
          'Organization and precision lead to success. A well-structured plan impresses higher-ups today.',
      'wellness':
          'A structured routine brings comfort. Try meal prepping or organizing your space for mental clarity.',
      'luckyNumber': '3',
      'luckyColor': 'Forest Green',
    },
    'Libra': {
      'reading':
          'Balance is your superpower today. Harmony flows naturally when you trust your diplomatic instincts.',
      'love':
          'Partnership energy is strong. Find beauty in compromise and celebrate what makes your relationships unique.',
      'career':
          'Collaboration yields the best results today. Your ability to see all sides makes you an invaluable team player.',
      'wellness':
          'Surround yourself with beauty and art. Visit a gallery, rearrange your space, or treat yourself to something lovely.',
      'luckyNumber': '4',
      'luckyColor': 'Blush Pink',
    },
    'Scorpio': {
      'reading':
          'Transformation is calling. Embrace the changes happening within — they\'re leading you to a more powerful version of yourself.',
      'love':
          'Deep emotional connections intensify. Vulnerability is your strength today — let someone see the real you.',
      'career':
          'Your investigative skills uncover hidden opportunities. Dig deeper into that project — gold awaits.',
      'wellness':
          'Release what no longer serves you. A detox ritual or journaling session helps clear stagnant energy.',
      'luckyNumber': '8',
      'luckyColor': 'Deep Burgundy',
    },
    'Sagittarius': {
      'reading':
          'Adventure beckons! Your optimistic spirit attracts exciting possibilities. Say yes to spontaneity today.',
      'love':
          'Share your dreams with your partner or crush. Your enthusiasm is contagious and deeply attractive.',
      'career':
          'Think big and aim high. Your visionary ideas have the potential to create significant impact.',
      'wellness':
          'Explore something new — a hiking trail, a cuisine, or a philosophy. Growth happens outside your comfort zone.',
      'luckyNumber': '1',
      'luckyColor': 'Royal Purple',
    },
    'Capricorn': {
      'reading':
          'Your disciplined nature pays off today. Steady progress on long-term goals brings a deep sense of achievement.',
      'love':
          'Commitment and loyalty strengthen your bonds. Show up authentically and your relationships flourish.',
      'career':
          'Hard work is recognized. A milestone or achievement draws positive attention from those who matter.',
      'wellness':
          'Structured self-care works best for you. Set a bedtime routine or schedule regular wellness check-ins.',
      'luckyNumber': '10',
      'luckyColor': 'Charcoal Grey',
    },
    'Aquarius': {
      'reading':
          'Your innovative thinking reshapes possibilities today. The world needs your unique perspective — share it fearlessly.',
      'love':
          'Intellectual connections deepen. Bond over shared ideals and future dreams with someone special.',
      'career':
          'Technology and innovation are your allies. A futuristic idea or unconventional approach gains traction.',
      'wellness':
          'Connect with your community. Group activities or volunteering nourish your humanitarian spirit.',
      'luckyNumber': '11',
      'luckyColor': 'Electric Blue',
    },
    'Pisces': {
      'reading':
          'Your creative and spiritual energies are heightened. Dreams may hold important messages — pay attention to symbols.',
      'love':
          'Compassion and empathy create deep romantic moments. Writing a love poem or heartfelt note touches someone\'s soul.',
      'career':
          'Trust your creative instincts. An artistic or imaginative approach to work problems yields beautiful solutions.',
      'wellness':
          'Water-based activities bring healing. A swim, long bath, or simply listening to ocean sounds restores your spirit.',
      'luckyNumber': '12',
      'luckyColor': 'Ocean Teal',
    },
  };

  final List<String> _quotes = [
    '"The stars align for those who align with themselves."',
    '"Trust the magic of new beginnings."',
    '"You are made of stardust and endless possibilities."',
    '"The universe whispers to those who listen."',
    '"Your energy introduces you before you speak."',
    '"Shine your light — the galaxy needs your glow."',
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _selectSign(String sign) {
    setState(() => _selectedSign = sign);
    _animController.reset();
    _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final today = DateFormat('EEEE, MMMM d').format(DateTime.now());

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.backgroundLight,
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
          currentIndex: 0,
          onTap: (index) {
            Navigator.pop(context);
            if (index != 0) {
              widget.onTabTap?.call(index);
            }
          },
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [AppColors.darkBackground, AppColors.darkBackground]
                : [const Color(0xFFFCE4EC), AppColors.backgroundLight],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  'Daily Horoscope ✨',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  today,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),

                // Select your sign
                Text(
                  'Select your sign',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                _buildSignGrid(isDark),
                const SizedBox(height: 24),

                // Select your mood
                Text(
                  'Select your mood',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                _buildMoodSelector(isDark),

                // Reading Card
                if (_selectedSign != null) ...[
                  const SizedBox(height: 24),
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.1),
                        end: Offset.zero,
                      ).animate(_fadeAnim),
                      child: _buildReadingCard(isDark),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: _buildQuoteBanner(isDark),
                  ),
                ],

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignGrid(bool isDark) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.85,
      ),
      itemCount: _signs.length,
      itemBuilder: (context, index) {
        final sign = _signs[index];
        final isSelected = _selectedSign == sign['name'];
        return GestureDetector(
          onTap: () => _selectSign(sign['name'] as String),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (sign['color'] as Color).withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      sign['symbol'] as String,
                      style: TextStyle(
                        fontSize: 20,
                        color: sign['color'] as Color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  sign['name'] as String,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? AppColors.primary
                        : (isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.textPrimary),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMoodSelector(bool isDark) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _moods.map((mood) {
        final isSelected = _selectedMood == mood['label'];
        return GestureDetector(
          onTap: () => setState(() => _selectedMood = mood['label']),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: (MediaQuery.of(context).size.width - 60) / 4,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(mood['emoji']!, style: const TextStyle(fontSize: 26)),
                const SizedBox(height: 4),
                Text(
                  mood['label']!,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? AppColors.primary
                        : (isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.textPrimary),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildReadingCard(bool isDark) {
    final sign = _signs.firstWhere((s) => s['name'] == _selectedSign);
    final reading = _readings[_selectedSign]!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accentPink.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sign header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedSign!,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      sign['dates'] as String,
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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: (sign['color'] as Color).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    sign['symbol'] as String,
                    style: TextStyle(
                      fontSize: 28,
                      color: sign['color'] as Color,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Today's Reading
          Row(
            children: [
              const Text('☆', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Text(
                "Today's Reading",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            reading['reading'] as String,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          // Love & Relationships
          _buildReadingSection(
            '❤️',
            'Love & Relationships',
            reading['love'] as String,
            isDark,
          ),
          const SizedBox(height: 16),

          // Career & Finance
          _buildReadingSection(
            '💼',
            'Career & Finance',
            reading['career'] as String,
            isDark,
          ),
          const SizedBox(height: 16),

          // Wellness
          _buildReadingSection(
            '✨',
            'Wellness',
            reading['wellness'] as String,
            isDark,
          ),

          const SizedBox(height: 20),
          Divider(
            color: isDark
                ? AppColors.darkTextSecondary.withValues(alpha: 0.2)
                : AppColors.textSecondary.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 12),

          // Lucky Number, Color, Mood
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Lucky Number',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      reading['luckyNumber'] as String,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Lucky Color',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      reading['luckyColor'] as String,
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              if (_selectedMood != null)
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Your Mood',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _moods.firstWhere(
                          (m) => m['label'] == _selectedMood,
                        )['emoji']!,
                        style: const TextStyle(fontSize: 22),
                      ),
                      Text(
                        _selectedMood!,
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReadingSection(
    String icon,
    String title,
    String text,
    bool isDark,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.accentPink.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(icon, style: const TextStyle(fontSize: 14)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                text,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuoteBanner(bool isDark) {
    final quoteIndex =
        _signs.indexWhere((s) => s['name'] == _selectedSign) % _quotes.length;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B0000), Color(0xFFA52A2A)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text('🌙', style: TextStyle(fontSize: 28)),
          const SizedBox(height: 10),
          Text(
            _quotes[quoteIndex],
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
