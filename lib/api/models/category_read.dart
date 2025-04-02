import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:partdb_scanner/api/models/part_read.dart';
import 'package:partdb_scanner/main.dart';

part 'category_read.g.dart';

final extractCategoryIdRegex = RegExp(r'.*\/api\/categories\/([0-9]*)');

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CategoryRead {
  @JsonKey(name: "@context")
  String context;
  @JsonKey(name: "@id")
  String typeId;
  @JsonKey(name: "@type")
  String type;
  String? parent;
  String? comment;
  String? partnameHint;
  String? partnameRegex;
  bool disableFootprints;
  bool disableManufacturers;
  bool disableAutodatasheets;
  bool disableProperties;
  String? defaultDescription;
  String? defaultComment;
  List<Attachment>? attachments;
  List<dynamic>? parameters;
  @JsonKey(name: "addedDate")
  String addedDate;
  @JsonKey(name: "lastModified")
  String lastModified;
  EdaInfo? edaInfo;
  String name;
  int id;
  String fullPath;

  CategoryRead(
    this.context,
    this.typeId,
    this.type,
    this.parent,
    this.comment,
    this.partnameHint,
    this.partnameRegex,
    this.disableFootprints,
    this.disableManufacturers,
    this.disableAutodatasheets,
    this.disableProperties,
    this.defaultDescription,
    this.defaultComment,
    this.attachments,
    this.parameters,
    this.addedDate,
    this.lastModified,
    this.edaInfo,
    this.name,
    this.id,
    this.fullPath,
  );
  factory CategoryRead.fromJson(Map<String, dynamic> json) =>
      _$CategoryReadFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryReadToJson(this);

  static Future<CategoryRead?> get(int id, Preferences prefs) async {
    final res = await http.get(
      Uri.parse("${prefs.url}/api/categories/$id"),
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
    final part = CategoryRead.fromJson(json);
    return part;
  }

  static int? extractIdFromPath(String path) {
    RegExpMatch? match = extractCategoryIdRegex.firstMatch(path);
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
class EdaInfo {
  @JsonKey(name: "@id")
  String typeId;
  @JsonKey(name: "@type")
  String type;
  bool excludeFromSim;

  EdaInfo(this.typeId, this.type, this.excludeFromSim);

  factory EdaInfo.fromJson(Map<String, dynamic> json) =>
      _$EdaInfoFromJson(json);
  Map<String, dynamic> toJson() => _$EdaInfoToJson(this);
}
