import 'package:choira/models/questionmodel.dart';
import 'package:choira/pages/resultpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:choira/constants/newcolor.dart';

import '../data/questionbank.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  List<int> selectedAnswers = [];
  double score = 0.0; // Changed to double for partial scoring
  List<MultipleChoiceQuestion> quizQuestions = [];
  bool showFeedback = false;
  String feedbackType = ''; // 'correct', 'partial', 'incorrect'
  ScrollController _scrollController = ScrollController();
  GlobalKey _feedbackKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    quizQuestions = MusicQuestionBank.questions;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToFeedback() {
    if (showFeedback && _feedbackKey.currentContext != null) {
      Future.delayed(Duration(milliseconds: 300), () {
        Scrollable.ensureVisible(
          _feedbackKey.currentContext!,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  // Enhanced scoring logic
  double _calculateScore(List<int> userAnswers, List<int> correctAnswers, bool allowMultiple) {
    if (userAnswers.isEmpty) return 0.0;
    
    if (!allowMultiple) {
      // Single choice: either fully correct or wrong
      return userAnswers.length == 1 && correctAnswers.contains(userAnswers.first) ? 1.0 : 0.0;
    }
    
    // Multiple choice: calculate partial scoring
    Set<int> userSet = userAnswers.toSet();
    Set<int> correctSet = correctAnswers.toSet();
    
    // Calculate intersection and union for partial scoring
    Set<int> intersection = userSet.intersection(correctSet);
    Set<int> wrongSelections = userSet.difference(correctSet);
    Set<int> missedCorrect = correctSet.difference(userSet);
    
    if (intersection.isEmpty) {
      return 0.0; // No correct answers selected
    }
    
    if (wrongSelections.isEmpty && missedCorrect.isEmpty) {
      return 1.0; // Perfect answer
    }
    
    // Partial scoring formula: (correct selections - wrong selections) / total correct
    // With minimum of 0 and penalty for wrong selections
    double partialScore = (intersection.length - (wrongSelections.length * 0.5)) / correctSet.length;
    return partialScore.clamp(0.0, 1.0);
  }

  String _getFeedbackType(double scorePercent, bool allowMultiple) {
    if (!allowMultiple) {
      return scorePercent == 1.0 ? 'correct' : 'incorrect';
    }
    
    if (scorePercent == 1.0) return 'correct';
    if (scorePercent > 0.0) return 'partial';
    return 'incorrect';
  }

  @override
  Widget build(BuildContext context) {
    if (quizQuestions.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final question = quizQuestions[currentQuestionIndex];
    
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A), // Deep black background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Compact Header with back button and progress
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Question ${currentQuestionIndex + 1} of ${quizQuestions.length}',
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${((currentQuestionIndex + 1) / quizQuestions.length * 100).toInt()}%',
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                color: Colorr.lightcolor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Container(
                          width: double.infinity,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (currentQuestionIndex + 1) / quizQuestions.length,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colorr.lightcolor, Color(0xFF44A08D)],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 25),
              
              // Subject and Question Number
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Music Theory',
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colorr.lightcolor,
                    ),
                  ),
                  Text(
                    '#${currentQuestionIndex + 1}',
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colorr.lightcolor,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 30),
              
              // Scrollable Content (Question + Options + Feedback)
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      // Question Banner (Dark with border)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white, // Changed from Color(0xFF1A1A1A)
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xFF2A2A2A),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question.questionText,
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black, // Changed from Colors.white
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: question.allowMultipleSelection 
                                    ? Colorr.lightcolor.withOpacity(0.2)
                                    : Colors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: question.allowMultipleSelection 
                                      ? Colorr.lightcolor
                                      : Colors.orange,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                question.allowMultipleSelection 
                                    ? 'Select all that apply (Partial credit available)' 
                                    : 'Select one answer',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color: question.allowMultipleSelection 
                                      ? Colorr.lightcolor
                                      : Colors.orange,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 30),
                      
                      // Answer Options
                      ...List.generate(question.options.length, (index) {
                        String option = question.options[index];
                        bool isSelected = selectedAnswers.contains(index);
                        bool isCorrect = question.correctAnswerIndexes.contains(index);
                        
                        Color containerColor;
                        Color textColor;
                        Color borderColor = Colors.transparent;
                        
                        if (showFeedback) {
                          if (isCorrect && isSelected) {
                            // Correctly selected
                            containerColor = Color(0xFF22C55E); // Green
                            textColor = Colors.white;
                            borderColor = Color(0xFF16A34A);
                          } else if (isCorrect && !isSelected) {
                            // Missed correct answer
                            containerColor = Color(0xFF22C55E).withOpacity(0.3);
                            textColor = Colors.white;
                            borderColor = Color(0xFF22C55E);
                          } else if (!isCorrect && isSelected) {
                            // Wrongly selected
                            containerColor = Color(0xFFEF4444); // Red
                            textColor = Colors.white;
                            borderColor = Color(0xFFDC2626);
                          } else {
                            // Not selected and not correct
                            containerColor = Color(0xFF1A1A1A);
                            textColor = Colors.white60;
                            borderColor = Color(0xFF2A2A2A);
                          }
                        } else {
                          if (isSelected) {
                            containerColor = Colorr.lightcolor;
                            textColor = Color(0xFF0A0A0A);
                            borderColor = Color(0xFF44A08D);
                          } else {
                            containerColor = Colors.white; // Changed from Color(0xFF1A1A1A)
                            textColor = Colors.black; // Changed from Colors.white
                            borderColor = Color(0xFF2A2A2A);
                          }
                        }
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: GestureDetector(
                            onTap: showFeedback ? null : () {
                              setState(() {
                                if (question.allowMultipleSelection) {
                                  if (isSelected) {
                                    selectedAnswers.remove(index);
                                  } else {
                                    selectedAnswers.add(index);
                                  }
                                } else {
                                  selectedAnswers = [index];
                                }
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: borderColor, width: 1),
                              ),
                              child: Row(
                                children: [
                                  // Radio/Checkbox button indicator
                                  Container(
                                    width: 24,
                                    height: 24,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      shape: question.allowMultipleSelection 
                                          ? BoxShape.rectangle 
                                          : BoxShape.circle,
                                      borderRadius: question.allowMultipleSelection 
                                          ? BorderRadius.circular(6) 
                                          : null,
                                      border: Border.all(
                                        color: showFeedback 
                                            ? (isCorrect ? Colors.white : Colors.white54)
                                            : (isSelected ? Color(0xFF0A0A0A) : Colors.grey),
                                        width: 2,
                                      ),
                                      color: showFeedback 
                                          ? (isCorrect && isSelected ? Colors.white : Colors.transparent)
                                          : (isSelected ? Color(0xFF0A0A0A) : Colors.transparent),
                                    ),
                                    child: showFeedback && isCorrect
                                        ? Icon(
                                            question.allowMultipleSelection ? Icons.check : Icons.circle,
                                            color: Color(0xFF22C55E), 
                                            size: 16
                                          )
                                        : (isSelected && !showFeedback 
                                            ? Icon(
                                                question.allowMultipleSelection ? Icons.check : Icons.circle,
                                                color: Colorr.lightcolor, 
                                                size: 16
                                              )
                                            : null),
                                  ),
                                  Expanded(
                                    child: Text(
                                      option,
                                      style: GoogleFonts.outfit(
                                        fontSize: 16,
                                        color: textColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  // Show indicators for feedback
                                  if (showFeedback) ...[
                                    if (isCorrect && isSelected)
                                      Icon(Icons.check_circle, color: Colors.white, size: 20),
                                    if (isCorrect && !isSelected)
                                      Icon(Icons.info_outline, color: Colors.white, size: 20),
                                    if (!isCorrect && isSelected)
                                      Icon(Icons.cancel, color: Colors.white, size: 20),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      
                      // Enhanced Feedback Message
                      if (showFeedback)
                        Container(
                          key: _feedbackKey,
                          width: double.infinity,
                          padding: EdgeInsets.all(25),
                          margin: EdgeInsets.only(top: 10, bottom: 20),
                          decoration: BoxDecoration(
                            color: feedbackType == 'correct' ? Color(0xFF22C55E) : 
                                   feedbackType == 'partial' ? Color(0xFF3B82F6) : Color(0xFFEF4444),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: feedbackType == 'correct' ? Color(0xFF16A34A) : 
                                     feedbackType == 'partial' ? Color(0xFF2563EB) : Color(0xFFDC2626),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      feedbackType == 'correct' ? Icons.check : 
                                      feedbackType == 'partial' ? Icons.star_half : Icons.close,
                                      color: feedbackType == 'correct' ? Color(0xFF22C55E) : 
                                             feedbackType == 'partial' ? Color(0xFF3B82F6) : Color(0xFFEF4444),
                                      size: 16,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          feedbackType == 'correct' ? 'Excellent!' : 
                                          feedbackType == 'partial' ? 'Partially Correct!' : 'Incorrect',
                                          style: GoogleFonts.outfit(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${(_calculateScore(selectedAnswers, question.correctAnswerIndexes, question.allowMultipleSelection) * 100).toInt()}% points earned',
                                          style: GoogleFonts.outfit(
                                            fontSize: 12,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Text(
                                _getFeedbackMessage(feedbackType, question),
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  color: Colors.white,
                                  height: 1.4,
                                ),
                              ),
                              if (feedbackType != 'correct') ...[
                                SizedBox(height: 15),
                                Text(
                                  'Complete correct answers:',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8),
                                ...question.correctAnswerIndexes.map((i) => 
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Icon(Icons.check_circle, color: Colors.white, size: 16),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            question.options[i],
                                            style: GoogleFonts.outfit(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ).toList(),
                              ],
                            ],
                          ),
                        ),
                      
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
              
              // Action Button (Fixed at bottom)
              GestureDetector(
                onTap: selectedAnswers.isNotEmpty ? (showFeedback ? _nextQuestion : _checkAnswer) : null,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: selectedAnswers.isNotEmpty 
                        ? LinearGradient(
                            colors: [Colorr.lightcolor,Colorr.lightcolor],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          )
                        : null,
                    color: selectedAnswers.isEmpty ? Color(0xFF2A2A2A) : null,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: selectedAnswers.isNotEmpty ? [
                      BoxShadow(
                        color: Colorr.lightcolor.withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 8),
                      ),
                    ] : null,
                  ),
                  child: Center(
                    child: Text(
                      showFeedback 
                          ? (currentQuestionIndex == quizQuestions.length - 1 ? 'View Results' : 'Next Question')
                          : 'Check The Answer',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _getFeedbackMessage(String type, MultipleChoiceQuestion question) {
    switch (type) {
      case 'correct':
        return 'Perfect! You got all the answers right. Keep up the excellent work!';
      case 'partial':
        return 'Good job! You got some answers right. ${question.allowMultipleSelection ? "In multiple choice questions, you earn partial credit for correct selections." : ""}';
      case 'incorrect':
        return 'Don\'t worry, learning is a process. Review the correct answers below and try again!';
      default:
        return '';
    }
  }

  void _checkAnswer() {
    final question = quizQuestions[currentQuestionIndex];
    double scoreEarned = _calculateScore(selectedAnswers, question.correctAnswerIndexes, question.allowMultipleSelection);
    String type = _getFeedbackType(scoreEarned, question.allowMultipleSelection);
    
    setState(() {
      showFeedback = true;
      feedbackType = type;
    });
    
    score += scoreEarned;
    
    // auto-scroll to feedback with proper timing
    Future.delayed(Duration(milliseconds: 100), () {
      if (_feedbackKey.currentContext != null) {
        Scrollable.ensureVisible(
          _feedbackKey.currentContext!,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
          alignment: 0.2, // Shows feedback near top of visible area
        );
      }
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < quizQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswers = [];
        showFeedback = false;
        feedbackType = '';
      });
      
      // Scroll back to top for new question
      _scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to results page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            score: score, 
            totalQuestions: quizQuestions.length,
          ),
        ),
      );
    }
  }
}