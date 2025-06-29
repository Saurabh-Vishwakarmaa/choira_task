import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:choira/constants/newcolor.dart';

class ResultPage extends StatelessWidget {
  final double score; // Changed from int to double to handle partial scoring
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
    String performanceLevel = _getPerformanceLevel(percentage);

    return Scaffold(
      backgroundColor: Colorr.lightcolor ?? const Color(0xFF1A1A2E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back button
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                // Welcome message like homepage
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quiz Completed!',
                      style: GoogleFonts.outfit(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: Colorr.textcolor?.withOpacity(0.7) ?? Colors.white70,
                      ),
                    ),
                    Text(
                      performanceLevel,
                      style: GoogleFonts.outfit(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colorr.textcolor ?? Colors.white,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),

                // Score Card (like homepage cards)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Trophy Icon
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: gradeColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          percentage >= 80 ? Icons.emoji_events : 
                          percentage >= 60 ? Icons.military_tech : Icons.thumb_up,
                          color: gradeColor,
                          size: 40,
                        ),
                      ),

                      SizedBox(height: 20),

                      // Score Display with decimal handling
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            score % 1 == 0 ? '${score.toInt()}' : '${score.toStringAsFixed(1)}',
                            style: GoogleFonts.outfit(
                              fontSize: 48,
                              fontWeight: FontWeight.w700,
                              color: Colorr.textcolor ?? Colors.black,
                            ),
                          ),
                          Text(
                            '/$totalQuestions',
                            style: GoogleFonts.outfit(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Colorr.textcolor?.withOpacity(0.6) ?? Colors.black54,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      Text(
                        '${percentage.toStringAsFixed(1)}% Score',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colorr.textcolor?.withOpacity(0.7) ?? Colors.black87,
                        ),
                      ),

                      SizedBox(height: 20),

                      // Grade Badge
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: gradeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: gradeColor, width: 1),
                        ),
                        child: Text(
                          'Grade: $grade',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: gradeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // Performance Details Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFF4ECDC4).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.analytics,
                              color: Color(0xFF4ECDC4),
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Detailed Results',
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colorr.textcolor ?? Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      
                      // Scoring breakdown
                      _buildScoreBreakdown(),
                      
                      SizedBox(height: 15),
                      Text(
                        message,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Colorr.textcolor?.withOpacity(0.7) ?? Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // Subject Performance (like homepage categories)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subject: Music Theory',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colorr.textcolor ?? Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: percentage / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: gradeColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${percentage.toInt()}%',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: gradeColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),

                // Action Buttons (like homepage button style)
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Back to Home',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colorr.textcolor ?? Colors.black,
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
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colorr.textcolor ?? Colors.black,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 15,
                                offset: Offset(0, 8),
                              ),
                            ],
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

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreBreakdown() {
    int fullPoints = score.floor();
    double partialPoints = score - fullPoints;
    int totalIncorrect = totalQuestions - score.ceil();
    
    return Column(
      children: [
        if (fullPoints > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF22C55E), size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Fully Correct',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colorr.textcolor ?? Colors.black,
                    ),
                  ),
                ],
              ),
              Text(
                '$fullPoints questions',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF22C55E),
                ),
              ),
            ],
          ),
        
        if (partialPoints > 0) ...[
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.star_half, color: Color(0xFF3B82F6), size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Partially Correct',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colorr.textcolor ?? Colors.black,
                    ),
                  ),
                ],
              ),
              Text(
                '${(partialPoints * 100).toInt()}% of 1 question',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3B82F6),
                ),
              ),
            ],
          ),
        ],
        
        if (totalIncorrect > 0) ...[
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.cancel, color: Color(0xFFEF4444), size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Incorrect',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colorr.textcolor ?? Colors.black,
                    ),
                  ),
                ],
              ),
              Text(
                '$totalIncorrect questions',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFEF4444),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  String _getPerformanceLevel(double percentage) {
    if (percentage >= 90) return 'Excellent! 🏆';
    if (percentage >= 80) return 'Great Job! 🎉';
    if (percentage >= 70) return 'Good Work! 👍';
    if (percentage >= 60) return 'Keep Going! 💪';
    return 'Keep Learning! 📚';
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
    if (percentage >= 90) return 'Outstanding performance! You\'re a music theory expert! You answered questions with great precision and understanding.';
    if (percentage >= 80) return 'Great job! You have a solid understanding of music theory. Your answers show good knowledge of the concepts.';
    if (percentage >= 70) return 'Good work! You\'re on the right track. Some partial credit earned shows you\'re learning the material well.';
    if (percentage >= 60) return 'Not bad! There\'s room for improvement. Focus on reviewing concepts where you earned partial credit.';
    return 'Keep studying! Practice makes perfect. Review the basics and take advantage of partial credit opportunities in multiple choice questions.';
  }

  Color _getGradeColor(double percentage) {
    if (percentage >= 80) return Color(0xFF22C55E); // Green
    if (percentage >= 60) return Color(0xFFF59E0B); // Orange  
    return Color(0xFFEF4444); // Red
  }
}