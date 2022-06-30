import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hci_manager/models/pharmacyUser.dart';

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
