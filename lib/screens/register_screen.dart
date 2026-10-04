import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../utils/app_colors.dart';
import '../widgets/app_background.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final AuthService authService = AuthService();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> handleRegister() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword =
        confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showMessage(
        'Please fill all fields',
        isError: true,
      );
      return;
    }

    if (password.length < 6) {
      showMessage(
        'Password must contain at least 6 characters',
        isError: true,
      );
      return;
    }

    if (password != confirmPassword) {
      showMessage(
        'Passwords do not match',
        isError: true,
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final success = await authService.register(
      name,
      email,
      password,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(
            authService: authService,
          ),
        ),
        (route) => false,
      );
    } else {
      showMessage(
        'Registration failed. Please try again.',
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
                        width: 82,
                        height: 82,

                        decoration: BoxDecoration(
                          gradient:
                              AppColors.primaryGradient,

                          borderRadius:
                              BorderRadius.circular(24),

                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary
                                  .withValues(
                                alpha: 0.30,
                              ),
                              blurRadius: 25,
                            ),
                          ],
                        ),

                        child: const Icon(
                          Icons.person_add_alt_1_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'Create Account',
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Join the Digital Library today',
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Name
                      CustomTextField(
                        label: 'Full Name',
                        hint: 'Enter your full name',
                        prefixIcon:
                            Icons.person_outline,
                        controller: nameController,
                      ),

                      const SizedBox(height: 18),

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
                        hint: 'Create a password',
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

                      const SizedBox(height: 18),

                      // Confirm Password
                      CustomTextField(
                        label: 'Confirm Password',
                        hint: 'Re-enter your password',
                        prefixIcon:
                            Icons.lock_reset_outlined,
                        controller:
                            confirmPasswordController,
                        obscureText:
                            obscureConfirmPassword,
                        suffixIcon:
                            obscureConfirmPassword
                                ? Icons
                                    .visibility_outlined
                                : Icons
                                    .visibility_off_outlined,
                        onSuffixPressed: () {
                          setState(() {
                            obscureConfirmPassword =
                                !obscureConfirmPassword;
                          });
                        },
                      ),

                      const SizedBox(height: 28),

                      // Register
                      isLoading
                          ? const SizedBox(
                              height: 54,
                              child: Center(
                                child:
                                    CircularProgressIndicator(),
                              ),
                            )
                          : CustomButton(
                              text: 'CREATE ACCOUNT',
                              icon: Icons
                                  .person_add_rounded,
                              onPressed: handleRegister,
                            ),

                      const SizedBox(height: 24),

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

                      const SizedBox(height: 18),

                      // Back to login
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          size: 18,
                        ),

                        label: const Text(
                          'Back to Login',
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