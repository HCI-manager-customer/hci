import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hci_manager/models/pharmacyUser.dart';

import '../models/note.dart';

Future<PharmacyUser> getUserByMail(String mail) async {
  return await FirebaseFirestore.instance
      .collection('users')
      .doc(mail)
      .get()
      .then(
    (value) {
      PharmacyUser user =
          PharmacyUser.fromMap(value.data() as Map<String, dynamic>);
      return user;
    },
  );
}

Future markAsFinish(String id) async {
  final db = FirebaseFirestore.instance;
  await db.collection('prescription').doc(id).update({"status": "FINISH"});
}

Future sendMsgChat(String idChat, String msg) async {
  try {
    Note note = Note(
      msg: msg,
      time: DateTime.now(),
      mail: 'customer@cs.com',
      name: 'Customer Support',
    );
    await FirebaseFirestore.instance
        .collection('prescription')
        .doc(idChat)
        .collection('note')
        .add(
          note.toMap(),
        );
  } on Exception catch (e) {
    print(e);
  }
}

void addToCart(String id, String idDrug) {
  try {
    FirebaseFirestore.instance.collection('prescription').doc(id).update({
      "medicines": FieldValue.arrayUnion([idDrug])
    });
  } on Exception catch (e) {
    log(e.toString());
  }
}

void removeFromCart(String id, String idDrug) {
  try {
    FirebaseFirestore.instance.collection('prescription').doc(id).update({
      "medicines": FieldValue.arrayRemove([idDrug])
    });
  } on Exception catch (e) {
    log(e.toString());
  }
}
