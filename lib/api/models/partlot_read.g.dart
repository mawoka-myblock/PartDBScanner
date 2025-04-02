// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partlot_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartlotRead _$PartlotReadFromJson(Map<String, dynamic> json) => PartlotRead(
  json['@context'] as String,
  json['@id'] as String,
  json['@type'] as String,
  json['description'] as String?,
  json['comment'] as String?,
  json['instock_unknown'] as bool,
  (json['amount'] as num?)?.toInt(),
  json['needs_refill'] as bool,
  Part.fromJson(json['part'] as Map<String, dynamic>),
  (json['id'] as num).toInt(),
);

Map<String, dynamic> _$PartlotReadToJson(PartlotRead instance) =>
    <String, dynamic>{
      '@context': instance.context,
      '@id': instance.typeId,
      '@type': instance.type,
      'description': instance.description,
      'comment': instance.comment,
      'instock_unknown': instance.instockUnknown,
      'amount': instance.amount,
      'needs_refill': instance.needsRefill,
      'part': instance.part.toJson(),
      'id': instance.id,
    };

Part _$PartFromJson(Map<String, dynamic> json) => Part(
  json['@id'] as String,
  json['@type'] as String,
  json['name'] as String,
  (json['id'] as num).toInt(),
);

Map<String, dynamic> _$PartToJson(Part instance) => <String, dynamic>{
  '@id': instance.typeId,
  '@type': instance.type,
  'name': instance.name,
  'id': instance.id,
};

PartlotUpdate _$PartlotUpdateFromJson(Map<String, dynamic> json) =>
    PartlotUpdate(
      description: json['description'] as String?,
      comment: json['comment'] as String?,
      expirationDate: json['expiration_date'] as String?,
      storageLocation:
          json['storage_location'] == null
              ? null
              : StorageLocation.fromJson(
                json['storage_location'] as Map<String, dynamic>,
              ),
      instockUnknown: json['instock_unknown'] as bool?,
      amount: (json['amount'] as num?)?.toInt(),
      needsRefill: json['needs_refill'] as bool?,
      part: json['part'],
      owner: json['owner'] as String?,
      userBarcode: json['user_barcode'] as String?,
    );

Map<String, dynamic> _$PartlotUpdateToJson(PartlotUpdate instance) =>
    <String, dynamic>{
      if (instance.description case final value?) 'description': value,
      if (instance.comment case final value?) 'comment': value,
      if (instance.expirationDate case final value?) 'expiration_date': value,
      if (instance.storageLocation case final value?) 'storage_location': value,
      if (instance.instockUnknown case final value?) 'instock_unknown': value,
      if (instance.amount case final value?) 'amount': value,
      if (instance.needsRefill case final value?) 'needs_refill': value,
      if (instance.part case final value?) 'part': value,
      if (instance.owner case final value?) 'owner': value,
      if (instance.userBarcode case final value?) 'user_barcode': value,
    };

StorageLocation _$StorageLocationFromJson(Map<String, dynamic> json) =>
    StorageLocation(json['name'] as String);

Map<String, dynamic> _$StorageLocationToJson(StorageLocation instance) =>
    <String, dynamic>{'name': instance.name};
