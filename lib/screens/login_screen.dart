import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../widgets/app_background.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService authService = AuthService();

  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showMessage(
        'Please enter email and password',
        isError: true,
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final success = await authService.login(
      email,
      password,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(
            authService: authService,
          ),
        ),
      );
    } else {
      showMessage(
        'Login failed. Please try again.',
        isError: true,
      );
    }
  }

  void showMessage(
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? AppColors.error : AppColors.success,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),

              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 470,
                ),

                child: Container(
                  padding: const EdgeInsets.all(34),

                  decoration: BoxDecoration(
                    color: AppColors.card.withValues(
                      alpha: 0.94,
                    ),

                    borderRadius: BorderRadius.circular(28),

                    border: Border.all(
                      color: Colors.white.withValues(
                        alpha: 0.08,
                      ),
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: 0.35,
                        ),
                        blurRadius: 45,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      Container(
                        width: 88,
                        height: 88,

                        decoration: BoxDecoration(
                          gradient:
                              AppColors.primaryGradient,

                          borderRadius:
                              BorderRadius.circular(25),

                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary
                                  .withValues(
                                alpha: 0.35,
                              ),
                              blurRadius: 25,
                              spreadRadius: 2,
                            ),
                          ],
                        ),

                        child: const Icon(
                          Icons.menu_book_rounded,
                          color: Colors.white,
                          size: 46,
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        AppConstants.loginTitle,
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        AppConstants.loginSubtitle,
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 35),

                      // Email
                      CustomTextField(
                        label: 'Email Address',
                        hint: 'Enter your email',
                        prefixIcon:
                            Icons.email_outlined,
                        controller: emailController,
                        keyboardType:
                            TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 18),

                      // Password
                      CustomTextField(
                        label: 'Password',
                        hint: 'Enter your password',
                        prefixIcon:
                            Icons.lock_outline,
                        controller: passwordController,
                        obscureText: obscurePassword,
                        suffixIcon: obscurePassword
                            ? Icons.visibility_outlined
                            : Icons
                                .visibility_off_outlined,
                        onSuffixPressed: () {
                          setState(() {
                            obscurePassword =
                                !obscurePassword;
                          });
                        },
                      ),

                      const SizedBox(height: 10),

                      Align(
                        alignment:
                            Alignment.centerRight,

                        child: TextButton(
                          onPressed: () {
                            showMessage(
                              'Password recovery will be added soon.',
                            );
                          },

                          child: const Text(
                            'Forgot Password?',
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Login Button
                      isLoading
                          ? const SizedBox(
                              height: 54,
                              child: Center(
                                child:
                                    CircularProgressIndicator(),
                              ),
                            )
                          : CustomButton(
                              text: 'LOGIN',
                              icon: Icons.login_rounded,
                              onPressed: handleLogin,
                            ),

                      const SizedBox(height: 25),

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.white
                                  .withValues(
                                alpha: 0.1,
                              ),
                            ),
                          ),

                          const Padding(
                            padding:
                                EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                color: AppColors
                                    .textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Divider(
                              color: Colors.white
                                  .withValues(
                                alpha: 0.1,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Register
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: AppColors
                                  .textSecondary,
                            ),
                          ),

                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const RegisterScreen(),
                                ),
                              );
                            },

                            child: const Text(
                              'Create Account',
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Version ${AppConstants.appVersion}',
                        style: const TextStyle(
                          color:
                              AppColors.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}