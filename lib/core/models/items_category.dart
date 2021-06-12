class ItemsCategory {
  ItemsCategory(
      {this.docId,
      this.name,
      this.businessId,
      this.creationDateTime,
      this.index,
      this.isActive,
      this.lastUpdate});
  String docId;
  String name;
  int index;
  String businessId;
  DateTime lastUpdate;
  bool isActive;
  DateTime creationDateTime;

  ItemsCategory.fromMap(Map<String, dynamic> data, String docId)
      : docId = docId,
        name = data['name'],
        index = data['index'],
        businessId = data['businessId'],
        isActive = data['isActive'];
  // lastUpdate = data['lastUpdate'],
  // creationDateTime = data['creationDateTime'];
}
