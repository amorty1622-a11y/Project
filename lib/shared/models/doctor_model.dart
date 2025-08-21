import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_model.freezed.dart';
part 'doctor_model.g.dart';

@freezed
class DoctorModel with _$DoctorModel {
  const factory DoctorModel({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String gender,
    String? image,
    String? bio,
    String? experience,
    String? education,
    String? specializations,
    String? languages,
    String? consultationFee,
    String? rating,
    String? reviewCount,
    String? location,
    String? city,
    String? governorate,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DoctorModel;

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);
}

@freezed
class DoctorResponse with _$DoctorResponse {
  const factory DoctorResponse({
    required String message,
    required bool status,
    required int code,
    required List<DoctorModel> data,
  }) = _DoctorResponse;

  factory DoctorResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorResponseFromJson(json);
}

@freezed
class DoctorDetailResponse with _$DoctorDetailResponse {
  const factory DoctorDetailResponse({
    required String message,
    required bool status,
    required int code,
    required DoctorModel data,
  }) = _DoctorDetailResponse;

  factory DoctorDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorDetailResponseFromJson(json);
}