import 'package:hive_flutter/hive_flutter.dart';

import '../model/close_contact_model.dart';

class CloseContactService {
  final String _boxName = "CloseContactBox";

  Future<Box<CloseContactModel>> get _box async =>
      await Hive.openBox<CloseContactModel>(_boxName);

//create
  Future<void> addContact(CloseContactModel model) async {
    var box = await _box;
    await box.add(model);
  }

//read
  Future<List<CloseContactModel>> getAllContact() async {
    var box = await _box;
    return box.values.toList();
  }

//update
  Future<void> updateContact(int index, CloseContactModel model) async {
    var box = await _box;
    await box.putAt(index, model);
  }

//delete
  Future<void> deleteContact(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }
}
