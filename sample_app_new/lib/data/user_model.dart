import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class UserModel {
  //late: 필수값이 필요한 부분에 대해서 이따 데이터를 넣겠다는 약속(null로 안남기겠다)
  late String userKey;
  late String phoneNumber;
  late String address;
  late GeoFirePoint geoFirePoint;
  late DateTime createdDate;
  DocumentReference? reference;

  UserModel({
    required this.userKey,
    required this.phoneNumber,
    required this.address,
    required this.geoFirePoint,
    required this.createdDate,
    this.reference,
  });

  // UserModel.fromJson(Map<String, dynamic> json, this.userKey, this.reference) {
  //   // // userKey = json['userKey'];
  //   phoneNumber = json['phoneNumber'];
  //   address = json['address'];
  //   geoFirePoint = GeoFirePoint((json['geoFirePoint']['geopoint']).latitude,
  //       (json['geoFirePoint']['geopoint']).longitude);
  //   createdDate = json['createdDate'] == null
  //       ? DateTime.now().toUtc()
  //       : (json['createdDate'] as Timestamp).toDate();
  //  // // reference = json['reference'];
  // }

  //: => initialized 뒤 에 나올 constructor body 보다 먼저 실행,
  UserModel.fromJson(Map<String, dynamic> json, this.userKey, this.reference):
        phoneNumber = json['phoneNumber'],
        address = json['address'],
        geoFirePoint = GeoFirePoint((json['geoFirePoint']['geopoint']).latitude,
            (json['geoFirePoint']['geopoint']).longitude),
        createdDate = json['createdDate'] == null
            ? DateTime.now().toUtc()
            : (json['createdDate'] as Timestamp).toDate();



  //: => initialized 뒤 에 나올 constructor body 보다 먼저 실행,
  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userKey'] = userKey;
    map['phoneNumber'] = phoneNumber;
    map['address'] = address;
    map['geoFirePoint'] = geoFirePoint.data;
    map['createdDate'] = createdDate;
    map['reference'] = reference;
    return map;
  }
}
