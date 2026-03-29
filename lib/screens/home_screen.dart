import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';
import 'focus_screen.dart';

/// LockedIn home — premium dashboard with quote, streak, stats, and goals.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<({String text, String author})> _quotes = [
    (
      text: 'The secret of getting ahead is getting started.',
      author: 'Mark Twain',
    ),
    (
      text: 'Focus is deciding what you are not going to do.',
      author: 'John Carmack',
    ),
    (
      text: 'Discipline is choosing between what you want now and what you want most.',
      author: 'Abraham Lincoln',
    ),
    (
      text: 'Small steps every day lead to big results.',
      author: 'Anonymous',
    ),
    (
      text: 'Deep work is the ability to focus without distraction on a demanding task.',
      author: 'Cal Newport',
    ),
    (
      text: 'You do not have to be great to start, but you have to start to be great.',
      author: 'Zig Ziglar',
    ),
    (
      text: 'The future depends on what you do today.',
      author: 'Mahatma Gandhi',
    ),
    (
      text: 'Stay hungry, stay foolish.',
      author: 'Steve Jobs',
    ),
    (
      text: 'One day or day one. You decide.',
      author: 'Unknown',
    ),
    (
      text: 'Progress, not perfection.',
      author: 'Anonymous',
    ),
  ];

  late int _quoteIndex;
  final List<bool> _goalDone = [false, true, false];

  static const Color _cyan = Color(0xFF00D4FF);
  static const int _streakDays = 3;

  @override
  void initState() {
    super.initState();
    _quoteIndex = Random().nextInt(_quotes.length);
  }

  void _refreshQuote() {
    setState(() {
      var next = Random().nextInt(_quotes.length);
      if (_quotes.length > 1) {
        while (next == _quoteIndex) {
          next = Random().nextInt(_quotes.length);
        }
      }
      _quoteIndex = next;
    });
  }

  bool get _isDark => Theme.of(context).brightness == Brightness.dark;

  Color get _bg =>
      _isDark ? AppColors.primaryBgDark : AppColors.primaryBgLight;

  Color get _card =>
      _isDark ? AppColors.cardSurfaceDark : AppColors.cardSurfaceLight;

  Color get _border =>
      _isDark ? AppColors.borderColorDark : AppColors.borderColorLight;

  Color get _textPrimary =>
      _isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

  Color get _textSecondary =>
      _isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

  static const Color _onCyanText = AppColors.primaryBgDark;

  @override
  Widget build(BuildContext context) {
    final quote = _quotes[_quoteIndex];

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _GreetingBar(
                greeting: 'Good Morning, Khasif 👋',
                cyan: _cyan,
                textPrimary: _textPrimary,
              ),
              const SizedBox(height: 22),
              _QuoteCard(
                quote: quote.text,
                author: quote.author,
                card: _card,
                border: _border,
                cyan: _cyan,
                textPrimary: _textPrimary,
                onRefresh: _refreshQuote,
              ),
              const SizedBox(height: 26),
              _StreakSection(
                streak: _streakDays,
                cyan: _cyan,
                textSecondary: _textSecondary,
              ),
              const SizedBox(height: 22),
              _QuickStatsRow(
                card: _card,
                border: _border,
                cyan: _cyan,
                textPrimary: _textPrimary,
                textSecondary: _textSecondary,
              ),
              const SizedBox(height: 28),
              Text(
                "Today's Goals",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 14),
              _GoalsList(
                card: _card,
                border: _border,
                cyan: _cyan,
                textPrimary: _textPrimary,
                textSecondary: _textSecondary,
                goalDone: _goalDone,
                onToggle: (i) {
                  setState(() => _goalDone[i] = !_goalDone[i]);
                },
              ),
              const SizedBox(height: 28),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const FocusScreen(),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: _cyan,
                  foregroundColor: _onCyanText,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Start Focus Session',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _onCyanText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GreetingBar extends StatelessWidget {
  const _GreetingBar({
    required this.greeting,
    required this.cyan,
    required this.textPrimary,
  });

  final String greeting;
  final Color cyan;
  final Color textPrimary;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            greeting,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: textPrimary,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: cyan.withValues(alpha: 0.45), width: 1.5),
            color: cyan.withValues(alpha: 0.12),
          ),
          alignment: Alignment.center,
          child: Text(
            'KK',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: cyan,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({
    required this.quote,
    required this.author,
    required this.card,
    required this.border,
    required this.cyan,
    required this.textPrimary,
    required this.onRefresh,
  });

  final String quote;
  final String author;
  final Color card;
  final Color border;
  final Color cyan;
  final Color textPrimary;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 12, 18),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '"$quote"',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: textPrimary,
                    height: 1.45,
                  ),
                ),
              ),
              IconButton(
                onPressed: onRefresh,
                icon: Icon(Icons.refresh_rounded, color: cyan, size: 22),
                tooltip: 'New quote',
                style: IconButton.styleFrom(
                  foregroundColor: cyan,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '— $author',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: cyan,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _StreakSection extends StatelessWidget {
  const _StreakSection({
    required this.streak,
    required this.cyan,
    required this.textSecondary,
  });

  final int streak;
  final Color cyan;
  final Color textSecondary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$streak',
              style: GoogleFonts.poppins(
                fontSize: 56,
                fontWeight: FontWeight.w800,
                color: cyan,
                height: 1,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(width: 6),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                '🔥',
                style: TextStyle(fontSize: 36),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'day streak',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textSecondary,
          ),
        ),
      ],
    );
  }
}

