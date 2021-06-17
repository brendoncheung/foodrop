class BusinessUserLink {
  BusinessUserLink({
    DateTime creationDate,
    this.userId,
    this.businessId,
    this.businessLegalName,
    this.businessTradingName,
    this.isApproved,
    this.requestOustanding,
    this.userFirstName,
    this.userLastName,
    this.userName,
    this.userPhoneNumber,
    this.userRole,
    this.documentId,
    this.address,
  }) : creationDate = creationDate ?? DateTime.now();
  DateTime creationDate;
  String businessId;
  String businessLegalName;
  String businessTradingName;
  bool isApproved;
  bool requestOustanding;
  String userFirstName;
  String userLastName;
  String userId;
  String userName;
  String userPhoneNumber;
  String userRole;
  String documentId;
  String address;

  Map<String, dynamic> toMap() {
    return {
      'creationDate': creationDate,
      'businessId': businessId,
      'businessLegalName': businessLegalName,
      'businessTradingName': businessTradingName,
      'isApproved': isApproved,
      'requestOustanding': requestOustanding,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'userId': userId,
      'userName': userName,
      'userPhoneNumber': userPhoneNumber,
      'userRole': userRole,
      'documentId': documentId,
      'address': address
    };
  }

  BusinessUserLink.fromMap(Map<String, dynamic> data, String linkId)
      :
        // creationDate = data['creationDate'],
        businessId = data['businessId'],
        businessLegalName = data['businessLegalName'],
        businessTradingName = data['businessTradingName'],
        isApproved = data['isApproved'],
        requestOustanding = data['requestOustanding'],
        userFirstName = data['userFirstName'],
        userLastName = data['userLastName'],
        userId = data['userId'],
        userName = data['userName'],
        userPhoneNumber = data['userPhoneNumber'],
        userRole = data['userRole'],
        documentId = linkId,
        address = data['address'];
}
