// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserMetadataImpl _$$UserMetadataImplFromJson(Map<String, dynamic> json) =>
    _$UserMetadataImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: (json['phoneNumber'] as num).toInt(),
      dni: (json['dni'] as num).toInt(),
      email: json['email'] as String,
      credit: (json['credit'] as num).toDouble(),
      accountNumber: json['accountNumber'] as String,
    );

Map<String, dynamic> _$$UserMetadataImplToJson(_$UserMetadataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'dni': instance.dni,
      'email': instance.email,
      'credit': instance.credit,
      'accountNumber': instance.accountNumber,
    };
