import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference _user =
      FirebaseFirestore.instance.collection('users');
}
