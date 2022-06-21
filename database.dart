import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  initiliase() {
    firestore = FirebaseFirestore.instance;
  }
  

  Future<void> create(String name, String desc) async {
    try {
      await firestore.collection("notes").add({
        'name': name,
        'desc': desc,
        'timestamp': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("notes").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await firestore.collection('notes').orderBy('timestamp').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {"id": doc.id, "name": doc['name'], "desc": doc["desc"]};
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> update(String id, String name, String desc) async {
    try {
      await firestore
          .collection("notes")
          .doc(id)
          .update({'name': name, 'desc': desc});
    } catch (e) {
      print(e);
    }
  }
}