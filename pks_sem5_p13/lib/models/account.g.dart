// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      (json['ID'] as num).toInt(),
      json['Name'] as String,
      json['Email'] as String,
      json['PhoneNumber'] as String,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'ID': instance.ID,
      'Name': instance.Name,
      'Email': instance.Email,
      'PhoneNumber': instance.PhoneNumber,
    };
