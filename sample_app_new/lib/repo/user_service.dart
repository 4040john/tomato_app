import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_app_new/constants/data_keys.dart';
import 'package:sample_app_new/data/user_model.dart';
import 'package:sample_app_new/utils/logger.dart';

class UserService {
  static final UserService _userService = UserService._internal();
  factory UserService() => _userService;
  UserService._internal();

  Future createNewUser(Map<String, dynamic> json, String userKey) async {
    logger.d('json $json');
    logger.d('userKey $userKey');
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    final DocumentSnapshot documentSnapshot = await documentReference.get();

    logger.d('documentSnapshot $documentSnapshot');
    if (!documentSnapshot.exists) {
      await documentReference.set(json);
    }
  }

  Future<UserModel> getUserModel(String userKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
    FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentReference.get();
    UserModel userModel = UserModel.fromSnapshot(documentSnapshot);
    return userModel;
  }

  Future firestoreTest() async {
    FirebaseFirestore.instance
        .collection('TESTING_COLLECTION')
        .add({'testing': 'testing value', 'number': 123123});
    logger.d('succes');
  }

  void fireStoreReadTest() {
    FirebaseFirestore.instance
        .collection('TESTING_COLLECTION')
        .doc('0gQLxK7MMup1IpkOFHZe')
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> value) =>
            logger.d(value.data()));
  }
}
