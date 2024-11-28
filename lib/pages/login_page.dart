import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isHidden = true;

  void handleVisibilityPassword() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future<void> login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await authService.signInWithEmailPassword(email, password);
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
      appBar: AppBar(title: const Text('Login')),
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
          FilledButton(onPressed: login, child: const Text('Sign In')),
          const SizedBox(height: 12),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()));
              },
              child: const Text("Don't have an account? Sign Up")),
        ],
      ),
    );
  }
}
