import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yeeo/pressentation/serviceProvider/replyModel.dart';
import 'package:yeeo/pressentation/serviceProvider/serviceModel.dart';
import 'package:yeeo/pressentation/user/jobModel.dart';

late List<String> x = [];

class FireStoreServiceProvider {
  final CollectionReference _serviceCollectionRef =
      FirebaseFirestore.instance.collection('Service');
  final CollectionReference _replyCollectionRef =
      FirebaseFirestore.instance.collection('Reply');
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Users');

  Future<DocumentSnapshot> getServiceUser(String uid) async {
    return await _userCollectionRef.doc(uid).get();
  }

  Stream<List<JobModel>> getService(service, serviceProviderId) {
    return _serviceCollectionRef
        .where("service", isEqualTo: service)
        .orderBy("timeStamp", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<JobModel> jobModel = [];

      for (var jobModelq in query.docs) {
        final jobModels = JobModel.fromJson(jobModelq);
        if (jobModels.repledIds.contains(serviceProviderId)) {
          x.add(jobModels.jobId);
        } else {
          jobModel.add(jobModels);
        }
      }

      return jobModel;
    });
  }

  Stream<List<ReplyModel>> getOngoing(serviceProviderId, service) {
    return _replyCollectionRef
        .where("serviceProviderId", isEqualTo: serviceProviderId)
        .where("service", isEqualTo: service)
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

  addReply(id, provideId, replyModel, JobModel jobModel) async {
    return await _replyCollectionRef.doc().set(replyModel).then((value) =>
        _serviceCollectionRef
            .doc(id)
            .update({"repledIds": jobModel.repledIds}));
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
