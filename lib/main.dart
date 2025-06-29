import 'package:choira/constants/newcolor.dart';
import 'package:choira/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizMaster',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _colorController;
  
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<Color?> _textColorAnimation;
  
  bool _showText = false;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _colorController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Color animations 
    _backgroundColorAnimation = ColorTween(
      begin: Colors.white,
      end: Colorr.lightcolor ?? const Color(0xFF1A1A2E),
    ).animate(CurvedAnimation(
      parent: _colorController,
      curve: Curves.easeInOutCubic,
    ));

    _textColorAnimation = ColorTween(
      begin: Colors.black87,
      end: Colorr.textcolor ?? Colors.white,
    ).animate(CurvedAnimation(
      parent: _colorController,
      curve: Curves.easeInOutCubic,
    ));

    // Start color transition after 0.5 seconds
    Future.delayed(const Duration(milliseconds: 500), () {
      _colorController.forward();
    });

    // Show text after 1 second
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _showText = true;
      });
    });

    // Navigate after 3 seconds
    Future.delayed(const Duration(milliseconds: 3000), () {
      _fadeController.forward().then((_) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const Homepage(),
            transitionDuration: const Duration(milliseconds: 600),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_fadeController, _colorController]),
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _backgroundColorAnimation.value ?? Colors.white,
                  (_backgroundColorAnimation.value ?? Colors.white).withOpacity(0.9),
                  (_backgroundColorAnimation.value ?? Colors.white).withOpacity(0.8),
                ],
              ),
            ),
            child: Opacity(
              opacity: 1.0 - _fadeController.value,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // center icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.lerp(
                          const Color(0xFFF8F8F8),
                          Colors.white,
                          1.0 - _colorController.value,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1 * (1.0 - _colorController.value)),
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.school,
                        color: _textColorAnimation.value,
                        size: 40,
                      ),
                    ),
                    
                    SizedBox(height: 40),
                    
                    // Text with color transition
                    AnimatedOpacity(
                      opacity: _showText ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 800),
                      child: Column(
                        children: [
                          Text(
                            'QuizMaster',
                            style: GoogleFonts.outfit(
                              fontSize: 42,
                              fontWeight: FontWeight.w700,
                              color: _textColorAnimation.value,
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Master Every Question',
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: (_textColorAnimation.value ?? Colors.black).withOpacity(0.6),
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 20),
                          // Animated accent line
                          Container(
                            width: 30 + (20 * _colorController.value),
                            height: 2 + (1 * _colorController.value),
                            decoration: BoxDecoration(
                              color: Color.lerp(
                                Colors.grey[400],
                                const Color(0xFF4ECDC4),
                                _colorController.value,
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
