
import 'package:flutter/material.dart';
import 'register_page.dart';
import 'main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  static const Color darkBrown = Color(0xFF3E2723);
  static const Color mediumBrown = Color(0xFF795548);
  static const Color lightBrown = Color(0xFFD7B899);
  static const Color cream = Color(0xFFFAF3E8);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
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
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 28,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  children: [
                    // Logo Warung IS
                    Container(
                      width: 110,
                      height: 110,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.10),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: lightBrown,
                          width: 1.5,
                        ),
                      ),
                      child: Image.asset(
                        'assets/cafe.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.coffee_rounded,
                            size: 65,
                            color: Color(0xFFE8C7A7),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      'WARUNG IS',
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Selamat datang kembali!',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFFE8C7A7),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Card Login
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: cream,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.20),
                            blurRadius: 25,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Masuk',
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: darkBrown,
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              'Silakan masuk untuk melanjutkan.',
                              style: TextStyle(
                                fontSize: 13,
                                color: mediumBrown,
                              ),
                            ),

                            const SizedBox(height: 28),

                            // Email
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: darkBrown,
                              ),
                            ),

                            const SizedBox(height: 9),

                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'nama@email.com',
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: mediumBrown,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 17,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0D3C4),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: mediumBrown,
                                    width: 1.5,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }

                                final emailPattern = RegExp(
                                  r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                );

                                if (!emailPattern.hasMatch(value.trim())) {
                                  return 'Format email tidak valid';
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 22),

                            // Password
                            const Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: darkBrown,
                              ),
                            ),

                            const SizedBox(height: 9),

                            TextFormField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              decoration: InputDecoration(
                                hintText: 'Masukkan password',
                                prefixIcon: const Icon(
                                  Icons.lock_outline_rounded,
                                  color: mediumBrown,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible =
                                          !_isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: mediumBrown,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 17,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0D3C4),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: mediumBrown,
                                    width: 1.5,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }

                                if (value.length < 6) {
                                  return 'Password minimal 6 karakter';
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 30),

                            // Tombol Masuk
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Login Berhasil!'),
                                        backgroundColor: Color(0xFF5D4037),
                                      ),
                                    );

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MainScreen(),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: darkBrown,
                                  foregroundColor: Colors.white,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.login_rounded, size: 20),
                                    SizedBox(width: 10),
                                    Text(
                                      'Masuk',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Pemisah
                            const Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Color(0xFFE0D3C4),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    'ATAU',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: mediumBrown,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Color(0xFFE0D3C4),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            // Tombol Daftar
                            Center(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment:
                                    WrapCrossAlignment.center,
                                children: [
                                  const Text(
                                    'Belum punya akun? ',
                                    style: TextStyle(
                                      color: mediumBrown,
                                      fontSize: 13,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage(),
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: darkBrown,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 8,
                                      ),
                                    ),
                                    child: const Text(
                                      'Daftar di sini',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'NIKMATI HANGATNYA SETIAP MOMEN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFD7B899),
                        fontSize: 10,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
