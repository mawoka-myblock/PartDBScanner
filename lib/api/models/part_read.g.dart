// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartRead _$PartReadFromJson(Map<String, dynamic> json) => PartRead(
  json['@context'] as String,
  json['@id'] as String,
  json['@type'] as String,
  (json['parameters'] as List<dynamic>?)
      ?.map((e) => Parameter.fromJson(e as Map<String, dynamic>))
      .toList(),
  json['name'] as String,
  (json['attachments'] as List<dynamic>?)
      ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
      .toList(),
  json['master_picture_attachment'] == null
      ? null
      : Attachment.fromJson(
        json['master_picture_attachment'] as Map<String, dynamic>,
      ),
  json['addedDate'] as String,
  json['lastModified'] as String,
  (json['id'] as num).toInt(),
  json['needs_review'] as bool,
  json['tags'] as String?,
  json['provider_reference'] == null
      ? null
      : ProviderReference.fromJson(
        json['provider_reference'] as Map<String, dynamic>,
      ),
  json['description'] as String?,
  json['comment'] as String?,
  json['favorite'] as bool,
  json['category'] == null
      ? null
      : Category.fromJson(json['category'] as Map<String, dynamic>),
  json['footprint'] == null
      ? null
      : Footprint.fromJson(json['footprint'] as Map<String, dynamic>),
  (json['partLots'] as List<dynamic>?)
      ?.map((e) => PartLot.fromJson(e as Map<String, dynamic>))
      .toList(),
  (json['minamount'] as num).toInt(),
  json['manufacturer'] == null
      ? null
      : Manufacturer.fromJson(json['manufacturer'] as Map<String, dynamic>),
  json['manufacturer_product_url'] as String?,
  json['manufacturer_product_number'] as String?,
  json['manufacturer_status'] as String?,
  (json['orderdetails'] as List<dynamic>?)
      ?.map((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
      .toList(),
  json['associated_parts_as_owner'] as List<dynamic>?,
  json['associated_parts_as_other'] as List<dynamic>?,
  json['eda_info'] as List<dynamic>?,
  (json['total_instock'] as num?)?.toInt(),
  json['projectBuildPart'] as bool,
);

Map<String, dynamic> _$PartReadToJson(PartRead instance) => <String, dynamic>{
  '@context': instance.context,
  '@id': instance.typeId,
  '@type': instance.type,
  'parameters': instance.parameters?.map((e) => e.toJson()).toList(),
  'name': instance.name,
  'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
  'master_picture_attachment': instance.masterPictureAttachment?.toJson(),
  'addedDate': instance.addedDate,
  'lastModified': instance.lastModified,
  'id': instance.id,
  'needs_review': instance.needsReview,
  'tags': instance.tags,
  'provider_reference': instance.providerReference?.toJson(),
  'description': instance.description,
  'comment': instance.comment,
  'favorite': instance.favorite,
  'category': instance.category?.toJson(),
  'footprint': instance.footprint?.toJson(),
  'partLots': instance.partLots?.map((e) => e.toJson()).toList(),
  'minamount': instance.minamount,
  'manufacturer': instance.manufacturer?.toJson(),
  'manufacturer_product_url': instance.manufacturerProductUrl,
  'manufacturer_product_number': instance.manufacturerProductNumber,
  'manufacturer_status': instance.manufacturerStatus,
  'orderdetails': instance.orderdetails?.map((e) => e.toJson()).toList(),
  'associated_parts_as_owner': instance.associatedPartsAsOwner,
  'associated_parts_as_other': instance.associatedPartsAsOther,
  'eda_info': instance.edaInfo,
  'total_instock': instance.totalInstock,
  'projectBuildPart': instance.projectBuildPart,
};

Parameter _$ParameterFromJson(Map<String, dynamic> json) => Parameter(
  json['@id'] as String,
  json['@type'] as String,
  json['symbol'] as String?,
  json['unit'],
  json['value_text'] as String?,
  json['group'] as String?,
  json['name'] as String,
  (json['id'] as num).toInt(),
  json['formatted'] as String,
);

Map<String, dynamic> _$ParameterToJson(Parameter instance) => <String, dynamic>{
  '@id': instance.typeId,
  '@type': instance.type,
  'symbol': instance.symbol,
  'unit': instance.unit,
  'value_text': instance.valueText,
  'group': instance.group,
  'name': instance.name,
  'id': instance.id,
  'formatted': instance.formatted,
};

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
  json['@id'] as String,
  json['@type'] as String,
  json['external_path'] as String?,
  json['name'] as String,
  json['show_in_table'] as bool,
  json['attachment_type'] as String,
  json['addedDate'] as String,
  json['lastModified'] as String,
  (json['id'] as num).toInt(),
  json['picture'] as bool,
  json['3d_model'] as bool,
  json['external'] as bool,
  json['internal'] as bool,
  json['private'] as bool,
  json['builtIn'] as bool,
  json['internal_path'] as String?,
  json['thumbnail_url'] as String?,
  json['media_url'] as String?,
);

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      '@id': instance.typeId,
      '@type': instance.type,
      'external_path': instance.externalPath,
      'name': instance.name,
      'show_in_table': instance.showInTable,
      'attachment_type': instance.attachmentType,
      'addedDate': instance.addedDate,
      'lastModified': instance.lastModified,
      'id': instance.id,
      'picture': instance.picture,
      '3d_model': instance.threeDModel,
      'external': instance.external,
      'internal': instance.internal,
      'private': instance.private,
      'builtIn': instance.builtIn,
      'internal_path': instance.internalPath,
      'thumbnail_url': instance.thumbnailUrl,
      'media_url': instance.mediaUrl,
    };

