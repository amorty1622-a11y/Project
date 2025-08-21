import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/api_client.dart';
import '../../core/session.dart';
import '../home/home_screen.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  int _gender = 0;
  bool _loading = false;
  String? _error;

  Future<void> _signup() async {
    setState(() { _loading = true; _error = null; });
    try {
      final res = await ApiClient.instance.dio.post('/auth/register', data: {
        'name': _name.text,
        'email': _email.text,
        'phone': _phone.text,
        'gender': _gender.toString(),
        'password': _password.text,
        'password_confirmation': _confirm.text,
      });
      final token = res.data['data']['token'] as String;
      await SessionManager.instance.setToken(token);
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } on DioException catch (e) {
      setState(() { _error = e.response?.data?['message']?.toString() ?? 'Signup failed'; });
    } finally {
      if (mounted) setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            TextField(controller: _name, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _phone, decoration: const InputDecoration(labelText: 'Phone')),
            const SizedBox(height: 8),
            Row(children: [
              const Text('Gender:'),
              const SizedBox(width: 8),
              ChoiceChip(label: const Text('Male'), selected: _gender == 0, onSelected: (_) => setState(() => _gender = 0)),
              const SizedBox(width: 8),
              ChoiceChip(label: const Text('Female'), selected: _gender == 1, onSelected: (_) => setState(() => _gender = 1)),
            ]),
            TextField(controller: _password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            TextField(controller: _confirm, decoration: const InputDecoration(labelText: 'Confirm Password'), obscureText: true),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _signup,
                child: _loading ? const CircularProgressIndicator() : const Text('Create account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

