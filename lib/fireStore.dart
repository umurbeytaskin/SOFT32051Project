import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreManager {
  static final FirestoreManager instance = FirestoreManager._();
  FirestoreManager._();

  String table = "main";

  CollectionReference<dynamic> _collection() =>
      FirebaseFirestore.instance.collection(this.table);

  Future<void> add(final String key, final Map<String, dynamic> value) async {
    _collection().doc(key).set(value);
  }

  Future<bool> contains(final String key) async {
    final DocumentSnapshot<dynamic> snapshot =
        await _collection().doc(key).get();
    return snapshot.exists;
  }

  Future<Map<String, dynamic>?> find(
    final bool Function(Map<String, dynamic> value) filter,
  ) async {
    final QuerySnapshot<dynamic> querySnapshot = await _collection().get();
    for (final QueryDocumentSnapshot<dynamic> document in querySnapshot.docs) {
      final Map<String, dynamic> value =
          document.data() as Map<String, dynamic>;
      if (filter(value)) {
        return value;
      }
    }
  }

  Future<Map<String, dynamic>> get(final String key) async {
    final DocumentSnapshot<dynamic> snapshot =
        await _collection().doc(key).get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<Iterable<Map<String, dynamic>>> getAll() async {
    final List<Map<String, dynamic>> result = <Map<String, dynamic>>[];
    final QuerySnapshot<dynamic> querySnapshot = await _collection().get();
    for (final QueryDocumentSnapshot<dynamic> document in querySnapshot.docs) {
      result.add(document.data() as Map<String, dynamic>);
    }
    return result;
  }

  Future<void> remove(final String key) async {
    await _collection().doc(key).delete();
  }

  Future<void> removeAll() async {
    final QuerySnapshot<dynamic> querySnapshot = await _collection().get();
    for (final QueryDocumentSnapshot<dynamic> document in querySnapshot.docs) {
      await document.reference.delete();
    }
  }

  Future<void> update(
    final String key,
    final Map<String, dynamic> value,
  ) async {
    await _collection().doc(key).set(value);
  }
}
