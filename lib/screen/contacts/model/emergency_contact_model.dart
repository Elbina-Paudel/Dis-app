import 'package:hive/hive.dart';

part 'emergency_contact_model.g.dart';

@HiveType(typeId: 1)
class EmergencyContactModel {
  @HiveField(0)
  String? fullname;

  @HiveField(1)
  int? number;

  @HiveField(2)
  String? address;
}
