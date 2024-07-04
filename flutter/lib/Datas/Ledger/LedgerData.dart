// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:quick_log_money/Datas/Ledger/Entry/TagData.dart';
// import 'package:quick_log_money/Datas/Ledger/Entry/TagGroupData.dart';
// import 'package:quick_log_money/Utilities/Def.dart';

// /// 账本数据
// @JsonSerializable(anyMap: true)
// class LedgerData {
//   final int Id;
//   final int Type;
//   final int OwnerUser;
//   final String Name;
//   final String Icon;
//   final bool IsHided;
//   final List<TagGroupData> TagGroups;
//   final Map<int, TagData> AllTags;
//   final List<int>? MoreUsers;
//   const LedgerData(
//       {required this.Id,
//       required this.Type,
//       required this.OwnerUser,
//       this.Name = "",
//       this.Icon = "",
//       this.MoreUsers,
//       this.IsHided = false,
//       required this.TagGroups,
//       required this.AllTags});

//   ///从配置模板创建数据
//   static Future<LedgerData> CreateFromTemplate(int OwnerUser, {String? Name}) async {
//     final jsonMap = jsonDecode(await rootBundle.loadString(Def.LedgerTemplatePath)) as Map;
//     jsonMap["OwnerUser"] = OwnerUser;
//     if (Name != null) jsonMap["Name"] = Name;
//     int index = 0;
//     final tagGroups = List<dynamic>.empty(growable: true);
//     final allTags = <String, dynamic>{};
//     final jsonTags = jsonMap["Tags"] as Map<String, dynamic>;
//     jsonTags.forEach((key, value) {
//       final tagGroup = TagGroupData(key, List<int>.filled(value.length, 0));
//       for (var i = 0; i < value.length; i++) {
//         final tagJson = value[i] as List;
//         final id = ++index;
//         tagGroup.Tags[i] = id;
//         allTags[id.toString()] = TagData(tagJson[0], tagJson[1]).toJson();
//       }
//       tagGroups.add(tagGroup.toJson());
//     });
//     jsonMap.remove("Tags");
//     jsonMap["TagGroups"] = tagGroups;
//     jsonMap["AllTags"] = allTags;
//     return LedgerData.fromJson(jsonMap);
//   }
// }
