import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/contact.dart';

class ContactService {
  final FirebaseFirestore _db;

  ContactService({required FirebaseFirestore db}) : _db = db;

  // get all contacts
  Future<List<Contact>> get myContacts =>
      _db.collection('contacts').orderBy('name').get().then((snapshot) =>
          snapshot.docs.map((doc) => Contact.fromJson(doc.data())).toList());

  // get contact by id
  Future<Contact?> getContact(String contactId) {
    return _db.collection('contacts').doc(contactId).get().then((snapshot) =>
        snapshot.exists
            ? Contact.fromJson(snapshot.data() as Map<String, dynamic>)
            : null);
  }
}
