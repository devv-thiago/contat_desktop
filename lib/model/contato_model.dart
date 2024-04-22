import 'package:contacts_service/contacts_service.dart';

class ContatoModel {
  // Name
  String displayName, givenName, middleName, prefix, suffix, familyName;

  // Company
  String company, jobTitle;

  List<Item> emails = [];

// Phone numbers
  List<Item> phones = [];

// Post addresses
  List<PostalAddress> postalAddresses = [];

  ContatoModel(
      this.displayName,
      this.givenName,
      this.middleName,
      this.prefix,
      this.suffix,
      this.familyName,
      this.company,
      this.jobTitle,
      this.emails,
      this.phones,
      this.postalAddresses);
}