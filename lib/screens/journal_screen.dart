import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final _journalController = TextEditingController();
  final _freeWriteController = TextEditingController();
  final _gratitudeController = TextEditingController();
  final _bestMomentController = TextEditingController();
  final _challengeController = TextEditingController();
  final _goalController = TextEditingController();
  final _todoInputController = TextEditingController();

  bool _showFreeWriting = false;
  bool _showDailySummary = false;
  bool _showTodoList = false;
  bool _showProgress = false;
  bool _showBrowsePrompts = false;
  int _selectedPromptIndex = 0;

  final List<String> _prompts = [
    'What fills your cup today?',
    'Describe a moment that made you smile this week.',
    'What are you grateful for right now?',
    'Write a love letter to your future self.',
    'What boundaries do you need to set?',
    'Name three things that bring you peace.',
    'What would you do if you weren\'t afraid?',
    'How can you be kinder to yourself today?',
    'What lesson did today teach you?',
    'Describe your ideal day in vivid detail.',
  ];

  final List<Map<String, String>> _pastEntries = [
    {
      'date': 'Sun, Mar 22',
      'prompt': '"What fills your cup today?"',
      'preview':
          'Today I\'m filled with gratitude for the quiet morning moments with my coffee. The way the light streams through the window, the...',
    },
    {
      'date': 'Sat, Mar 21',
      'prompt': '"What are you grateful for right now?"',
      'preview':
          'I\'m grateful for my health, for the ability to move my body and nourish it well. For the people who love me unconditionally...',
    },
  ];

  final List<Map<String, dynamic>> _todos = [
    {'text': 'Morning meditation', 'done': true},
    {'text': 'Journal entry', 'done': false},
    {'text': 'Evening reflection', 'done': false},
  ];

  void _savePromptEntry() {
    if (_journalController.text.trim().isEmpty) return;
    setState(() {
      _pastEntries.insert(0, {
        'date': DateFormat('EEE, MMM d').format(DateTime.now()),
        'prompt': '"What fills your cup today?"',
        'preview': _journalController.text.trim(),
      });
      _journalController.clear();
    });
  }

  void _saveFreeWriteEntry() {
    if (_freeWriteController.text.trim().isEmpty) return;
    setState(() {
      _pastEntries.insert(0, {
        'date': DateFormat('EEE, MMM d').format(DateTime.now()),
        'prompt': 'Free Writing',
        'preview': _freeWriteController.text.trim(),
      });
      _freeWriteController.clear();
      _showFreeWriting = false;
    });
  }

  void _saveDailySummary() {
    final parts = <String>[];
    if (_gratitudeController.text.trim().isNotEmpty) {
      parts.add('Grateful for: ${_gratitudeController.text.trim()}');
    }
    if (_bestMomentController.text.trim().isNotEmpty) {
      parts.add('Best moment: ${_bestMomentController.text.trim()}');
    }
    if (_challengeController.text.trim().isNotEmpty) {
      parts.add('Challenge: ${_challengeController.text.trim()}');
    }
    if (_goalController.text.trim().isNotEmpty) {
      parts.add('Tomorrow\'s goal: ${_goalController.text.trim()}');
    }
    if (parts.isEmpty) return;
    setState(() {
      _pastEntries.insert(0, {
        'date': DateFormat('EEE, MMM d').format(DateTime.now()),
        'prompt': 'Daily Summary',
        'preview': parts.join('. '),
      });
      _gratitudeController.clear();
      _bestMomentController.clear();
      _challengeController.clear();
      _goalController.clear();
      _showDailySummary = false;
    });
  }

  void _addTodo() {
    if (_todoInputController.text.trim().isEmpty) return;
    setState(() {
      _todos.add({'text': _todoInputController.text.trim(), 'done': false});
      _todoInputController.clear();
    });
  }

  @override
  void dispose() {
    _journalController.dispose();
    _freeWriteController.dispose();
    _gratitudeController.dispose();
    _bestMomentController.dispose();
    _challengeController.dispose();
    _goalController.dispose();
    _todoInputController.dispose();
    super.dispose();
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
                'Journal 📖',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Your sacred space for reflection and growth ✨',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),

              // Writing options
              Row(
                children: [
                  Expanded(
                    child: _buildWritingCard(
                      '✏️',
                      'Free Writing',
                      'Write whatever comes to mind',
                      [const Color(0xFFE8DEF8), const Color(0xFFF3E5F5)],
                      isDark,
                      onTap: () =>
                          setState(() => _showFreeWriting = !_showFreeWriting),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildWritingCard(
                      '☀️',
                      'Daily Summary',
                      'Reflect on your day',
                      [const Color(0xFFFFF8E1), const Color(0xFFFFF3E0)],
                      isDark,
                      onTap: () => setState(
                        () => _showDailySummary = !_showDailySummary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Today's Prompt
              _buildTodaysPrompt(isDark),
              const SizedBox(height: 16),

              // Browse Prompts Section (animated)
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _showBrowsePrompts
                    ? _buildBrowsePromptsSection(isDark)
                    : const SizedBox.shrink(),
              ),

              // Free Writing Section (animated)
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _showFreeWriting
                    ? _buildFreeWritingSection(isDark)
                    : const SizedBox.shrink(),
              ),

              // Daily Summary Section (animated)
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _showDailySummary
                    ? _buildDailySummarySection(isDark)
                    : const SizedBox.shrink(),
              ),

              const SizedBox(height: 20),

              // Todo & Progress
              Row(
                children: [
                  Expanded(
                    child: _buildWritingCard(
                      '☑️',
                      'To-Do List',
                      'Track your wellness tasks',
                      [const Color(0xFFE0F7FA), const Color(0xFFB2EBF2)],
                      isDark,
                      onTap: () =>
                          setState(() => _showTodoList = !_showTodoList),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildWritingCard(
                      '📈',
                      'My Progress',
                      'See your achievements',
                      [const Color(0xFFE8F5E9), const Color(0xFFC8E6C9)],
                      isDark,
                      onTap: () =>
                          setState(() => _showProgress = !_showProgress),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // To-Do List Section (animated)
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _showTodoList
                    ? _buildTodoListSection(isDark)
                    : const SizedBox.shrink(),
              ),

              // My Progress Section (animated)
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _showProgress
                    ? _buildProgressSection(isDark)
                    : const SizedBox.shrink(),
              ),

              const SizedBox(height: 24),

              // Past Entries
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Past Entries',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ..._pastEntries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildPastEntry(
                    entry['date']!,
                    entry['prompt']!,
                    entry['preview']!,
                    isDark,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Voltaire Quote
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accentPink.withValues(alpha: 0.3),
                      const Color(0xFFFFF0F0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      '"Writing is the painting of the voice."',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '— Voltaire',
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Today's Prompt ───
  Widget _buildTodaysPrompt(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Prompt",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDark
                          ? AppColors.darkTextSecondary.withValues(alpha: 0.3)
                          : AppColors.textSecondary.withValues(alpha: 0.3),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 14,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'New prompt',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
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
          const SizedBox(height: 16),
          Text(
            '"What fills your cup today?"',
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _journalController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Start writing...',
              filled: true,
              fillColor: isDark
                  ? AppColors.darkBackground
                  : AppColors.backgroundCard,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _savePromptEntry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.85),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'Save Entry',
                    style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                      setState(() => _showBrowsePrompts = !_showBrowsePrompts),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    'Browse Prompts',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Browse Prompts Section ───
  Widget _buildBrowsePromptsSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Prompts',
              style: GoogleFonts.playfairDisplay(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 240,
              child: ListView.builder(
                itemCount: _prompts.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedPromptIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPromptIndex = index;
                        _showBrowsePrompts = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      margin: const EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.08)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _prompts[index],
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isSelected
                                    ? AppColors.primary
                                    : (isDark
                                          ? AppColors.darkTextPrimary
                                          : AppColors.textPrimary),
                              ),
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.chevron_right,
                              size: 18,
                              color: AppColors.primary,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Free Writing Section ───
  Widget _buildFreeWritingSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Free Writing',
              style: GoogleFonts.playfairDisplay(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _freeWriteController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Start writing...',
                filled: true,
                fillColor: isDark
                    ? AppColors.darkBackground
                    : AppColors.backgroundCard,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveFreeWriteEntry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary.withValues(
                        alpha: 0.85,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Save Entry',
                      style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() => _showFreeWriting = false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.textPrimary,
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

  // ─── Daily Summary Section ───
  Widget _buildDailySummarySection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Summary',
              style: GoogleFonts.playfairDisplay(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryField(
              '❤️',
              'What are you grateful for?',
              _gratitudeController,
              isDark,
            ),
            const SizedBox(height: 12),
            _buildSummaryField(
              '✨',
              'What was the best moment?',
              _bestMomentController,
              isDark,
            ),
            const SizedBox(height: 12),
            _buildSummaryField(
              '✕',
              'What was a challenge?',
              _challengeController,
              isDark,
            ),
            const SizedBox(height: 12),
            _buildSummaryField(
              '✏️',
              'What is your goal for tomorrow?',
              _goalController,
              isDark,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveDailySummary,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary.withValues(
                        alpha: 0.85,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Save Entry',
                      style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() => _showDailySummary = false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.textPrimary,
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

  Widget _buildSummaryField(
    String icon,
    String hint,
    TextEditingController ctrl,
    bool isDark,
  ) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: ctrl,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.dmSans(
                fontSize: 14,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
              ),
              filled: false,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: isDark
                      ? AppColors.darkTextSecondary.withValues(alpha: 0.2)
                      : AppColors.textSecondary.withValues(alpha: 0.2),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: isDark
                      ? AppColors.darkTextSecondary.withValues(alpha: 0.2)
                      : AppColors.textSecondary.withValues(alpha: 0.2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ─── To-Do List Section ───
  Widget _buildTodoListSection(bool isDark) {
    final doneCount = _todos.where((t) => t['done'] == true).length;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_box, size: 20, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'To-Do List',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  '$doneCount/${_todos.length}',
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Add new task
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoInputController,
                    decoration: InputDecoration(
                      hintText: 'Add a new task...',
                      hintStyle: GoogleFonts.dmSans(fontSize: 14),
                      filled: true,
                      fillColor: isDark
                          ? AppColors.darkBackground
                          : AppColors.backgroundCard,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _addTodo,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 22),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Todo items
            ..._todos.asMap().entries.map((entry) {
              final i = entry.key;
              final todo = entry.value;
              final done = todo['done'] as bool;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() => _todos[i]['done'] = !done);
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: done ? AppColors.primary : Colors.transparent,
                          border: Border.all(
                            color: done
                                ? AppColors.primary
                                : (isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.textSecondary.withValues(
                                          alpha: 0.4,
                                        )),
                            width: 2,
                          ),
                        ),
                        child: done
                            ? const Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        todo['text'] as String,
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: done
                              ? (isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.textSecondary)
                              : (isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.textPrimary),
                          decoration: done ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() => _todos.removeAt(i));
                      },
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // ─── My Progress Section ───
  Widget _buildProgressSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Your Wellness Journey
          Container(
            padding: const EdgeInsets.all(20),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('📈', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Text(
                      'Your Wellness Journey',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Stats grid
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('📖', '24', 'Journal Entries', [
                        const Color(0xFFE8DEF8),
                        const Color(0xFFF3E5F5),
                      ], isDark),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildStatCard('🧘', '320', 'Meditation Minutes', [
                        const Color(0xFFFFF8E1),
                        const Color(0xFFFFF3E0),
                      ], isDark),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('📅', '5', 'Cycles Tracked', [
                        const Color(0xFFE0F7FA),
                        const Color(0xFFB2EBF2),
                      ], isDark),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildStatCard('🎨', '12', 'Mood Boards Created', [
                        const Color(0xFFE8F5E9),
                        const Color(0xFFC8E6C9),
                      ], isDark),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Streak banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFF0F0), Color(0xFFE8F5E9)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text('🔥', style: TextStyle(fontSize: 22)),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '5 Days',
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    'Current Streak',
                                    style: GoogleFonts.dmSans(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '12 Days',
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                'Best Streak',
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You\'ve been active for 18 days total! Keep it up! ✨',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // This Week's Activity
                Text(
                  'This Week\'s Activity',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                _buildWeeklyActivity(isDark),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Achievements
          Row(
            children: [
              const Text('🏆', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                'Achievements',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildAchievementsGrid(isDark),
          const SizedBox(height: 20),
          // Progress, not perfection card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.accentPink.withValues(alpha: 0.4),
                  AppColors.backgroundCard,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text('🎯', style: TextStyle(fontSize: 28)),
                const SizedBox(height: 8),
                Text(
                  '"Progress, not perfection"',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Every small step you take is building a stronger, more mindful you. Keep growing! 🌸',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String emoji,
    String value,
    String label,
    List<Color> colors,
    bool isDark,
  ) {
    final darkColors = colors
        .map((c) => Color.lerp(c, AppColors.darkCard, 0.7)!)
        .toList();
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark ? darkColors : colors,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 11,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyActivity(bool isDark) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final activeDay = DateTime.now().weekday; // 1=Mon .. 7=Sun
    final heights = [30.0, 20.0, 35.0, 15.0, 40.0, 10.0, 5.0];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(7, (i) {
          final isActive = i + 1 == activeDay;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 20,
                height: heights[i],
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                days[i],
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                  color: isActive
                      ? AppColors.primary
                      : (isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildAchievementsGrid(bool isDark) {
    final achievements = [
      {'emoji': '📝', 'title': 'First Journal Entry', 'date': 'Mar 15'},
      {'emoji': '🔥', 'title': '5 Day Streak', 'date': 'Mar 20'},
      {'emoji': '🧘', 'title': '10 Meditations', 'date': 'Mar 22'},
      {'emoji': '🎨', 'title': 'First Mood Board', 'date': 'Mar 18'},
      {'emoji': '📅', 'title': 'Week of Tracking', 'date': 'Mar 25'},
      {'emoji': '⭐', 'title': '10 Day Streak', 'date': 'Coming soon'},
      {'emoji': '✨', 'title': '50 Minutes\nMeditating', 'date': 'Coming soon'},
      {'emoji': '🌟', 'title': '30 Day Journey', 'date': 'Coming soon'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final a = achievements[index];
        final isLocked = a['date'] == 'Coming soon';
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isDark
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                a['emoji']!,
                style: TextStyle(
                  fontSize: 26,
                  color: isLocked ? Colors.grey : null,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                a['title']!,
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isLocked
                      ? (isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary)
                      : AppColors.primary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                a['date']!,
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ─── Reusable Widgets ───
  Widget _buildWritingCard(
    String emoji,
    String title,
    String subtitle,
    List<Color> colors,
    bool isDark, {
    VoidCallback? onTap,
  }) {
    final darkColors = colors
        .map((c) => Color.lerp(c, AppColors.darkCard, 0.7)!)
        .toList();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark ? darkColors : colors,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.playfairDisplay(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
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
    );
  }

  Widget _buildPastEntry(
    String date,
    String prompt,
    String preview,
    bool isDark,
  ) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.textSecondary,
                ),
              ),
              Icon(
                Icons.favorite_border,
                size: 20,
                color: AppColors.accentPink,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            prompt,
            style: GoogleFonts.playfairDisplay(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            preview,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.dmSans(
              fontSize: 13,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
