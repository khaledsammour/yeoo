import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yeeo/pressentation/serviceProvider/replyModel.dart';
import 'package:yeeo/pressentation/user/jobModel.dart';

class FireStoreService {
  final CollectionReference _serviceCollectionRef =
      FirebaseFirestore.instance.collection('Service');
  final CollectionReference _replyCollectionRef =
      FirebaseFirestore.instance.collection('Reply');
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
    var v = await _serviceCollectionRef.where("userId", isEqualTo: uid).get();
    return v.docs;
  }

  Stream<List<ReplyModel>> getReplys(service) {
    return _replyCollectionRef
        .where("service", isEqualTo: service)
        .orderBy("timeStamp", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<ReplyModel> replyModel = [];
      for (var replyModelq in query.docs) {
        final replyModels = ReplyModel.fromJson(replyModelq);
        replyModel.add(replyModels);
      }

      return replyModel;
    });
  }

  void acceptOrder(replyModelId) async {
    return await _replyCollectionRef
        .doc(replyModelId)
        .update({"accepted": "true"});
  }

  addLike(ReplyModel replyModel) async {
    return await _replyCollectionRef
        .doc(replyModel.replyId)
        .update({"like": replyModel.like});
  }
}
