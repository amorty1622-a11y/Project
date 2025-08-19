import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/api_client.dart';
import '../appointment/booking_screen.dart';

class DoctorDetailsScreen extends StatefulWidget {
  static const String routeName = '/doctor';
  const DoctorDetailsScreen({super.key});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  Map<String, dynamic>? _doctor;
  bool _loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context)?.settings.arguments;
    if (id != null && _loading) _load(id);
  }

  Future<void> _load(Object id) async {
    setState(() => _loading = true);
    try {
      final res = await ApiClient.instance.dio.get('/doctor/show/$id');
      setState(() => _doctor = Map<String, dynamic>.from(res.data['data'] as Map));
    } on DioException catch (_) {}
    finally { if (mounted) setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _doctor == null
              ? const Center(child: Text('Not found'))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_doctor!['name'].toString(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(_doctor!['about']?.toString() ?? ''),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pushNamed(BookingScreen.routeName, arguments: _doctor!['id']),
                          child: const Text('Book Appointment'),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}

