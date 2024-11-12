import 'package:hive/hive.dart';

part 'close_contact_model.g.dart';

@HiveType(typeId: 2)
class CloseContactModel {
  @HiveField(0)
  String? username;

  @HiveField(1)
  int? number;

  CloseContactModel({
    required this.username,
    required this.number,
  });
}
