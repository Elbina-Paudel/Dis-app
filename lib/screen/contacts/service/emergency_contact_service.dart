import 'package:hive_flutter/hive_flutter.dart';

import '../model/emergency_contact_model.dart';

class EmergencyContactService {
  final String _boxName = "emergencyContactBox";

  Future<Box<EmergencyContactModel>> get _box async =>
      await Hive.openBox<EmergencyContactModel>(_boxName);

//create
  Future<void> addContact(EmergencyContactModel model) async {
    var box = await _box;
    await box.add(model);
  }

//read
  Future<List<EmergencyContactModel>> getAllContact() async {
    var box = await _box;
    return box.values.toList();
  }

//update
  Future<void> updateContact(int index, EmergencyContactModel model) async {
    var box = await _box;
    await box.putAt(index, model);
  }

//delete
  Future<void> deleteContact(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }
}
