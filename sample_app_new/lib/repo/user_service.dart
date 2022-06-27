import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_app_new/utils/logger.dart';

class UserService {
  Future firestoreTest() async {
    FirebaseFirestore.instance
        .collection('TESTING_COLLECTION')
        .add({'testing': 'testing value', 'number': 123123});
    logger.d('succes');
  }
}
