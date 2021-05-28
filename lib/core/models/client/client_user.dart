class UserClient {
  final String uid;
  final String firstName;
  final String lastName;
  // final String age;
  final DateTime dob;
  final bool isVendor;
  final bool isAnonymous;
  final bool signedInViaEmail;
  final bool signedInviaGoogle;
  final bool signedInViaFaceBook;
  final String photoUrl;
  final String username;
  final String mobileNumber;
  final String emailAddress;
  final bool
      isMobileVerified; // verification ideally to be done every 6 month to ensure customer detail is up to date.
  final bool isEmailVerified;

  UserClient(
      {this.photoUrl,
      this.username,
      this.mobileNumber,
      this.emailAddress,
      this.isMobileVerified,
      this.isEmailVerified,
      this.uid,
      this.firstName,
      this.lastName,
      // this.age,
      this.dob,
      this.isVendor,
      this.isAnonymous,
      this.signedInViaEmail,
      this.signedInviaGoogle,
      this.signedInViaFaceBook});

  UserClient.fromMap(Map<String, dynamic> map)
      : firstName = map['firstname'],
        uid = map['uid'],
        lastName = map['lastname'],
        // age = map['age'],
        dob = map['dob'],
        isAnonymous = map['isAnonymous'],
        signedInViaEmail = map['signedInViaEmail'],
        signedInviaGoogle = map['signedInviaGoogle'],
        signedInViaFaceBook = map['signedInViaFaceBook'],
        photoUrl = map['photoUrl'],
        username = map['username'],
        mobileNumber = map['mobileNumber'],
        emailAddress = map['emailAddress'],
        isMobileVerified = map['isMobileVerified'],
        isEmailVerified = map['isEmailVerified'],
        isVendor = map['vendor'];

//   UserClient copyWith({
//      String uid,
//      String firstName,
//      String lastName,
//     // final String age;
//      DateTime dob,
//      bool isVendor,
//      bool isAnonymous,
//      bool signedInViaEmail,
//      bool signedInviaGoogle;
//      bool signedInViaFaceBook;
//      String photoUrl;
//      String username;
//      String mobileNumber;
//      String emailAddress;
//      bool isMobileVerified; // verification ideally to be done every 6 month to ensure customer detail is up to date.
//      bool isEmailVerified;
// }){ return UserClient(
//       this.photoUrl = photoUrl ?? this.photoUrl
//       this.username=
//       this.mobileNumber=
//       this.emailAddress=
//       this.isMobileVerified=
//       this.isEmailVerified=
//       this.uid=
//       this.firstName=
//       this.lastName=
//       // this.age,
//       this.dob=
//       this.isVendor=
//       this.isAnonymous=
//       this.signedInViaEmail=
//       this.signedInviaGoogle=
//       this.signedInViaFaceBook
//   ); }
}
