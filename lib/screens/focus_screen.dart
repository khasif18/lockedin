import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';

/// Focus timer session with mood-based duration and session type selection.
class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _MoodData {
  const _MoodData({
    required this.label,
    required this.emoji,
    required this.minutes,
    required this.message,
  });

  final String label;
  final String emoji;
  final int minutes;
  final String message;

  String get chipTitle => '$label $emoji';

  int get seconds => minutes * 60;
}

class _FocusScreenState extends State<FocusScreen> {
  static const Color _cyan = Color(0xFF00D4FF);
  static const Color _onCyan = AppColors.primaryBgDark;

  static const List<_MoodData> _moods = [
    _MoodData(
      label: 'Energized',
      emoji: '⚡',
      minutes: 45,
      message: "You're on fire! Make it count. 🔥",
    ),
    _MoodData(
      label: 'Focused',
      emoji: '🎯',
      minutes: 25,
      message: 'Deep work mode. Eliminate distractions. 🎯',
    ),
    _MoodData(
      label: 'Tired',
      emoji: '😴',
      minutes: 15,
      message: 'Small steps still move you forward. 💪',
    ),
    _MoodData(
      label: 'Stressed',
      emoji: '😤',
      minutes: 30,
      message: 'Breathe. One task at a time. 🧘',
    ),
  ];

  static const List<String> _sessionTypes = [
    'Deep Focus',
    'Light Focus',
    'Quick Sprint',
  ];

  int _moodIndex = 0;
  int _sessionTypeIndex = 0;
  int _totalSeconds = _moods[0].seconds;
  int _remainingSeconds = _moods[0].seconds;
  bool _isRunning = false;
  Timer? _timer;

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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _applyMoodDuration() {
    final s = _moods[_moodIndex].seconds;
    _totalSeconds = s;
    _remainingSeconds = s;
  }

  void _onMoodSelected(int index) {
    if (index == _moodIndex) return;
    setState(() {
      _timer?.cancel();
      _timer = null;
      _isRunning = false;
      _moodIndex = index;
      _applyMoodDuration();
    });
  }

  void _onSessionTypeSelected(int index) {
    setState(() => _sessionTypeIndex = index);
  }

  void _toggleTimer() {
    if (_remainingSeconds <= 0) {
      _applyMoodDuration();
    }
    if (_isRunning) {
      _timer?.cancel();
      _timer = null;
      setState(() => _isRunning = false);
      return;
    }
    setState(() => _isRunning = true);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer t) {
    if (_remainingSeconds <= 1) {
      t.cancel();
      _timer = null;
      if (!mounted) return;
      setState(() {
        _remainingSeconds = 0;
        _isRunning = false;
      });
      _showCompletionDialog();
      return;
    }
    setState(() => _remainingSeconds--);
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _isRunning = false;
      _applyMoodDuration();
    });
  }

  Future<void> _showCompletionDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: _card,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: _border),
          ),
          title: Text(
            'Session Complete! 🎉',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: _textPrimary,
            ),
          ),
          content: Text(
            'Great job! You completed your focus session.',
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: _textSecondary,
              height: 1.4,
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (mounted) Navigator.of(context).pop();
              },
              style: FilledButton.styleFrom(
                backgroundColor: _cyan,
                foregroundColor: _onCyan,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Done',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: _onCyan,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatMmSs(int totalSecs) {
    final m = totalSecs ~/ 60;
    final s = totalSecs % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final mood = _moods[_moodIndex];
    final progress =
        _totalSeconds > 0 ? _remainingSeconds / _totalSeconds : 0.0;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: _cyan, size: 20),
          onPressed: () {
            _timer?.cancel();
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Focus Session',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'How do you feel?',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _textSecondary,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(_moods.length, (i) {
                  final selected = i == _moodIndex;
                  return ChoiceChip(
                    label: Text(_moods[i].chipTitle),
                    selected: selected,
                    onSelected: (_) => _onMoodSelected(i),
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: selected ? _onCyan : _textPrimary,
                    ),
                    selectedColor: _cyan,
                    backgroundColor: _card,
                    side: BorderSide(
                      color: selected ? _cyan : _border,
                      width: 1,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 22),
              Text(
                'Session type',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _textSecondary,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 96,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _sessionTypes.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, i) {
                    final selected = i == _sessionTypeIndex;
                    return GestureDetector(
                      onTap: () => _onSessionTypeSelected(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 132,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _card,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: selected ? _cyan : _border,
                            width: selected ? 2 : 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _sessionTypes[i],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _textPrimary,
                              height: 1.25,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),
              Center(
                child: SizedBox(
                  width: 280,
                  height: 280,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: progress.clamp(0.0, 1.0),
                          strokeWidth: 10,
                          backgroundColor: _border.withValues(alpha: 0.45),
                          color: _cyan,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _formatMmSs(_remainingSeconds),
                            style: GoogleFonts.poppins(
                              fontSize: 48,
                              fontWeight: FontWeight.w700,
                              color: _textPrimary,
                              letterSpacing: -1,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'remaining',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: _textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: FilledButton(
                      onPressed: _toggleTimer,
                      style: FilledButton.styleFrom(
                        backgroundColor: _cyan,
                        foregroundColor: _onCyan,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _isRunning ? 'Pause' : 'Start',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _onCyan,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: OutlinedButton(
                      onPressed: _resetTimer,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _cyan,
                        side: BorderSide(color: _cyan.withValues(alpha: 0.85)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Reset',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: _cyan,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                mood.message,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _textSecondary,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
