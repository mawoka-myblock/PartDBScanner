import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:partdb_scanner/api/models/part_read.dart';
import 'package:partdb_scanner/main.dart';

part 'partlot_read.g.dart';

final extractPartlotIdRegex = RegExp(r'.*\/api\/part_lots\/([0-9]*)');

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PartlotRead {
  @JsonKey(name: "@context")
  String context;
  @JsonKey(name: "@id")
  String typeId;
  @JsonKey(name: "@type")
  String type;
  String? description;
  String? comment;
  bool instockUnknown;
  int? amount;
  bool needsRefill;
  Part part;
  int id;

  PartlotRead(
    this.context,
    this.typeId,
    this.type,
    this.description,
    this.comment,
    this.instockUnknown,
    this.amount,
    this.needsRefill,
    this.part,
    this.id,
  );
  factory PartlotRead.fromJson(Map<String, dynamic> json) =>
      _$PartlotReadFromJson(json);
  Map<String, dynamic> toJson() => _$PartlotReadToJson(this);

  static Future<PartlotRead?> get(int id, Preferences prefs) async {
    final res = await http.get(
      Uri.parse("${prefs.url}/api/part_lots/$id"),
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
    final part = PartlotRead.fromJson(json);
    return part;
  }

  static int? extractIdFromPath(String path) {
    RegExpMatch? match = extractPartlotIdRegex.firstMatch(path);
    if (match == null) return null;
    final group = match.group(1);
    if (group == null) return null;
    try {
      return int.parse(group);
    } catch (_) {
      return null;
    }
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Part {
  @JsonKey(name: "@id")
  String typeId;
  @JsonKey(name: "@type")
  String type;
  String name;
  int id;

  Part(this.typeId, this.type, this.name, this.id);
  factory Part.fromJson(Map<String, dynamic> json) => _$PartFromJson(json);
  Map<String, dynamic> toJson() => _$PartToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class PartlotUpdate {
  String? description;
  String? comment;
  String? expirationDate;
  StorageLocation? storageLocation;
  bool? instockUnknown;
  int? amount;
  bool? needsRefill;
  dynamic part;
  String? owner;
  String? userBarcode;

  PartlotUpdate({
    this.description,
    this.comment,
    this.expirationDate,
    this.storageLocation,
    this.instockUnknown,
    this.amount,
    this.needsRefill,
    this.part,
    this.owner,
    this.userBarcode,
  });
  factory PartlotUpdate.fromJson(Map<String, dynamic> json) =>
      _$PartlotUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$PartlotUpdateToJson(this);

  Future<PartlotUpdate?> save(int id, Preferences prefs) async {
    final res = await http.patch(
      Uri.parse("${prefs.url}/api/part_lots/$id"),
      headers: {"Authorization": "Bearer ${prefs.token}", "content-type": "application/merge-patch+json"},
      body: jsonEncode(toJson())
    );
    developer.log("Status code: ${res.statusCode}");
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
    final part = PartlotUpdate.fromJson(json);
    return part;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class StorageLocation {
  String name;

  StorageLocation(this.name);
  factory StorageLocation.fromJson(Map<String, dynamic> json) =>
      _$StorageLocationFromJson(json);
  Map<String, dynamic> toJson() => _$StorageLocationToJson(this);
}
