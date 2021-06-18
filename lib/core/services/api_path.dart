class APIPath {
  static String userById({String uid}) => 'users/$uid';
  static String businessById({String uid}) => 'businesses/$uid';
  static String businessUserLink() => 'business_user_link/';
  static String businessCategories({String businessId}) =>
      'businesses/$businessId/category';
  static String businessCategory({String businessId, String docId}) =>
      'businesses/$businessId/category/$docId';
  static String businessItems({String businessId}) =>
      'businesses/$businessId/items';
  static String items() => 'items';
  static String itemByDocId({String docId}) => 'items/$docId';
  static String itemByBusinessIdAndDocId({String businessId, String itemId}) =>
      'businesses/$businessId/items/$itemId';
}
