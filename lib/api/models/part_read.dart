import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:partdb_scanner/main.dart';

part 'part_read.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PartRead {
  @JsonKey(name: "@context")
  String context;
  @JsonKey(name: "@id")
  String typeId;
  @JsonKey(name: "@type")
  String type;
  List<Parameter>? parameters;
  String name;
  List<Attachment>? attachments;
  Attachment? masterPictureAttachment;
  @JsonKey(name: "addedDate")
  String addedDate;
  @JsonKey(name: "lastModified")
  String lastModified;
  int id;
  bool needsReview;
  String? tags;
  ProviderReference? providerReference;
  String? description;
  String? comment;
  bool favorite;
  Category? category;
  Footprint? footprint;
  @JsonKey(name: "partLots")
  List<PartLot>? partLots;
  int minamount;
  Manufacturer? manufacturer;
  String? manufacturerProductUrl;
  String? manufacturerProductNumber;
  String? manufacturerStatus;
  List<OrderDetail>? orderdetails;
  List<dynamic>? associatedPartsAsOwner;
  List<dynamic>? associatedPartsAsOther;
  List<dynamic>? edaInfo;
  int? totalInstock;
  @JsonKey(name: "projectBuildPart")
  bool projectBuildPart;

  PartRead(
    this.context,
    this.typeId,
    this.type,
    this.parameters,
    this.name,
    this.attachments,
    this.masterPictureAttachment,
    this.addedDate,
    this.lastModified,
    this.id,
    this.needsReview,
    this.tags,
    this.providerReference,
    this.description,
    this.comment,
    this.favorite,
    this.category,
    this.footprint,
    this.partLots,
    this.minamount,
    this.manufacturer,
    this.manufacturerProductUrl,
    this.manufacturerProductNumber,
    this.manufacturerStatus,
    this.orderdetails,
    this.associatedPartsAsOwner,
    this.associatedPartsAsOther,
    this.edaInfo,
    this.totalInstock,
    this.projectBuildPart,
  );
  factory PartRead.fromJson(Map<String, dynamic> json) =>
      _$PartReadFromJson(json);
  Map<String, dynamic> toJson() => _$PartReadToJson(this);

  static Future<PartRead?> get(int id, Preferences prefs) async {
    final res = await http.get(
      Uri.parse("${prefs.url}/api/parts/$id"),
      headers: {"Authorization": "Bearer ${prefs.token}"},
    );
    if (res.statusCode == 404) {
      return null;
    }
    if (res.statusCode == 401) {
      throw "unauthenticated";
    }
    if (res.statusCode != 200) {
      throw "Unknown response code: ${res.statusCode}";
    }
    final json = jsonDecode(res.body);
    final part = PartRead.fromJson(json);
    return part;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Parameter {
  @JsonKey(name: "@id")
  String typeId;
  @JsonKey(name: "@type")
  String type;
  String? symbol;
  dynamic unit;
  String? valueText;
  String? group;
  String name;
  int id;
  String formatted;

  Parameter(
    this.typeId,
    this.type,
    this.symbol,
    this.unit,
    this.valueText,
    this.group,
    this.name,
    this.id,
    this.formatted,
  );

  factory Parameter.fromJson(Map<String, dynamic> json) =>
      _$ParameterFromJson(json);
  Map<String, dynamic> toJson() => _$ParameterToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Attachment {
  @JsonKey(name: "@id")
  String typeId;
  @JsonKey(name: "@type")
  String type;
  String? externalPath;
  String name;
  bool showInTable;
  String attachmentType;
  @JsonKey(name: "addedDate")
  String addedDate;
  @JsonKey(name: "lastModified")
  String lastModified;
  int id;
  bool picture;
  @JsonKey(name: "3d_model")
  bool threeDModel;
  bool external;
  bool internal;
  bool private;
  @JsonKey(name: "builtIn")
  bool builtIn;
  String? internalPath;
  String? thumbnailUrl;
  String? mediaUrl;

  Attachment(
    this.typeId,
    this.type,
    this.externalPath,
    this.name,
    this.showInTable,
    this.attachmentType,
    this.addedDate,
    this.lastModified,
    this.id,
    this.picture,
    this.threeDModel,
    this.external,
    this.internal,
    this.private,
    this.builtIn,
    this.internalPath,
    this.thumbnailUrl,
    this.mediaUrl,
  );

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProviderReference {
  @JsonKey(name: "@id")
  String typeId;
  @JsonKey(name: "@type")
  String type;
  String providerKey;
  String providerId;
  String providerUrl;
  String lastUpdated;

  ProviderReference(
    this.typeId,
    this.type,
    this.providerKey,
    this.providerId,
    this.providerUrl,
    this.lastUpdated,
  );
  factory ProviderReference.fromJson(Map<String, dynamic> json) =>
      _$ProviderReferenceFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderReferenceToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Category {
  @JsonKey(name: "@id")
  String typeId;
  @JsonKey(name: "@type")
  String type;
  String name;
  int id;
  String fullPath;

  Category(this.typeId, this.type, this.name, this.id, this.fullPath);
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Footprint {
  @JsonKey(name: "@id")
  String typeId;
  @JsonKey(name: "@type")
  String type;
  String name;
  int id;
  String fullPath;

  Footprint(this.typeId, this.type, this.name, this.id, this.fullPath);
  factory Footprint.fromJson(Map<String, dynamic> json) =>
      _$FootprintFromJson(json);
  Map<String, dynamic> toJson() => _$FootprintToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PartLot {
  @JsonKey(name: "@id")
  String typeId;
  @JsonKey(name: "@type")
  String type;
  String? description;
  String? comment;
  bool instockUnknown;
  int? amount;
  bool needsRefill;
  int id;

  PartLot(
    this.typeId,
    this.type,
    this.description,
    this.comment,
    this.instockUnknown,
    this.amount,
    this.needsRefill,
    this.id,
  );
  factory PartLot.fromJson(Map<String, dynamic> json) =>
      _$PartLotFromJson(json);
  Map<String, dynamic> toJson() => _$PartLotToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Manufacturer {
  @JsonKey(name: "@id")
  String typeId;
  @JsonKey(name: "@type")
  String type;
  String name;
  int id;
  String fullPath;

  Manufacturer(this.typeId, this.type, this.name, this.id, this.fullPath);
  factory Manufacturer.fromJson(Map<String, dynamic> json) =>
      _$ManufacturerFromJson(json);
  Map<String, dynamic> toJson() => _$ManufacturerToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderDetail {
  @JsonKey(name: "@id")
  String typeId;
  @JsonKey(name: "@type")
  String type;
  List<PriceDetail>? priceDetails;
  String supplierpartnr;
  bool obsolete;
  String? supplierProductUrl;
  Supplier supplier;
  int id;

  OrderDetail(
    this.typeId,
    this.type,
    this.priceDetails,
    this.supplierpartnr,
    this.obsolete,
    this.supplierProductUrl,
    this.supplier,
    this.id,
  );
  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PriceDetail {
  @JsonKey(name: "@id")
  String typeId;
  @JsonKey(name: "@type")
  String type;
  String price;
  int priceRelatedQuantity;
  int minDiscountQuantity;
  int id;
  String? pricePerUnit;

  PriceDetail(
    this.typeId,
    this.type,
    this.price,
    this.priceRelatedQuantity,
    this.minDiscountQuantity,
    this.id,
    this.pricePerUnit,
  );
  factory PriceDetail.fromJson(Map<String, dynamic> json) =>
      _$PriceDetailFromJson(json);
  Map<String, dynamic> toJson() => _$PriceDetailToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Supplier {
  @JsonKey(name: "@id")
  String typeId;
  @JsonKey(name: "@type")
  String type;
  String name;
  int id;
  String fullPath;

  Supplier(this.typeId, this.type, this.name, this.id, this.fullPath);
  factory Supplier.fromJson(Map<String, dynamic> json) =>
      _$SupplierFromJson(json);
  Map<String, dynamic> toJson() => _$SupplierToJson(this);
}
