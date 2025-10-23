import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../theme/app_theme.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool remember = false;

  void _signIn() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 26),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 10),
              CircleAvatar(radius: 40, backgroundColor: Colors.white, child: Text('L', style: TextStyle(color: AppTheme.primary, fontSize: 36, fontWeight: FontWeight.bold))),
              const SizedBox(height: 18),
              const Text('Sign in your account', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              CustomTextField(controller: email, hintText: 'Email', keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 12),
              CustomTextField(controller: password, hintText: 'Password', obscureText: true),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [Checkbox(value: remember, onChanged: (v) => setState(() => remember = v ?? false)), const Text('Remember me', style: TextStyle(color: Colors.white70))]),
                TextButton(onPressed: () {}, child: const Text('Forgot password?', style: TextStyle(color: Colors.white70))),
              ]),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _signIn, style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)), child: const Text('SIGN IN')),
              const SizedBox(height: 12),
              const Text('or sign in with', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 10),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.login), label: const Text('Continue with Google')),
              const SizedBox(height: 16),
              TextButton(onPressed: () => Navigator.pushNamed(context, '/signup'), child: const Text("Don't have an account? SIGN UP", style: TextStyle(color: Colors.white70))),
            ]),
          ),
        ),
      ),
    );
  }
}
