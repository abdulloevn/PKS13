// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopItem _$ShopItemFromJson(Map<String, dynamic> json) => ShopItem(
      (json['ID'] as num).toInt(),
      json['Name'] as String,
      json['Category'] as String,
      (json['PriceRubles'] as num).toInt(),
      json['ImageHref'] as String,
      json['Description'] as String,
    );

Map<String, dynamic> _$ShopItemToJson(ShopItem instance) => <String, dynamic>{
      'ID': instance.ID,
      'Name': instance.Name,
      'Category': instance.Category,
      'PriceRubles': instance.PriceRubles,
      'ImageHref': instance.ImageHref,
      'Description': instance.Description,
    };
