import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yeeo/pressentation/user/jobModel.dart';

class FireStoreServiceProvider {
  final CollectionReference _serviceCollectionRef =
      FirebaseFirestore.instance.collection('Service');
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Users');

  Future<DocumentSnapshot> getServiceUser(String uid) async {
    return await _userCollectionRef.doc(uid).get();
  }

  Future<List<QueryDocumentSnapshot>> getService() async {
    var value = await _serviceCollectionRef
        .orderBy("timeStamp", descending: true)
        .get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getServices(id, serviceProviderId) async {
    var value = await _serviceCollectionRef
        .doc(id)
        .collection("replys")
        .where("serviceProviderId", isEqualTo: serviceProviderId)
        .get();
    return value.docs;
  }

  addReply(id, provideId, replyModel) async {
    return await _serviceCollectionRef
        .doc(id)
        .collection("replys")
        .doc(provideId)
        .set(replyModel);
  }

  addUnwanted(id, provideId, replyModel) async {
    return await _serviceCollectionRef
        .doc(id)
        .collection("unwanted")
        .doc(provideId);
  }

  addLike(JobModel jobModel) async {
    return await _serviceCollectionRef
        .doc(jobModel.jobId)
        .update({"like": jobModel.like});
  }
}
