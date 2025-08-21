import 'package:freezed_annotation/freezed_annotation.dart';

part 'specialization_model.freezed.dart';
part 'specialization_model.g.dart';

@freezed
class SpecializationModel with _$SpecializationModel {
  const factory SpecializationModel({
    required int id,
    required String name,
    String? description,
    String? icon,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SpecializationModel;

  factory SpecializationModel.fromJson(Map<String, dynamic> json) =>
      _$SpecializationModelFromJson(json);
}

@freezed
class SpecializationResponse with _$SpecializationResponse {
  const factory SpecializationResponse({
    required String message,
    required bool status,
    required int code,
    required List<SpecializationModel> data,
  }) = _SpecializationResponse;

  factory SpecializationResponse.fromJson(Map<String, dynamic> json) =>
      _$SpecializationResponseFromJson(json);
}