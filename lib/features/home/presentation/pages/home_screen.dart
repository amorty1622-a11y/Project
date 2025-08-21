import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/services/auth_service.dart';
import '../widgets/doctor_card.dart';
import '../widgets/specialization_card.dart';
import '../../../doctor/presentation/pages/doctor_list_screen.dart';
import '../../../doctor/presentation/pages/doctor_search_screen.dart';
import '../../../profile/presentation/pages/profile_screen.dart';
import '../../../appointment/presentation/pages/appointment_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = getIt<AuthService>();
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const DoctorListScreen(),
    const AppointmentListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1E88E5),
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello!',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'How can we help you today?',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E88E5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24.w,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 30.h),
              
              // Search bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for doctors, specializations...',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[500],
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                      size: 20.w,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DoctorSearchScreen(),
                      ),
                    );
                  },
                ),
              ),
              
              SizedBox(height: 30.h),
              
              // Specializations
              Text(
                'Specializations',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              
              SizedBox(height: 20.h),
              
              SizedBox(
                height: 120.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SpecializationCard(
                      title: 'Cardiology',
                      icon: Icons.favorite,
                      color: Colors.red[400]!,
                      onTap: () {},
                    ),
                    SpecializationCard(
                      title: 'Dermatology',
                      icon: Icons.face,
                      color: Colors.orange[400]!,
                      onTap: () {},
                    ),
                    SpecializationCard(
                      title: 'Neurology',
                      icon: Icons.psychology,
                      color: Colors.purple[400]!,
                      onTap: () {},
                    ),
                    SpecializationCard(
                      title: 'Orthopedics',
                      icon: Icons.accessibility,
                      color: Colors.blue[400]!,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 30.h),
              
              // Recommended Doctors
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended Doctors',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const DoctorListScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF1E88E5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20.h),
              
              // Doctor cards
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: DoctorCard(
                      name: 'Dr. ${['Ahmed', 'Sarah', 'Mohammed'][index]}',
                      specialization: ['Cardiology', 'Dermatology', 'Neurology'][index],
                      rating: 4.5 + (index * 0.2),
                      experience: '${5 + index} years',
                      image: 'https://via.placeholder.com/60',
                      onTap: () {},
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}