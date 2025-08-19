import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/api_client.dart';
import '../../core/session.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  int _gender = 0;
  bool _loading = true;
  String? _msg;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final res = await ApiClient.instance.dio.get('/user/profile');
      final u = Map<String, dynamic>.from(res.data['data'] as Map);
      _name.text = (u['name'] ?? '').toString();
      _email.text = (u['email'] ?? '').toString();
      _phone.text = (u['phone'] ?? '').toString();
      _gender = (u['gender'] ?? 0) is int ? (u['gender'] ?? 0) : int.tryParse(u['gender']?.toString() ?? '0') ?? 0;
    } on DioException catch (_) {
      // ignore
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    setState(() => _msg = null);
    try {
      await ApiClient.instance.dio.post('/user/update', data: {
        'name': _name.text,
        'email': _email.text,
        'phone': _phone.text,
        'gender': _gender.toString(),
      });
      setState(() => _msg = 'Profile updated');
    } on DioException catch (e) {
      setState(() => _msg = e.response?.data?['message']?.toString() ?? 'Failed to update');
    }
  }

  Future<void> _logout() async {
    try { await ApiClient.instance.dio.post('/auth/logout'); } catch (_) {}
    await SessionManager.instance.clearToken();
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (_msg != null) Text(_msg!),
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
                  const SizedBox(height: 16),
                  Row(children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _save,
                        child: const Text('Save'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _logout,
                        child: const Text('Logout'),
                      ),
                    ),
                  ])
                ],
              ),
            ),
    );
  }
}

