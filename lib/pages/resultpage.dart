import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:choira/constants/newcolor.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultPage({
    Key? key,
    required this.score,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percentage = (score / totalQuestions) * 100;
    String grade = _getGrade(percentage);
    String message = _getMessage(percentage);
    Color gradeColor = _getGradeColor(percentage);

    return Scaffold(
      backgroundColor: Colorr.backgroundcolor ?? const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.share, color: Colors.white, size: 20),
                  ),
                ],
              ),

              SizedBox(height: 40),

              // Result Card
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Trophy/Medal Icon
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          percentage >= 80 ? Icons.emoji_events : 
                          percentage >= 60 ? Icons.military_tech : Icons.thumb_up,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),

                      SizedBox(height: 30),

                      Text(
                        'Quiz Completed!',
                        style: GoogleFonts.outfit(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        message,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 40),

                      // Score Display
                      Container(
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Your Score',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '$score',
                                  style: GoogleFonts.outfit(
                                    fontSize: 48,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '/$totalQuestions',
                                  style: GoogleFonts.outfit(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${percentage.toStringAsFixed(1)}%',
                              style: GoogleFonts.outfit(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30),

                      // Grade
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: gradeColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: gradeColor, width: 2),
                        ),
                        child: Text(
                          'Grade: $grade',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: Container(
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'Home',
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // Restart quiz logic here
                      },
                      child: Container(
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'Try Again',
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getGrade(double percentage) {
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B';
    if (percentage >= 60) return 'C';
    if (percentage >= 50) return 'D';
    return 'F';
  }

  String _getMessage(double percentage) {
    if (percentage >= 90) return 'Outstanding performance! You\'re a music theory expert!';
    if (percentage >= 80) return 'Great job! You have a solid understanding of music theory.';
    if (percentage >= 70) return 'Good work! Keep practicing to improve further.';
    if (percentage >= 60) return 'Not bad! There\'s room for improvement.';
    return 'Keep studying! Practice makes perfect.';
  }

  Color _getGradeColor(double percentage) {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.orange;
    return Colors.red;
  }
}