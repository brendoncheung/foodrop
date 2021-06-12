class APIPath {
  static String userById({String uid}) => 'users/$uid';
  static String businessById({String uid}) => 'businesses/$uid';
  static String businessUserLink() => 'business_user_link/';
  static String businessCategories({String businessId}) {
    //print('businesses/$businessId/category/');
    return 'businesses/$businessId/category';
  }
}
