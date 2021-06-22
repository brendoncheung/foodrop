class Item {
  String docId;
  String businessAvatarUrl;
  String businessId;
  String categoryId;
  String categoryName;
  DateTime creationDate;
  DateTime lastUpdate;
  String description;
  String lastUpdateByUserId;
  String name;
  int numOfFavs;
  int numSold;
  List<String> photoUrl;
  num price;

  Item.fromMap(Map<String, dynamic> data, String docId) {
    print(data.toString());
    docId = docId;
    businessAvatarUrl = data['avatar_url'];
    businessId = data['business_id'];
    categoryId = data['category_id'];
    categoryName = data['category_name'];
    creationDate = DateTime.parse(data['creation_date'].toDate().toString());
    lastUpdate = DateTime.parse(data['last_update'].toDate().toString());
    lastUpdateByUserId = data['last_update_by_user_id'];
    description = data['description'];
    name = data['name'];
    photoUrl = List.from(data["photo_url"]);
    numOfFavs = data['num_of_favs'];
    numSold = data["num_sold"];
    price = data['price'];
  }

  Map<String, dynamic> toMap() {
    return {
      'doc_id': docId ?? docId,
      'avatar_url': businessAvatarUrl ?? businessAvatarUrl,
      'business_id': businessId ?? businessId,
      'category_id': categoryId ?? categoryId,
      'category_name': categoryName ?? categoryName,
      'creation_date': creationDate ?? creationDate,
      'last_update': lastUpdate ?? lastUpdate,
      'description': description ?? description,
      'last_update_by_user_id': lastUpdateByUserId ?? lastUpdateByUserId,
      'name': name ?? name,
      'num_of_favs': numOfFavs ?? numOfFavs,
      'photo_url': photoUrl ?? photoUrl,
      'price': price ?? price
    };
  }
}
