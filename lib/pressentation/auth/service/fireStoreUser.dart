import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yeeo/pressentation/auth/serviceProviderModel.dart';

import '../userModel.dart';

class FireStoreUser {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference _serviceProviderCollectionRef =
      FirebaseFirestore.instance.collection('serviceProvider');
  addUserToFireStore(UserModel userModel) async {
    var v = await _userCollectionRef.doc();
    v.set(userModel.toJson(v.id));
  }

  Future<DocumentSnapshot> getCurrentUser(String uid) async {
    return await _userCollectionRef.doc(uid).get();
  }

  Future<List<QueryDocumentSnapshot>> getUsers() async {
    var value = await _userCollectionRef.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getServiceProviders() async {
    var value = await _serviceProviderCollectionRef.get();
    return value.docs;
  }

  addServiceProviderToFireStore(
      ServiceProviderModel serviceProviderModel) async {
    var v = await _serviceProviderCollectionRef.doc();
    v.set(serviceProviderModel.toJson(v.id));
  }

  Future<DocumentSnapshot> getCurrentServiceProvider(String uid) async {
    return await _serviceProviderCollectionRef.doc(uid).get();
  }

  Future<DocumentSnapshot> signInService(userName) async {
    return await _serviceProviderCollectionRef.doc(userName).get();
  }
}
