import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_model.freezed.dart';
part 'appointment_model.g.dart';

@freezed
class AppointmentModel with _$AppointmentModel {
  const factory AppointmentModel({
    required int id,
    required int userId,
    required int doctorId,
    required String startTime,
    String? endTime,
    String? status,
    String? notes,
    String? cancelReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    DoctorModel? doctor,
    UserModel? user,
  }) = _AppointmentModel;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);
}

@freezed
class AppointmentResponse with _$AppointmentResponse {
  const factory AppointmentResponse({
    required String message,
    required bool status,
    required int code,
    required List<AppointmentModel> data,
  }) = _AppointmentResponse;

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentResponseFromJson(json);
}

@freezed
class CreateAppointmentRequest with _$CreateAppointmentRequest {
  const factory CreateAppointmentRequest({
    required int doctorId,
    required String startTime,
    String? notes,
  }) = _CreateAppointmentRequest;

  factory CreateAppointmentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAppointmentRequestFromJson(json);
}