// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferImpl _$$TransferImplFromJson(Map<String, dynamic> json) =>
    _$TransferImpl(
      id: (json['id'] as num).toInt(),
      amount: (json['amount'] as num).toDouble(),
      userNote: json['userNote'] as String?,
      name: json['name'] as String,
      phoneNumber: (json['phoneNumber'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isPositive: json['isPositive'] as bool,
    );

Map<String, dynamic> _$$TransferImplToJson(_$TransferImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'userNote': instance.userNote,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'createdAt': instance.createdAt.toIso8601String(),
      'isPositive': instance.isPositive,
    };
