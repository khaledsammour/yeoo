import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yeeo/pressentation/serviceProvider/replyModel.dart';
import 'package:yeeo/pressentation/user/jobModel.dart';

class FireStoreService {
  final CollectionReference _serviceCollectionRef =
      FirebaseFirestore.instance.collection('Service');
  final CollectionReference _serviceProviderCollectionRef =
      FirebaseFirestore.instance.collection('serviceProvider');

  Future<DocumentSnapshot> getServiceProviderUser(String uid) async {
    return await _serviceProviderCollectionRef.doc(uid).get();
  }

  Future<void> addServiceToFirestore(JobModel jobModel) async {
    var v = _serviceCollectionRef.doc();
    v.set(jobModel.toJson(v.id));
  }

  Future<List<QueryDocumentSnapshot>> getServices(String uid) async {
    var value =
        await _serviceCollectionRef.where("userId", isEqualTo: uid).get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getReplys(String uid) async {
    var value = await _serviceCollectionRef
        .doc(uid)
        .collection("replys")
        .orderBy("timeStamp", descending: true)
        .get();
    return value.docs;
  }

  void acceptOrder(serviceId, serviceProviderId) async {
    return await _serviceCollectionRef
        .doc(serviceId)
        .collection("replys")
        .doc(serviceProviderId)
        .update({"accepted": "true"});
  }

  addLike(ReplyModel replyModel) async {
    return await _serviceCollectionRef
        .doc(replyModel.jobId)
        .collection("replys")
        .doc(replyModel.serviceProviderId)
        .update({"like": replyModel.like});
  }
}
