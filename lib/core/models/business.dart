import 'package:flutter/cupertino.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';

import 'UserProfile.dart';

enum Cusine { European, Chinese, Korean, Japanese, Indian, Other }
enum Operation { Food, Service }

class Business with ChangeNotifier {
  Business(
      {this.uid,
      this.legalName = "",
      this.tradingName = "",
      this.chineseName = "",
      this.isCompany = true,
      this.companyNumber = "",
      this.streetAddress = "",
      this.suburb = "",
      this.city = "",
      this.cuisineType = "Other",
      this.operationType = "Food",
      this.auth});
  String uid;
  String legalName;
  String tradingName;
  String chineseName;
  bool isCompany;
  String companyNumber;
  String streetAddress;
  String suburb;
  String city;
  String cuisineType;
  String operationType;
  AuthenticationService auth;

  void updateWith(
      {String legalName,
      String tradingName,
      String mobilDisplayEnglishName,
      String mobilDisplayChineseName,
      bool isCompany,
      String companyNumber,
      String streetAddress,
      String suburb,
      String city,
      String cuisineType,
      String operationType}) {
    print("insider business.updateWith");
    this.legalName = legalName ?? this.legalName;
    this.tradingName = tradingName ?? this.tradingName;
    this.chineseName = mobilDisplayChineseName ?? this.chineseName;
    this.isCompany = isCompany ?? this.isCompany;
    this.companyNumber = companyNumber ?? this.companyNumber;
    this.streetAddress = streetAddress ?? this.streetAddress;
    this.suburb = suburb ?? this.suburb;
    this.city = city ?? this.city;
    this.cuisineType = cuisineType ?? this.cuisineType;
    this.operationType = operationType ?? this.operationType;
    notifyListeners();
  }

  Business.fromMap(Map<String, dynamic> map, String uid)
      : uid = uid,
        legalName = map['legalName'],
        tradingName = map['tradingName'],
        chineseName = map['chineseName'],
        isCompany = map['isCompany'],
        companyNumber = map['companyNumber'],
        streetAddress = map['streetAddress'],
        suburb = map['suburb'],
        city = map['city'],
        operationType = map['operationType'],
        cuisineType = map['cuisineType'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'legalName': legalName,
      'tradingName': tradingName,
      'chineseName': chineseName,
      'isCompany': isCompany,
      'companyNumber': companyNumber,
      'streetAddress': streetAddress,
      'suburb': suburb,
      'city': city,
      'cuisineType': cuisineType,
      'operationType': operationType,
    };
  }

  Cusine getCuisineType(String text) {
    switch (text) {
      case "Korean":
        {
          // statements;
          return Cusine.Korean;
        }
        break;

      case "Chinese":
        {
          //statements;
          return Cusine.Chinese;
        }
        break;

      case "Japanese":
        {
          //statements;
          return Cusine.Japanese;
        }
        break;

      case "Indian":
        {
          //statements;
          return Cusine.Indian;
        }
        break;

      case "European":
        {
          //statements;
          return Cusine.European;
        }
        break;

      default:
        {
          //statements;
          return Cusine.Other;
        }
        break;
    }
  }
}
