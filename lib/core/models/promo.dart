import 'package:flutter/material.dart';
import 'package:foodrop/screens/business/promo/promo_form_validators.dart';

enum DeliveryMethod { PickUpInStoreOnly, DineInOnly, NoRestrictions }
enum Benefits { FlatFee, PercentageDiscount, Freebie, Other }

class PromoModel with ChangeNotifier, ValidationMixin {
  PromoModel(
      {this.promoName = '',
      this.promoDescription = '',
      this.promoStartingDateTime,
      this.promoEndingDateTime,
      this.promoMonday = false,
      this.promoTuesday = false,
      this.promoWednesday = false,
      this.promoThursday = false,
      this.promoFriday = false,
      this.promoSaturday = false,
      this.promoSunday = false,
      this.promoEveryDay = false,
      this.restrictionMinPurchase = 0.00,
      //@required this.restrictionItems,
      this.restrictionDeliveryMethod = DeliveryMethod.PickUpInStoreOnly,
      this.hasPassCode = false,
      this.restrictionPassCode = '',
      this.benefitDiscount = false,
      this.discountPercentage = 0.00,
      this.benefitFlatFee = false,
      this.flatFee = 0,
      // this.benefitGetOneFree = false,
      this.benefitOther = false,
      this.selectedBenefit = Benefits.Other,
      this.benefitOtherDescription = ''});

  String promoName;
  String promoDescription;
  DateTime promoStartingDateTime;
  DateTime promoEndingDateTime;
  bool promoMonday;
  bool promoTuesday;
  bool promoWednesday;
  bool promoThursday;
  bool promoFriday;
  bool promoSaturday;
  bool promoSunday;
  bool promoEveryDay;
  double restrictionMinPurchase; // set minimum purchase
  //final List<Product> restrictionItems; // restrict promo to certain products
  DeliveryMethod
      restrictionDeliveryMethod; // restrict to eithe takeaway or dine in
  bool hasPassCode;
  String restrictionPassCode; // restrict to users with the code
  bool benefitDiscount; // can only allow one benefit
  double discountPercentage;
  bool benefitFlatFee; // can only allow one benefit
  double flatFee;
  // bool benefitGetOneFree; // can only allow one benefit
  bool benefitOther;
  Benefits selectedBenefit; // can only allow one benefit
  String benefitOtherDescription;

  void updateWith({
    String promoName,
    String promoDescription,
    DateTime promoStartingDateTime,
    DateTime promoEndingDateTime,
    bool promoMonday,
    bool promoTuesday,
    bool promoWednesday,
    bool promoThursday,
    bool promoFriday,
    bool promoSaturday,
    bool promoSunday,
    bool promoEveryDay,
    double restrictionMinPurchase,
    DeliveryMethod restrictionDeliveryMethod,
    bool hasPassCode,
    String restrictionPassCode,
    bool benefitDiscount,
    double discountPercentage,
    bool benefitFlatFee,
    double flatFee,
    // bool benefitGetOneFree,
    bool benefitOther,
    Benefits selectedBenefits,
    String benefitOtherDescription,
  }) {
    print("inside promo updateWith");

    this.promoName = promoName ?? this.promoName;
    this.promoDescription = promoDescription ?? this.promoDescription;
    this.promoStartingDateTime =
        promoStartingDateTime ?? this.promoStartingDateTime;
    this.promoEndingDateTime = promoEndingDateTime ?? this.promoEndingDateTime;
    this.promoMonday = promoMonday ?? this.promoMonday;
    this.promoTuesday = promoTuesday ?? this.promoTuesday;
    this.promoWednesday = promoWednesday ?? this.promoWednesday;
    this.promoThursday = promoThursday ?? this.promoThursday;
    this.promoFriday = promoFriday ?? this.promoFriday;
    this.promoSaturday = promoSaturday ?? this.promoSaturday;
    this.promoSunday = promoSunday ?? this.promoSunday;
    this.promoEveryDay = promoEveryDay ?? this.promoEveryDay;
    this.restrictionMinPurchase =
        restrictionMinPurchase ?? this.restrictionMinPurchase;
    this.restrictionDeliveryMethod =
        restrictionDeliveryMethod ?? this.restrictionDeliveryMethod;
    this.hasPassCode = hasPassCode ?? this.hasPassCode;
    this.restrictionPassCode = restrictionPassCode ?? this.restrictionPassCode;
    this.benefitDiscount = benefitDiscount ?? this.benefitDiscount;
    this.discountPercentage = discountPercentage ?? this.discountPercentage;
    this.benefitFlatFee = benefitFlatFee ?? this.benefitFlatFee;
    this.flatFee = flatFee ?? this.flatFee;
    // this.benefitGetOneFree = benefitGetOneFree ?? this.benefitGetOneFree;
    this.benefitOther = benefitOther ?? this.benefitOther;
    this.selectedBenefit = selectedBenefits ?? this.selectedBenefit;
    this.benefitOtherDescription =
        benefitOtherDescription ?? this.benefitOtherDescription;
    //print(selectedBenefit == null);
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'promoName': promoName,
      'promoDescription': promoDescription,
      'promo_starting_date': promoStartingDateTime,
      'promo_ending_date': promoEndingDateTime,
      'promoMonday': promoMonday,
      'promoTuesday': promoTuesday,
      'promoWednesday': promoWednesday,
      'promoThursday': promoThursday,
      'promoFriday': promoFriday,
      'promoSaturday': promoSaturday,
      'promoSunday': promoSunday,
      'promoEveryDay': promoEveryDay,
      'restrictionMinPurchase': restrictionMinPurchase,
      'restrictionDeliveryMethod': restrictionDeliveryMethod,
      'restrictionEntryCode': restrictionPassCode,
      'benefitDiscount': benefitDiscount,
      'discountPercentage': discountPercentage,
      'benefitFlatFee': benefitFlatFee,
      'flatFee': flatFee,
      // 'benefitGetOneFree': benefitGetOneFree,
      'benefitOther': benefitOther,
      'benefitOtherDescription': benefitOtherDescription,
    };
  }

// factory Promo.fromMap(Map<dynamic, dynamic> value, String id) {
//   final int startMilliseconds = value['start'];
//   final int endMilliseconds = value['end'];
//   return Promo(
//     id: id,
//     jobId: value['jobId'],
//     start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
//     end: DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
//     comment: value['comment'],
//   );
// }
}
