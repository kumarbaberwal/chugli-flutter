import 'package:chugli/features/contacts/domain/entities/contact_entity.dart';

class ContactsModel extends ContactEntity {
  ContactsModel({
    required super.id,
    required super.username,
    required super.email,
  });

  factory ContactsModel.fromJson(Map<String, dynamic> json) {
    return ContactsModel(
      id: json['contact_id'],
      username: json['username'],
      email: json['email'],
    );
  }
}
