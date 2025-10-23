import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../theme/app_theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController about = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirm = TextEditingController();
  bool accepted = false;

  void _signUp() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
          child: SingleChildScrollView(
            child: Column(children: [
              Align(alignment: Alignment.centerLeft, child: TextButton(onPressed: () => Navigator.pop(context), child: const Text('Back', style: TextStyle(color: Colors.white70)))),
              const SizedBox(height: 6),
              const Text('Create your account', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              CustomTextField(controller: name, hintText: 'Name'),
              const SizedBox(height: 12),
              CustomTextField(controller: email, hintText: 'Email', keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 12),
              CustomTextField(controller: about, hintText: 'About you (User / Legal Practitioner)'),
              const SizedBox(height: 12),
              CustomTextField(controller: password, hintText: 'Password', obscureText: true),
              const SizedBox(height: 12),
              CustomTextField(controller: confirm, hintText: 'Confirm Password', obscureText: true),
              Row(children: [Checkbox(value: accepted, onChanged: (v) => setState(() => accepted = v ?? false)), const Expanded(child: Text('I understand the terms & policy', style: TextStyle(color: Colors.white70)))]),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _signUp, style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)), child: const Text('SIGN UP')),
              const SizedBox(height: 10),
              const Text('or sign up with', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.login), label: const Text('Continue with Google')),
              const SizedBox(height: 12),
              TextButton(onPressed: () => Navigator.pushNamed(context, '/signin'), child: const Text('Have an account? SIGN IN', style: TextStyle(color: Colors.white70))),
            ]),
          ),
        ),
      ),
    );
  }
}
