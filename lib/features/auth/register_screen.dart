import 'package:flutter/material.dart';
import '../../main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleRegistration() {
    if (_formKey.currentState!.validate()) {
      // ---------------------------------------------------------
      // FIREBASE CALL: auth.createUserWithEmailAndPassword()
      // TODO: Send user data to Firebase and then trigger OTP
      // ---------------------------------------------------------
      _showOtpDialog();
    }
  }

  void _showOtpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Verify Email"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("We've sent a 6-digit code to your email."),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter OTP",
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // ---------------------------------------------------------
              // API CALL: Verify OTP via FastAPI/Firebase logic
              // ---------------------------------------------------------
              Navigator.pop(context); // Close Dialog
              Navigator.pop(context); // Return to Login
            },
            child: const Text("Verify & Register"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.contrast_rounded),
          onPressed: () => context
              .findAncestorStateOfType<DigitalWellbeingAppState>()
              ?.toggleTheme(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Join Balance",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Create your wellness profile",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 40),

                _buildInput(
                  "Full Name",
                  Icons.person_outline,
                  _nameController,
                  (val) => val!.isEmpty ? "Please enter your name" : null,
                ),
                const SizedBox(height: 16),

                _buildInput(
                  "Email Address",
                  Icons.email_outlined,
                  _emailController,
                  (val) => !val!.contains("@") ? "Enter a valid email" : null,
                ),
                const SizedBox(height: 16),

                _buildInput(
                  "Password",
                  Icons.lock_outline,
                  _passwordController,
                  (val) =>
                      val!.length < 6 ? "Minimum 6 characters required" : null,
                  obscure: true,
                ),

                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _handleRegistration,
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Already have an account? Sign In"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
    String hint,
    IconData icon,
    TextEditingController controller,
    String? Function(String?)? validator, {
    bool obscure = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
