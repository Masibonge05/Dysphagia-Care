
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Added Firestore import

// Color constants from design
const Color primaryColor = Color(0xFF0094d4);
const Color secondaryColor = Color(0xFF01224f);
const Color accentColor = Color(0xFF98daf8);
const Color highlightColor = Color(0xFF00529a);
const Color backgroundColor = Color(0xFFf0f5f7);

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      // Create user with Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Add user to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'notificationPreferences': {
          'email': true,
          'push': true,
        },
      });

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      if (mounted) {
        // Show snackbar to check email
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Account created! Please check your email to verify your account.',
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 5),
          ),
        );

        // Navigate to sign-in page after a delay
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.pushReplacementNamed(context, '/signin');
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'email-already-in-use':
            _errorMessage = 'This email is already in use.';
            break;
          case 'invalid-email':
            _errorMessage = 'Invalid email address.';
            break;
          case 'weak-password':
            _errorMessage = 'Password is too weak.';
            break;
          default:
            _errorMessage = e.message ?? 'Registration failed.';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter password';
    if (value.length < 8) return 'Min 8 characters required';
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^A-Za-z0-9]).+$');
    if (!regex.hasMatch(value)) {
      return 'Use uppercase, lowercase, number & symbol';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Image.asset(
                      'assets/images/logo_new.png',
                      width: 120,
                      height: 120,
                    ),
                    const SizedBox(height: 40),
                    
                    // Title - Using Heading 1 specs (32px, ExtraBold)
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 32,
                        fontWeight: FontWeight.w900, // ExtraBold
                        color: secondaryColor,
                        height: 1.5, // 48px line height / 32px font size
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Subtitle - Using Bold specs (18px, Bold)
                    const Text(
                      'Sign Up To Get Started',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w700, // Bold
                        color: highlightColor,
                        height: 1.33, // 24px line height / 18px font size
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Error message - Using Paragraph specs (16px, Regular)
                    if (_errorMessage.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade300),
                        ),
                        child: Text(
                          _errorMessage,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.red.shade800,
                            fontSize: 16,
                            fontWeight: FontWeight.w400, // Regular
                            height: 1.5, // 24px line height / 16px font size
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    
                    // Form fields
                    _buildTextField(
                      controller: _emailController,
                      hint: 'Email',
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    _buildTextField(
                      controller: _passwordController,
                      hint: 'Password',
                      label: 'Password',
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: primaryColor,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 16),
                    
                    _buildTextField(
                      controller: _confirmController,
                      hint: 'Confirm Password',
                      label: 'Confirm Password',
                      obscureText: _obscureConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                          color: primaryColor,
                        ),
                        onPressed: _toggleConfirmPasswordVisibility,
                      ),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    
                    // Sign Up Button - Using Heading 4 specs for button text (18px, Medium)
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'Sign up',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18, // Updated to match design
                                  fontWeight: FontWeight.w700, // Bold
                                  color: Colors.white,
                                  height: 1.33,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Already have account link - Using SemiBold specs (16px, SemiBold)
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/signin');
                      },
                      child: const Text(
                        'Already have an account',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: secondaryColor,
                          fontSize: 16, // Updated from 14px to 16px
                          fontWeight: FontWeight.w600, // SemiBold
                          decoration: TextDecoration.underline,
                          height: 1.5,
                        ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16, // Paragraph size
        fontWeight: FontWeight.w400, // Regular
        color: secondaryColor,
        height: 1.5,
      ),
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16, // Paragraph size
          fontWeight: FontWeight.w400, // Regular
          color: secondaryColor,
          height: 1.5,
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16, // Paragraph size
          fontWeight: FontWeight.w400, // Regular
          color: Color(0xFF757575),
          height: 1.5,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}