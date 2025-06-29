import 'package:choira/constants/newcolor.dart';
import 'package:choira/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Choira',
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
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _zoomController;
  late Animation<double> _zoomAnimation;
  bool _shouldZoom = false;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _controller1 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _controller2 = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _zoomController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    if (!_initialized) {
      _zoomAnimation = Tween<double>(
        begin: 60.0,
        end: MediaQuery.of(context).size.width * 2.5,
      ).animate(CurvedAnimation(
        parent: _zoomController,
        curve: Curves.easeInOut,
      ));

      // Start zoom animation after 2.5 seconds
      Future.delayed(const Duration(milliseconds: 2500), () {
        setState(() {
          _shouldZoom = true;
        });
        _controller1.stop();
        _controller2.stop();
        _zoomController.forward().then((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        });
      });
      
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _zoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorr.textcolor,
      body: Stack(
        children: [
          // Normal rotating balls when not zooming
          if (!_shouldZoom)
            Center(
              child: Container(
                width: 120,
                height: 120,
                child: Stack(
                  children: [
                    // First ball (Rectangle)
                    AnimatedBuilder(
                      animation: _controller1,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                            30 * math.cos(_controller1.value * 2 * math.pi),
                            30 * math.sin(_controller1.value * 2 * math.pi),
                          ),
                          child: Transform.translate(
                            offset: Offset(15, 15),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8),
                                color: Colorr.backgroundcolor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colorr.backgroundcolor.withOpacity(0.3),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Second ball (Circle)
                    AnimatedBuilder(
                      animation: _controller1,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                            30 * math.cos((_controller1.value + 0.5) * 2 * math.pi),
                            30 * math.sin((_controller1.value + 0.5) * 2 * math.pi),
                          ),
                          child: Transform.translate(
                            offset: Offset(15, 15),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.cyan,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.cyan.withOpacity(0.3),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          // Zooming rectangle that covers the whole screen with cool effect
          if (_shouldZoom)
            Center(
              child: AnimatedBuilder(
                animation: _zoomAnimation,
                builder: (context, child) {
                  return Container(
                    width: _zoomAnimation.value,
                    height: _zoomAnimation.value,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_zoomAnimation.value * 0.5),
                      color: Colorr.backgroundcolor,
                      boxShadow: [
                        BoxShadow(
                          color: Colorr.backgroundcolor.withOpacity(0.5),
                          blurRadius: _zoomAnimation.value * 0.05,
                          spreadRadius: _zoomAnimation.value * 0.02,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
