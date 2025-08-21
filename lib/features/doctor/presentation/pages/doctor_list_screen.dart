import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/doctor_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import 'doctor_detail_screen.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  String _selectedSpecialization = 'All';
  String _selectedCity = 'All';
  String _selectedGovernorate = 'All';
  
  final List<String> _specializations = [
    'All',
    'Cardiology',
    'Dermatology',
    'Neurology',
    'Orthopedics',
    'Pediatrics',
    'Gynecology',
    'Psychiatry',
  ];

  final List<String> _cities = [
    'All',
    'Cairo',
    'Alexandria',
    'Giza',
    'Sharm El Sheikh',
    'Hurghada',
  ];

  final List<String> _governorates = [
    'All',
    'Cairo',
    'Alexandria',
    'Giza',
    'South Sinai',
    'Red Sea',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Doctors',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterBottomSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Specialization', _selectedSpecialization),
                  SizedBox(width: 10.w),
                  _buildFilterChip('City', _selectedCity),
                  SizedBox(width: 10.w),
                  _buildFilterChip('Governorate', _selectedGovernorate),
                ],
              ),
            ),
          ),
          
          // Doctor list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: 10, // Mock data
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: DoctorCard(
                    name: 'Dr. ${['Ahmed', 'Sarah', 'Mohammed', 'Fatima', 'Omar', 'Aisha', 'Hassan', 'Nour', 'Youssef', 'Layla'][index]}',
                    specialization: _specializations[1 + (index % (_specializations.length - 1))],
                    rating: 4.0 + (index * 0.1),
                    experience: '${3 + (index % 8)} years',
                    image: 'https://via.placeholder.com/60',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DoctorDetailScreen(
                            doctorId: index + 1,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: value != 'All' ? const Color(0xFF1E88E5) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: value != 'All' ? const Color(0xFF1E88E5) : Colors.grey[300]!,
        ),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          fontSize: 12.sp,
          color: value != 'All' ? Colors.white : Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        specializations: _specializations,
        cities: _cities,
        governorates: _governorates,
        selectedSpecialization: _selectedSpecialization,
        selectedCity: _selectedCity,
        selectedGovernorate: _selectedGovernorate,
        onApply: (specialization, city, governorate) {
          setState(() {
            _selectedSpecialization = specialization;
            _selectedCity = city;
            _selectedGovernorate = governorate;
          });
        },
      ),
    );
  }
}