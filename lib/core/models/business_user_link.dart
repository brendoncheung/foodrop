class BusinessUserLink {
  BusinessUserLink({
    DateTime creationDate,
    this.userId = "",
    this.businessId = "",
    this.businessLegalName = "",
    this.businessTradingName = "",
    this.isApproved = true,
    this.requestOustanding = false,
    this.userFirstName = "",
    this.userLastName = "",
    this.userName = "",
    this.userPhoneNumber = "",
    this.userRole = "",
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
    };
  }

  BusinessUserLink.fromMap(Map<String, dynamic> data, String linkId)
      : creationDate = data['creationDate'],
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
        userRole = data['userRole'];
}
