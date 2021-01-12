class UserClient {
  final String uid;
  final String firstName;
  final String lastName;
  final String age;
  final DateTime dob;
  final bool isVendor;

  UserClient({
    this.uid,
    this.firstName,
    this.lastName,
    this.age,
    this.dob,
    this.isVendor,
  });

  UserClient.fromMap(Map<String, dynamic> map)
      : firstName = map['firstname'],
        uid = map['uid'],
        lastName = map['lastname'],
        age = map['age'],
        dob = map['dob'],
        isVendor = map['vendor'];
}
