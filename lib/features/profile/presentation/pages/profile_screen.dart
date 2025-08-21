import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/services/auth_service.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/custom_button.dart';
import 'edit_profile_screen.dart';
import '../../../auth/presentation/pages/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = getIt<AuthService>();
  Map<String, dynamic>? _userProfile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final result = await _authService.getUserProfile();
      if (result['success'] == true) {
        setState(() {
          _userProfile = result['data'];
        });
      }
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _performLogout();
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  Future<void> _performLogout() async {
    try {
      await _authService.logout();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error logging out: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Profile image
                  Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E88E5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50.w,
                    ),
                  ),
                  
                  SizedBox(height: 20.h),
                  
                  // User name
                  Text(
                    _userProfile?['name'] ?? 'User Name',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  
                  SizedBox(height: 8.h),
                  
                  // User email
                  Text(
                    _userProfile?['email'] ?? 'user@email.com',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  
                  SizedBox(height: 20.h),
                  
                  // Edit profile button
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Edit Profile',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(
                              userProfile: _userProfile,
                            ),
                          ),
                        );
                      },
                      backgroundColor: Colors.grey[100],
                      textColor: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20.h),
            
            // Menu items
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ProfileMenuItem(
                      icon: Icons.medical_services,
                      title: 'Medical History',
                      subtitle: 'View your medical records',
                      onTap: () {
                        // Navigate to medical history
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.favorite,
                      title: 'Favorites',
                      subtitle: 'Your favorite doctors',
                      onTap: () {
                        // Navigate to favorites
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      subtitle: 'Manage your notifications',
                      onTap: () {
                        // Navigate to notifications
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.security,
                      title: 'Privacy & Security',
                      subtitle: 'Manage your account security',
                      onTap: () {
                        // Navigate to privacy settings
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.help,
                      title: 'Help & Support',
                      subtitle: 'Get help and contact support',
                      onTap: () {
                        // Navigate to help
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.info,
                      title: 'About',
                      subtitle: 'App version and information',
                      onTap: () {
                        // Navigate to about
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 20.h),
            
            // Logout button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Logout',
                  onPressed: _logout,
                  backgroundColor: Colors.red[100],
                  textColor: Colors.red[700],
                ),
              ),
            ),
            
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}