import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<String> specializations;
  final List<String> cities;
  final List<String> governorates;
  final String selectedSpecialization;
  final String selectedCity;
  final String selectedGovernorate;
  final Function(String, String, String) onApply;

  const FilterBottomSheet({
    super.key,
    required this.specializations,
    required this.cities,
    required this.governorates,
    required this.selectedSpecialization,
    required this.selectedCity,
    required this.selectedGovernorate,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String _selectedSpecialization;
  late String _selectedCity;
  late String _selectedGovernorate;

  @override
  void initState() {
    super.initState();
    _selectedSpecialization = widget.selectedSpecialization;
    _selectedCity = widget.selectedCity;
    _selectedGovernorate = widget.selectedGovernorate;
  }

  void _applyFilters() {
    widget.onApply(_selectedSpecialization, _selectedCity, _selectedGovernorate);
    Navigator.of(context).pop();
  }

  void _resetFilters() {
    setState(() {
      _selectedSpecialization = 'All';
      _selectedCity = 'All';
      _selectedGovernorate = 'All';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Doctors',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: _resetFilters,
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    ElevatedButton(
                      onPressed: _applyFilters,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E88E5),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Apply',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Filter options
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Specialization filter
                  _buildFilterSection(
                    'Specialization',
                    widget.specializations,
                    _selectedSpecialization,
                    (value) {
                      setState(() {
                        _selectedSpecialization = value;
                      });
                    },
                  ),
                  
                  SizedBox(height: 30.h),
                  
                  // Governorate filter
                  _buildFilterSection(
                    'Governorate',
                    widget.governorates,
                    _selectedGovernorate,
                    (value) {
                      setState(() {
                        _selectedGovernorate = value;
                        // Reset city when governorate changes
                        if (_selectedCity != 'All' && value != 'All') {
                          _selectedCity = 'All';
                        }
                      });
                    },
                  ),
                  
                  SizedBox(height: 30.h),
                  
                  // City filter
                  _buildFilterSection(
                    'City',
                    widget.cities,
                    _selectedCity,
                    (value) {
                      setState(() {
                        _selectedCity = value;
                      });
                    },
                    isEnabled: _selectedGovernorate == 'All',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    List<String> options,
    String selectedValue,
    Function(String) onChanged, {
    bool isEnabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        
        SizedBox(height: 16.h),
        
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: options.map((option) {
            final isSelected = option == selectedValue;
            return GestureDetector(
              onTap: isEnabled ? () => onChanged(option) : null,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1E88E5)
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1E88E5)
                        : Colors.grey[300]!,
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? Colors.white
                        : isEnabled
                            ? Colors.black87
                            : Colors.grey[400],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}