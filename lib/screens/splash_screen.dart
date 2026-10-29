
import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, animation, secondaryAnimation) {
            return const LoginPage();
          },
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF795548),
              Color(0xFF4E342E),
              Color(0xFF2E1D18),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Dekorasi lingkaran di latar belakang
              Positioned(
                top: -65,
                right: -55,
                child: _decorationCircle(210),
              ),
              Positioned(
                bottom: -80,
                left: -65,
                child: _decorationCircle(230),
              ),

              // Konten utama splash screen
              Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo aplikasi
                        Container(
                          width: 155,
                          height: 155,
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFD7B899),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 25,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/cafe.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.coffee_rounded,
                                size: 80,
                                color: Color(0xFFE8C7A7),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Nama aplikasi
                        const Text(
                          'WARUNG IS',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Tagline
                        const Text(
                          'A warm cup, a better day.',
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.8,
                            color: Color(0xFFE8C7A7),
                          ),
                        ),

                        const SizedBox(height: 38),

                        // Indikator loading
                        const SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFFE8C7A7),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        const Text(
                          'Menyiapkan pengalaman terbaik...',
                          style: TextStyle(
                            color: Color(0xFFD7C1B0),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Informasi bagian bawah
              const Positioned(
                bottom: 22,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'MADE WITH LOVE',
                    style: TextStyle(
                      color: Color(0xFFBCA18B),
                      fontSize: 10,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _decorationCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
          width: 1.5,
        ),
      ),
    );
  }
}
