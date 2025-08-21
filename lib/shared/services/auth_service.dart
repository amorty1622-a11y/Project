import 'dart:convert';
import 'package:dio/dio.dart';
import '../../core/di/injection.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  final ApiService _apiService = getIt<ApiService>();
  final StorageService _storageService = getIt<StorageService>();
  
  // Register user
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String gender,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'phone': phone,
        'gender': gender,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });
      
      final response = await _apiService.post('/auth/register', data: formData);
      
      if (response.data['status'] == true) {
        final token = response.data['data']['token'];
        await _storageService.saveToken(token);
        _apiService.setAuthToken(token);
        
        return {
          'success': true,
          'message': response.data['message'],
          'data': response.data['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
  
  // Login user
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
        'password': password,
      });
      
      final response = await _apiService.post('/auth/login', data: formData);
      
      if (response.data['status'] == true) {
        final token = response.data['data']['token'];
        await _storageService.saveToken(token);
        _apiService.setAuthToken(token);
        
        return {
          'success': true,
          'message': response.data['message'],
          'data': response.data['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
  
  // Logout user
  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await _apiService.post('/auth/logout');
      
      await _storageService.deleteToken();
      await _storageService.deleteUser();
      _apiService.removeAuthToken();
      
      return {
        'success': true,
        'message': response.data['message'] ?? 'Logged out successfully',
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
  
  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await _storageService.getToken();
    return token != null;
  }
  
  // Get current token
  Future<String?> getCurrentToken() async {
    return await _storageService.getToken();
  }
  
  // Update user profile
  Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? password,
  }) async {
    try {
      final Map<String, dynamic> data = {};
      if (name != null) data['name'] = name;
      if (email != null) data['email'] = email;
      if (phone != null) data['phone'] = phone;
      if (gender != null) data['gender'] = gender;
      if (password != null) data['password'] = password;
      
      final formData = FormData.fromMap(data);
      final response = await _apiService.post('/user/update', data: formData);
      
      if (response.data['status'] == true) {
        return {
          'success': true,
          'message': response.data['message'],
          'data': response.data['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Profile update failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
  
  // Get user profile
  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final response = await _apiService.get('/user/profile');
      
      if (response.data['status'] == true) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.data['message'] ?? 'Failed to get profile',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
}