class _QuickStatsRow extends StatelessWidget {
  const _QuickStatsRow({
    required this.card,
    required this.border,
    required this.cyan,
    required this.textPrimary,
    required this.textSecondary,
  });

  final Color card;
  final Color border;
  final Color cyan;
  final Color textPrimary;
  final Color textSecondary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.schedule_rounded,
            value: '2.5h',
            label: 'Focus Hours',
            card: card,
            border: border,
            cyan: cyan,
            textPrimary: textPrimary,
            textSecondary: textSecondary,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _StatCard(
            icon: Icons.task_alt_rounded,
            value: '4/6',
            label: 'Tasks Done',
            card: card,
            border: border,
            cyan: cyan,
            textPrimary: textPrimary,
            textSecondary: textSecondary,
            valueFontSize: 22,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.card,
    required this.border,
    required this.cyan,
    required this.textPrimary,
    required this.textSecondary,
    this.valueFontSize = 26,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color card;
  final Color border;
  final Color cyan;
  final Color textPrimary;
  final Color textSecondary;
  final double valueFontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: cyan, size: 26),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: valueFontSize,
              fontWeight: FontWeight.w700,
              color: textPrimary,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalsList extends StatelessWidget {
  const _GoalsList({
    required this.card,
    required this.border,
    required this.cyan,
    required this.textPrimary,
    required this.textSecondary,
    required this.goalDone,
    required this.onToggle,
  });

  final Color card;
  final Color border;
  final Color cyan;
  final Color textPrimary;
  final Color textSecondary;
  final List<bool> goalDone;
  final void Function(int index) onToggle;

  static const List<String> _titles = [
    'Finish project proposal draft',
    'Review notes for 25 minutes',
    'Plan tomorrow’s top three tasks',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Column(
        children: List.generate(_titles.length, (i) {
          final done = goalDone[i];
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onToggle(i),
              borderRadius: BorderRadius.vertical(
                top: i == 0 ? const Radius.circular(16) : Radius.zero,
                bottom: i == _titles.length - 1
                    ? const Radius.circular(16)
                    : Radius.zero,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Checkbox(
                        value: done,
                        onChanged: (_) => onToggle(i),
                        activeColor: cyan,
                        checkColor: AppColors.primaryBgDark,
                        side: BorderSide(color: border, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _titles[i],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: done ? textSecondary : textPrimary,
                          decoration: done ? TextDecoration.lineThrough : null,
                          decorationColor: textSecondary,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
