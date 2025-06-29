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
  int score = 0;
  List<MultipleChoiceQuestion> quizQuestions = [];
  bool showFeedback = false;
  bool isCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    quizQuestions = MusicQuestionBank.questions;
  }

  @override
  Widget build(BuildContext context) {
    if (quizQuestions.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final question = quizQuestions[currentQuestionIndex];
    
    return Scaffold(
      backgroundColor: Colorr.textcolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button and profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
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
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                       
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.apps,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              SizedBox(height: 40),
              
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
              
              // Question Text
              Text(
                question.questionText,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
              
              SizedBox(height: 10),
              
              // Question type indicator
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: question.allowMultipleSelection 
                      ? Color(0xFF4ECDC4).withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  question.allowMultipleSelection 
                      ? 'Select all that apply' 
                      : 'Select one answer',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: question.allowMultipleSelection 
                        ? Color(0xFF4ECDC4)
                        : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              SizedBox(height: 30),
              
              // Answer Options
              Expanded(
                child: ListView.builder(
                  itemCount: question.options.length,
                  itemBuilder: (context, index) {
                    String option = question.options[index];
                    bool isSelected = selectedAnswers.contains(index);
                    bool isCorrect = question.correctAnswerIndexes.contains(index);
                    
                    Color containerColor;
                    Color textColor;
                    Color borderColor = Colors.transparent;
                    
                    if (showFeedback) {
                      if (isCorrect) {
                        containerColor = Colors.green;
                        textColor = Colors.white;
                      } else if (isSelected && !isCorrect) {
                        containerColor = Colors.red;
                        textColor = Colors.white;
                      } else {
                        containerColor = Colors.grey[850]!;
                        textColor = Colors.white60;
                      }
                    } else {
                      if (isSelected) {
                        containerColor = Colors.white;
                        textColor = Colors.black;
                      } else {
                        containerColor = Colors.grey[850]!;
                        textColor = Colors.white;
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
                                        : (isSelected ? (isSelected ? Colors.black : Colors.white) : Colors.grey),
                                    width: 2,
                                  ),
                                  color: showFeedback 
                                      ? (isCorrect ? Colors.white : Colors.transparent)
                                      : (isSelected ? Colors.black : Colors.transparent),
                                ),
                                child: showFeedback && isCorrect
                                    ? Icon(
                                        question.allowMultipleSelection ? Icons.check : Icons.circle,
                                        color: Colors.green, 
                                        size: 16
                                      )
                                    : (isSelected && !showFeedback 
                                        ? Icon(
                                            question.allowMultipleSelection ? Icons.check : Icons.circle,
                                            color: Colors.white, 
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
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Enhanced Feedback Message
              if (showFeedback)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(25),
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: isCorrectAnswer 
                        ? Colors.green.withOpacity(0.15) 
                        : Colors.red.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isCorrectAnswer ? Colors.green : Colors.red,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isCorrectAnswer ? Colors.green : Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isCorrectAnswer ? Icons.check : Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 15),
                          Text(
                            isCorrectAnswer ? 'Excellent!' : 'Incorrect',
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: isCorrectAnswer ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        isCorrectAnswer 
                            ? 'Great job! You got it right. Keep up the excellent work!'
                            : 'Don\'t worry, learning is a process. The correct answer${question.correctAnswerIndexes.length > 1 ? 's are' : ' is'}:',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Colors.white70,
                          height: 1.4,
                        ),
                      ),
                      if (!isCorrectAnswer) ...[
                        SizedBox(height: 10),
                        ...question.correctAnswerIndexes.map((i) => 
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_forward, color: Colors.green, size: 16),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    question.options[i],
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
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
              
              // Action Button
              GestureDetector(
                onTap: selectedAnswers.isNotEmpty ? (showFeedback ? _nextQuestion : _checkAnswer) : null,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: selectedAnswers.isNotEmpty 
                        ? Colorr.lightcolor
                        : Colors.grey[700],
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

  void _checkAnswer() {
    final question = quizQuestions[currentQuestionIndex];
    bool correct = question.isCorrect(selectedAnswers);
    
    setState(() {
      showFeedback = true;
      isCorrectAnswer = correct;
    });
    
    if (correct) {
      score++;
    }
  }

  void _nextQuestion() {
    if (currentQuestionIndex < quizQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswers = [];
        showFeedback = false;
        isCorrectAnswer = false;
      });
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