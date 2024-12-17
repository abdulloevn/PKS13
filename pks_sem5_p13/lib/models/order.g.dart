// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      (json['ID'] as num).toInt(),
      (json['UserID'] as num).toInt(),
      (json['Total'] as num).toInt(),
      (json['OrderItems'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      DateTime.parse(json['CreatedAt'] as String),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'ID': instance.ID,
      'UserID': instance.UserID,
      'Total': instance.Total,
      'CreatedAt': instance.CreatedAt.toIso8601String(),
      'OrderItems': instance.OrderItems,
    };
