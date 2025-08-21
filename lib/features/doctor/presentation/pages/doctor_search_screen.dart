import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/doctor_card.dart';
import 'doctor_detail_screen.dart';

class DoctorSearchScreen extends StatefulWidget {
  const DoctorSearchScreen({super.key});

  @override
  State<DoctorSearchScreen> createState() => _DoctorSearchScreenState();
}

class _DoctorSearchScreenState extends State<DoctorSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedSpecialization = 'All';
  String _selectedCity = 'All';
  
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    setState(() {
      _searchQuery = _searchController.text.trim();
    });
  }

  List<Map<String, dynamic>> _getFilteredDoctors() {
    // Mock data - in real app, this would come from API
    final List<Map<String, dynamic>> allDoctors = [
      {
        'id': 1,
        'name': 'Dr. Ahmed Hassan',
        'specialization': 'Cardiology',
        'city': 'Cairo',
        'rating': 4.8,
        'experience': '8 years',
        'image': 'https://via.placeholder.com/60',
      },
      {
        'id': 2,
        'name': 'Dr. Sarah Ahmed',
        'specialization': 'Dermatology',
        'city': 'Alexandria',
        'rating': 4.6,
        'experience': '6 years',
        'image': 'https://via.placeholder.com/60',
      },
      {
        'id': 3,
        'name': 'Dr. Mohammed Ali',
        'specialization': 'Neurology',
        'city': 'Giza',
        'rating': 4.9,
        'experience': '10 years',
        'image': 'https://via.placeholder.com/60',
      },
      {
        'id': 4,
        'name': 'Dr. Fatima Omar',
        'specialization': 'Pediatrics',
        'city': 'Cairo',
        'rating': 4.7,
        'experience': '7 years',
        'image': 'https://via.placeholder.com/60',
      },
      {
        'id': 5,
        'name': 'Dr. Omar Hassan',
        'specialization': 'Orthopedics',
        'city': 'Sharm El Sheikh',
        'rating': 4.5,
        'experience': '5 years',
        'image': 'https://via.placeholder.com/60',
      },
    ];

    return allDoctors.where((doctor) {
      bool matchesSearch = _searchQuery.isEmpty ||
          doctor['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          doctor['specialization'].toLowerCase().contains(_searchQuery.toLowerCase());
      
      bool matchesSpecialization = _selectedSpecialization == 'All' ||
          doctor['specialization'] == _selectedSpecialization;
      
      bool matchesCity = _selectedCity == 'All' ||
          doctor['city'] == _selectedCity;
      
      return matchesSearch && matchesSpecialization && matchesCity;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = _getFilteredDoctors();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Search Doctors',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Search and filter section
          Container(
            padding: EdgeInsets.all(20.w),
            color: Colors.white,
            child: Column(
              children: [
                // Search bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for doctors...',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[500],
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                      size: 20.w,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _performSearch();
                      },
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                  ),
                  onChanged: (value) => _performSearch(),
                  onSubmitted: (value) => _performSearch(),
                ),
                
                SizedBox(height: 20.h),
                
                // Filter options
                Row(
                  children: [
                    Expanded(
                      child: _buildFilterDropdown(
                        'Specialization',
                        _selectedSpecialization,
                        _specializations,
                        (value) {
                          setState(() {
                            _selectedSpecialization = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: _buildFilterDropdown(
                        'City',
                        _selectedCity,
                        _cities,
                        (value) {
                          setState(() {
                            _selectedCity = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Results count
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              children: [
                Text(
                  '${filteredDoctors.length} doctors found',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
                Spacer(),
                if (_searchQuery.isNotEmpty || _selectedSpecialization != 'All' || _selectedCity != 'All')
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _searchQuery = '';
                        _selectedSpecialization = 'All';
                        _selectedCity = 'All';
                        _searchController.clear();
                      });
                    },
                    child: Text(
                      'Clear filters',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF1E88E5),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Doctor list
          Expanded(
            child: filteredDoctors.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80.w,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'No doctors found',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Try adjusting your search criteria',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, index) {
                      final doctor = filteredDoctors[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: DoctorCard(
                          name: doctor['name'],
                          specialization: doctor['specialization'],
                          rating: doctor['rating'],
                          experience: doctor['experience'],
                          image: doctor['image'],
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DoctorDetailScreen(
                                  doctorId: doctor['id'],
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

  Widget _buildFilterDropdown(
    String label,
    String value,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: SizedBox(),
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black87,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}