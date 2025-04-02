// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryRead _$CategoryReadFromJson(Map<String, dynamic> json) => CategoryRead(
  json['@context'] as String,
  json['@id'] as String,
  json['@type'] as String,
  json['parent'] as String?,
  json['comment'] as String?,
  json['partname_hint'] as String?,
  json['partname_regex'] as String?,
  json['disable_footprints'] as bool,
  json['disable_manufacturers'] as bool,
  json['disable_autodatasheets'] as bool,
  json['disable_properties'] as bool,
  json['default_description'] as String?,
  json['default_comment'] as String?,
  (json['attachments'] as List<dynamic>?)
      ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
      .toList(),
  json['parameters'] as List<dynamic>?,
  json['addedDate'] as String,
  json['lastModified'] as String,
  json['eda_info'] == null
      ? null
      : EdaInfo.fromJson(json['eda_info'] as Map<String, dynamic>),
  json['name'] as String,
  (json['id'] as num).toInt(),
  json['full_path'] as String,
);

Map<String, dynamic> _$CategoryReadToJson(CategoryRead instance) =>
    <String, dynamic>{
      '@context': instance.context,
      '@id': instance.typeId,
      '@type': instance.type,
      'parent': instance.parent,
      'comment': instance.comment,
      'partname_hint': instance.partnameHint,
      'partname_regex': instance.partnameRegex,
      'disable_footprints': instance.disableFootprints,
      'disable_manufacturers': instance.disableManufacturers,
      'disable_autodatasheets': instance.disableAutodatasheets,
      'disable_properties': instance.disableProperties,
      'default_description': instance.defaultDescription,
      'default_comment': instance.defaultComment,
      'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
      'parameters': instance.parameters,
      'addedDate': instance.addedDate,
      'lastModified': instance.lastModified,
      'eda_info': instance.edaInfo?.toJson(),
      'name': instance.name,
      'id': instance.id,
      'full_path': instance.fullPath,
    };

EdaInfo _$EdaInfoFromJson(Map<String, dynamic> json) => EdaInfo(
  json['@id'] as String,
  json['@type'] as String,
  json['exclude_from_sim'] as bool,
);

Map<String, dynamic> _$EdaInfoToJson(EdaInfo instance) => <String, dynamic>{
  '@id': instance.typeId,
  '@type': instance.type,
  'exclude_from_sim': instance.excludeFromSim,
};
