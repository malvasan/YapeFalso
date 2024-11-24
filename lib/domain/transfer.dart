import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer.freezed.dart';
part 'transfer.g.dart';

@freezed
class Transfer with _$Transfer {
  const factory Transfer({
    required int id,
    required double amount,
    required String? userNote,
    required String name,
    required int phoneNumber,
    required DateTime createdAt,
    required bool isPositive,
  }) = _Transfer;

  factory Transfer.fromJson(Map<String, Object?> json) =>
      _$TransferFromJson(json);
}
