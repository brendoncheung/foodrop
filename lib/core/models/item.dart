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
    this.num_of_favs = 0,
    List<String> photoUrlList,
    this.price = 0,
  })  : lastUpdate = lastUpdate ?? DateTime.now(),
        creationDate = creationDate ?? DateTime.now(),
        photoUrlList = photoUrlList ?? [];

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
  int num_of_favs;
  List<String> photoUrlList;
  num price;

  Item.fromMap(Map<String, dynamic> data, String docId) {
    this.docId = data['docId'];
    this.businessAvatarUrl = data['businessAvatarUrl'];
    this.businessId = data['businessId'];
    this.tradingName = data['tradingName'];
    this.categoryId = data['categoryId'];
    this.categoryName = data['categoryName'];
    this.creationDate =
        DateTime.parse(data['creationDate'].toDate().toString());
    this.lastUpdate = DateTime.parse(data['lastUpdate'].toDate().toString());
    this.description = data['description'];
    this.lastUpdateByUserId = data['lastUpdateByUserId'];
    this.name = data['name'];
    this.num_of_favs = data['num_of_favs'];
    this.photoUrlList = List.from(data["photoUrlList"]);
    this.price = data['price'];
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
      'num_of_favs': num_of_favs ?? num_of_favs,
      'photoUrlList': photoUrlList ?? photoUrlList,
      'price': price ?? price
    };
  }

  @override
  String toString() {
    return 'Item(docId: $docId, businessAvatarUrl: $businessAvatarUrl, businessId: $businessId, tradingName: $tradingName, categoryId: $categoryId, categoryName: $categoryName, creationDate: $creationDate, lastUpdate: $lastUpdate, description: $description, lastUpdateByUserId: $lastUpdateByUserId, name: $name, numOfFavs: $num_of_favs, photoUrl: $photoUrlList, price: $price)';
  }
}
