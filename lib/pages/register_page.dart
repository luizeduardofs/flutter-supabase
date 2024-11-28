import 'package:flutter/material.dart';

import '../auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isHidden = true;
  bool _isHiddenConfirm = true;

  void handleVisibilityPassword() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void handleVisibilityPasswordConfirm() {
    setState(() {
      _isHiddenConfirm = !_isHiddenConfirm;
    });
  }

  Future<void> signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Pasword don't match")));
      return;
    }

    try {
      await authService.signUpWithEmailPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            obscureText: _isHidden,
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: 'Password',
              suffix: IconButton(
                onPressed: handleVisibilityPassword,
                icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            obscureText: _isHiddenConfirm,
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              suffix: IconButton(
                onPressed: handleVisibilityPasswordConfirm,
                icon: Icon(
                    _isHiddenConfirm ? Icons.visibility : Icons.visibility_off),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(onPressed: signUp, child: const Text('Sign Up')),
        ],
      ),
    );
  }
}
