import 'package:cloud_firestore/cloud_firestore.dart';

import 'dto/create_contact_dto.dart';
import 'model/contact.dart';

class ContactService {
  static const currentUserId = 'xxzas';
  final _db = FirebaseFirestore.instance;

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

  // create a new contact
  Future<void> createContact(CreateContactDto dto) async {
    final ref = _db.collection('contacts').doc(dto.id);
    final contact = Contact(
      id: dto.id,
      username: dto.username,
      name: dto.name,
    );
    await ref.set(contact.toJson());
  }
}
