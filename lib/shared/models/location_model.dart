import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

@freezed
class GovernorateModel with _$GovernorateModel {
  const factory GovernorateModel({
    required int id,
    required String name,
    String? code,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _GovernorateModel;

  factory GovernorateModel.fromJson(Map<String, dynamic> json) =>
      _$GovernorateModelFromJson(json);
}

@freezed
class CityModel with _$CityModel {
  const factory CityModel({
    required int id,
    required String name,
    required int governorateId,
    String? code,
    DateTime? createdAt,
    DateTime? updatedAt,
    GovernorateModel? governorate,
  }) = _CityModel;

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
}

@freezed
class GovernorateResponse with _$GovernorateResponse {
  const factory GovernorateResponse({
    required String message,
    required bool status,
    required int code,
    required List<GovernorateModel> data,
  }) = _GovernorateResponse;

  factory GovernorateResponse.fromJson(Map<String, dynamic> json) =>
      _$GovernorateResponseFromJson(json);
}

@freezed
class CityResponse with _$CityResponse {
  const factory CityResponse({
    required String message,
    required bool status,
    required int code,
    required List<CityModel> data,
  }) = _CityResponse;

  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      _$CityResponseFromJson(json);
}