ProviderReference _$ProviderReferenceFromJson(Map<String, dynamic> json) =>
    ProviderReference(
      json['@id'] as String,
      json['@type'] as String,
      json['provider_key'] as String,
      json['provider_id'] as String,
      json['provider_url'] as String,
      json['last_updated'] as String,
    );

Map<String, dynamic> _$ProviderReferenceToJson(ProviderReference instance) =>
    <String, dynamic>{
      '@id': instance.typeId,
      '@type': instance.type,
      'provider_key': instance.providerKey,
      'provider_id': instance.providerId,
      'provider_url': instance.providerUrl,
      'last_updated': instance.lastUpdated,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  json['@id'] as String,
  json['@type'] as String,
  json['name'] as String,
  (json['id'] as num).toInt(),
  json['full_path'] as String,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  '@id': instance.typeId,
  '@type': instance.type,
  'name': instance.name,
  'id': instance.id,
  'full_path': instance.fullPath,
};

Footprint _$FootprintFromJson(Map<String, dynamic> json) => Footprint(
  json['@id'] as String,
  json['@type'] as String,
  json['name'] as String,
  (json['id'] as num).toInt(),
  json['full_path'] as String,
);

Map<String, dynamic> _$FootprintToJson(Footprint instance) => <String, dynamic>{
  '@id': instance.typeId,
  '@type': instance.type,
  'name': instance.name,
  'id': instance.id,
  'full_path': instance.fullPath,
};

PartLot _$PartLotFromJson(Map<String, dynamic> json) => PartLot(
  json['@id'] as String,
  json['@type'] as String,
  json['description'] as String?,
  json['comment'] as String?,
  json['instock_unknown'] as bool,
  (json['amount'] as num?)?.toInt(),
  json['needs_refill'] as bool,
  (json['id'] as num).toInt(),
);

Map<String, dynamic> _$PartLotToJson(PartLot instance) => <String, dynamic>{
  '@id': instance.typeId,
  '@type': instance.type,
  'description': instance.description,
  'comment': instance.comment,
  'instock_unknown': instance.instockUnknown,
  'amount': instance.amount,
  'needs_refill': instance.needsRefill,
  'id': instance.id,
};

Manufacturer _$ManufacturerFromJson(Map<String, dynamic> json) => Manufacturer(
  json['@id'] as String,
  json['@type'] as String,
  json['name'] as String,
  (json['id'] as num).toInt(),
  json['full_path'] as String,
);

Map<String, dynamic> _$ManufacturerToJson(Manufacturer instance) =>
    <String, dynamic>{
      '@id': instance.typeId,
      '@type': instance.type,
      'name': instance.name,
      'id': instance.id,
      'full_path': instance.fullPath,
    };

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) => OrderDetail(
  json['@id'] as String,
  json['@type'] as String,
  (json['price_details'] as List<dynamic>?)
      ?.map((e) => PriceDetail.fromJson(e as Map<String, dynamic>))
      .toList(),
  json['supplierpartnr'] as String,
  json['obsolete'] as bool,
  json['supplier_product_url'] as String?,
  Supplier.fromJson(json['supplier'] as Map<String, dynamic>),
  (json['id'] as num).toInt(),
);

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) =>
    <String, dynamic>{
      '@id': instance.typeId,
      '@type': instance.type,
      'price_details': instance.priceDetails,
      'supplierpartnr': instance.supplierpartnr,
      'obsolete': instance.obsolete,
      'supplier_product_url': instance.supplierProductUrl,
      'supplier': instance.supplier,
      'id': instance.id,
    };

PriceDetail _$PriceDetailFromJson(Map<String, dynamic> json) => PriceDetail(
  json['@id'] as String,
  json['@type'] as String,
  json['price'] as String,
  (json['price_related_quantity'] as num).toInt(),
  (json['min_discount_quantity'] as num).toInt(),
  (json['id'] as num).toInt(),
  json['price_per_unit'] as String?,
);

Map<String, dynamic> _$PriceDetailToJson(PriceDetail instance) =>
    <String, dynamic>{
      '@id': instance.typeId,
      '@type': instance.type,
      'price': instance.price,
      'price_related_quantity': instance.priceRelatedQuantity,
      'min_discount_quantity': instance.minDiscountQuantity,
      'id': instance.id,
      'price_per_unit': instance.pricePerUnit,
    };

Supplier _$SupplierFromJson(Map<String, dynamic> json) => Supplier(
  json['@id'] as String,
  json['@type'] as String,
  json['name'] as String,
  (json['id'] as num).toInt(),
  json['full_path'] as String,
);

Map<String, dynamic> _$SupplierToJson(Supplier instance) => <String, dynamic>{
  '@id': instance.typeId,
  '@type': instance.type,
  'name': instance.name,
  'id': instance.id,
  'full_path': instance.fullPath,
};
