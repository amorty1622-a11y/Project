import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/api_client.dart';

class BookingScreen extends StatefulWidget {
  static const String routeName = '/booking';
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _notes = TextEditingController();
  DateTime _dateTime = DateTime.now().add(const Duration(days: 1));
  bool _loading = false;
  String? _msg;

  Future<void> _book(int doctorId) async {
    setState(() { _loading = true; _msg = null; });
    try {
      final res = await ApiClient.instance.dio.post('/appointment/store', data: {
        'doctor_id': doctorId.toString(),
        'start_time': _dateTime.toIso8601String(),
        'notes': _notes.text,
      });
      setState(() => _msg = 'Booked: ' + res.data['data']['id'].toString());
    } on DioException catch (e) {
      setState(() => _msg = e.response?.data?['message']?.toString() ?? 'Booking failed');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int doctorId = (ModalRoute.of(context)?.settings.arguments as int?) ?? 0;
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_msg != null) Text(_msg!),
            Text('Doctor ID: $doctorId'),
            const SizedBox(height: 12),
            Row(children: [
              const Text('Date & Time: '),
              Text('${_dateTime.toLocal()}'),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.edit_calendar),
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    initialDate: _dateTime,
                  );
                  if (date != null) {
                    final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(_dateTime));
                    if (time != null) {
                      setState(() {
                        _dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                      });
                    }
                  }
                },
              )
            ]),
            TextField(controller: _notes, decoration: const InputDecoration(labelText: 'Notes')),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : () => _book(doctorId),
                child: _loading ? const CircularProgressIndicator() : const Text('Confirm Booking'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

