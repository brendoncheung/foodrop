class Item {
  Item({
    this.businessAvatarUrl = "",
    this.businessId = "",
    this.categoryId = "",
    this.categoryName = "",
    DateTime creationDate,
    this.description = "",
    this.docId = "",
    DateTime lastUpdate,
    this.lastUpdateByUserId = "",
    this.name = "",
    this.numOfFavs = 0,
    this.photoUrl = "",
    this.price = 0,
  })  : lastUpdate = lastUpdate ?? DateTime.now(),
        creationDate = creationDate ?? DateTime.now();
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
  String photoUrl;
  num price;

  Item.fromMap(Map<String, dynamic> data, String docId) {
    docId = docId;
    businessAvatarUrl = data['businessAvatarUrl'];
    businessId = data['businessId'];
    categoryId = data['categoryId'];
    categoryName = data['categoryName'];
    creationDate = DateTime.parse(data['creationDate'].toDate().toString());
    lastUpdate = DateTime.parse(data['lastUpdate'].toDate().toString());
    description = data['description'];
    lastUpdateByUserId = data['lastUpdateByUserId'];
    name = data['name'];
    numOfFavs = data['num_of_favs'];
    photoUrl = data['photoUrl'];
    price = data['price'];
  }

  Map<String, dynamic> toMap() {
    return {
      'docId': docId ?? docId,
      'businessAvatarUrl': businessAvatarUrl ?? businessAvatarUrl,
      'businessId': businessId ?? businessId,
      'categoryId': categoryId ?? categoryId,
      'categoryName': categoryName ?? categoryName,
      'creationDate': creationDate ?? creationDate,
      'lastUpdate': lastUpdate ?? lastUpdate,
      'description': description ?? description,
      'lastUpdateByUserId': lastUpdateByUserId ?? lastUpdateByUserId,
      'name': name ?? name,
      'num_of_favs': numOfFavs ?? numOfFavs,
      'photoUrl': photoUrl ?? photoUrl,
      'price': price ?? price
    };
  }
}
