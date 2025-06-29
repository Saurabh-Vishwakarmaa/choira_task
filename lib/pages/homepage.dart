import 'package:choira/constants/newcolor.dart';
import 'package:choira/pages/quizpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorr.lightcolor ?? const Color(0xFF1A1A2E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top section with profile
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello,',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            color: Colorr.textcolor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Learner!',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            color: Colorr.textcolor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                Icons.grid_3x3,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 30),
                
                Text(
                  'Challenge your',
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colorr.textcolor,
                  ),
                ),
                Text(
                  'knowledge',
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colorr.textcolor,
                  ),
                ),
                
                SizedBox(height: 10),
                
                Text(
                  'find out who you are ↓',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                
                SizedBox(height: 40),
                
                // Challenge options grid
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.flash_on,
                              color: Colors.black,
                              size: 30,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Rookie',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        height: 120,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: Colorr.textcolor,
                              size: 30,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Pro',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colorr.textcolor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 15),
                
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 120,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.whatshot,
                              color: Colorr.textcolor,
                              size: 30,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Expert',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colorr.textcolor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        height: 120,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.military_tech,
                              color: Colorr.textcolor,
                              size: 30,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Master',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colorr.textcolor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 50),
                
                // Button  section
                GestureDetector(
                  onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => QuizPage()));
                  
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                     color: Colorr.textcolor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff000000).withOpacity(0.3),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Quiz',
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Begin your journey',
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: Colors.white70,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}