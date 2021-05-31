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

  UserClient.fromMap(Map<String, dynamic> map, String uid)
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

  // Map<String, dynamic> toMap() {
  //   var businessMap = business.toMap();
  //   var uidMap = {'userID': userID};
  //   businessMap.addAll(uidMap);
  //   businessMap.addAll({'role': role, 'id': id, 'phoneNumber': phoneNumber});
  //   return businessMap;
  // }

  UserClient copyWith(
      {String uid,
      String firstName,
      String lastName,
      DateTime dob,
      bool isVendor,
      bool isAnonymous,
      bool signedInViaEmail,
      bool signedInviaGoogle,
      bool signedInViaFaceBook,
      String photoUrl,
      String username,
      String mobileNumber,
      String emailAddress,
      bool
          isMobileVerified, // verification ideally to be done every 6 month to ensure customer detail is up to date.
      bool isEmailVerified}) {
    return UserClient(
        photoUrl: photoUrl ?? this.photoUrl,
        username: username ?? this.username,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        emailAddress: photoUrl ?? this.photoUrl,
        isMobileVerified: isMobileVerified ?? this.isMobileVerified,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        uid: uid ?? this.uid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        dob: dob ?? this.dob,
        isVendor: isVendor ?? this.isVendor,
        isAnonymous: isAnonymous ?? this.isAnonymous,
        signedInViaEmail: signedInViaEmail ?? this.signedInViaEmail,
        signedInviaGoogle: signedInviaGoogle ?? this.signedInviaGoogle,
        signedInViaFaceBook: signedInViaFaceBook ?? this.signedInViaFaceBook);
  }
}
