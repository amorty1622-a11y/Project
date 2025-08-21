import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/api_client.dart';
import '../doctor/doctor_details_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _recommendations = [];
  List<dynamic> _doctors = [];
  bool _loading = true;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final home = await ApiClient.instance.dio.get('/home/index');
      final recs = List<dynamic>.from(home.data['data']['recommendations'] as List);
      final all = await ApiClient.instance.dio.get('/doctor/index');
      setState(() {
        _recommendations = recs;
        _doctors = List<dynamic>.from(all.data['data'] as List);
      });
    } on DioException catch (_) {
      // ignore
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _search(String name) async {
    setState(() => _query = name);
    if (name.isEmpty) return _load();
    final res = await ApiClient.instance.dio.get('/doctor/doctor-search', queryParameters: { 'name': name });
    setState(() => _doctors = List<dynamic>.from(res.data['data'] as List));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VCare'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.of(context).pushNamed(ProfileScreen.routeName),
          )
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextField(
                    decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search doctor'),
                    onChanged: _search,
                  ),
                  const SizedBox(height: 16),
                  const Text('Recommended', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 140,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, i) {
                        final d = _recommendations[i];
                        return _DoctorCard(doctor: d);
                      },
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemCount: _recommendations.length,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('All Doctors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () async {
                          final res = await ApiClient.instance.dio.get('/doctor/doctor-filter', queryParameters: { 'city': 7 });
                          setState(() => _doctors = List<dynamic>.from(res.data['data'] as List));
                        },
                        child: const Text('Filter by city'),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  ..._doctors.map((d) => Card(
                        child: ListTile(
                          title: Text(d['name'].toString()),
                          subtitle: Text('Rating ${d['rating'] ?? '-'}'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.of(context).pushNamed(DoctorDetailsScreen.routeName, arguments: d['id']),
                        ),
                      )),
                ],
              ),
            ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctor;
  const _DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(DoctorDetailsScreen.routeName, arguments: doctor['id']),
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doctor['name'].toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(doctor['about']?.toString() ?? ''),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(doctor['rating']?.toString() ?? '-')
              ],
            )
          ],
        ),
      ),
    );
  }
}

