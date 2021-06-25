class Item {
  String docId;
  String businessAvatarUrl;
  String businessId;
  String tradingName;
  String categoryId;
  String categoryName;
  DateTime creationDate;
  DateTime lastUpdate;
  String description;
  String lastUpdateByUserId;
  String name;
  int numOfFavs;
  List<String> photoUrl;
  num price;

  Item.fromMap(Map<String, dynamic> data, String docId) {
    docId = docId;
    businessAvatarUrl = data['businessAvatarUrl'];
    businessId = data['businessId'];
    tradingName = data['tradingName'];
    categoryId = data['categoryId'];
    categoryName = data['categoryName'];
    creationDate = DateTime.parse(data['creationDate'].toDate().toString());
    lastUpdate = DateTime.parse(data['lastUpdate'].toDate().toString());
    description = data['description'];
    lastUpdateByUserId = data['lastUpdateByUserId'];
    name = data['name'];
    numOfFavs = data['num_of_favs'];
    photoUrl = List.from(data["photoUrlList"]);
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

  @override
  String toString() {
    return 'Item(docId: $docId, businessAvatarUrl: $businessAvatarUrl, businessId: $businessId, tradingName: $tradingName, categoryId: $categoryId, categoryName: $categoryName, creationDate: $creationDate, lastUpdate: $lastUpdate, description: $description, lastUpdateByUserId: $lastUpdateByUserId, name: $name, numOfFavs: $numOfFavs, photoUrl: $photoUrl, price: $price)';
  }
}
