import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_metadata.freezed.dart';
part 'user_metadata.g.dart';

@freezed
class UserMetadata with _$UserMetadata {
  const factory UserMetadata({
    required String id,
    required String name,
    required int phoneNumber,
    required int dni,
    required String email,
    required double credit,
    required String accountNumber,
  }) = _UserMetadata;

  factory UserMetadata.fromJson(Map<String, Object?> json) =>
      _$UserMetadataFromJson(json);
}
