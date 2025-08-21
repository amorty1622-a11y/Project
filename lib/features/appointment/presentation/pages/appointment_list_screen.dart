import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/appointment_card.dart';

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({super.key});

  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'My Appointments',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF1E88E5),
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: const Color(0xFF1E88E5),
          tabs: [
            Tab(text: 'Upcoming'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAppointmentList('upcoming'),
          _buildAppointmentList('completed'),
          _buildAppointmentList('cancelled'),
        ],
      ),
    );
  }

  Widget _buildAppointmentList(String status) {
    final appointments = _getAppointmentsByStatus(status);

    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getEmptyStateIcon(status),
              size: 80.w,
              color: Colors.grey[400],
            ),
            SizedBox(height: 20.h),
            Text(
              _getEmptyStateMessage(status),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              _getEmptyStateSubMessage(status),
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(20.w),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: AppointmentCard(
            appointment: appointment,
            onTap: () {
              // Navigate to appointment details
            },
            onCancel: status == 'upcoming' ? () => _cancelAppointment(appointment['id']) : null,
            onReschedule: status == 'upcoming' ? () => _rescheduleAppointment(appointment) : null,
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> _getAppointmentsByStatus(String status) {
    // Mock data - in real app, this would come from API
    final List<Map<String, dynamic>> allAppointments = [
      {
        'id': 1,
        'doctorName': 'Dr. Ahmed Hassan',
        'specialization': 'Cardiology',
        'date': '2024-01-15',
        'time': '09:00 AM',
        'status': 'upcoming',
        'doctorImage': 'https://via.placeholder.com/60',
        'location': 'Cairo Medical Center',
        'consultationFee': '\$50',
      },
      {
        'id': 2,
        'doctorName': 'Dr. Sarah Ahmed',
        'specialization': 'Dermatology',
        'date': '2024-01-10',
        'time': '02:00 PM',
        'status': 'completed',
        'doctorImage': 'https://via.placeholder.com/60',
        'location': 'Alexandria Clinic',
        'consultationFee': '\$40',
      },
      {
        'id': 3,
        'doctorName': 'Dr. Mohammed Ali',
        'specialization': 'Neurology',
        'date': '2024-01-05',
        'time': '11:00 AM',
        'status': 'cancelled',
        'doctorImage': 'https://via.placeholder.com/60',
        'location': 'Giza Hospital',
        'consultationFee': '\$60',
      },
      {
        'id': 4,
        'doctorName': 'Dr. Fatima Omar',
        'specialization': 'Pediatrics',
        'date': '2024-01-20',
        'time': '10:00 AM',
        'status': 'upcoming',
        'doctorImage': 'https://via.placeholder.com/60',
        'location': 'Cairo Children Hospital',
        'consultationFee': '\$35',
      },
    ];

    return allAppointments.where((appointment) => appointment['status'] == status).toList();
  }

  IconData _getEmptyStateIcon(String status) {
    switch (status) {
      case 'upcoming':
        return Icons.calendar_today_outlined;
      case 'completed':
        return Icons.check_circle_outline;
      case 'cancelled':
        return Icons.cancel_outlined;
      default:
        return Icons.calendar_today_outlined;
    }
  }

  String _getEmptyStateMessage(String status) {
    switch (status) {
      case 'upcoming':
        return 'No Upcoming Appointments';
      case 'completed':
        return 'No Completed Appointments';
      case 'cancelled':
        return 'No Cancelled Appointments';
      default:
        return 'No Appointments';
    }
  }

  String _getEmptyStateSubMessage(String status) {
    switch (status) {
      case 'upcoming':
        return 'You don\'t have any upcoming appointments.\nBook one now!';
      case 'completed':
        return 'Your completed appointments will appear here.';
      case 'cancelled':
        return 'Your cancelled appointments will appear here.';
      default:
        return '';
    }
  }

  void _cancelAppointment(int appointmentId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancel Appointment'),
        content: Text('Are you sure you want to cancel this appointment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              // Cancel appointment logic
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Appointment cancelled successfully'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _rescheduleAppointment(Map<String, dynamic> appointment) {
    // Navigate to reschedule screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reschedule functionality coming soon'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}