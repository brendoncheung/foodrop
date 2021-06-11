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
  String index;
  String businessId;
  DateTime lastUpdate;
  bool isActive;
  DateTime creationDateTime;

  ItemsCategory.fromMap(Map<String, dynamic> data, String docId) {
    docId = data['docId'];
    name = data['name'];
    index = data['index'];
    businessId = data['businessId'];
    lastUpdate = data['lastUpdate'];
    isActive = data['isActive'];
    creationDateTime = data['creationDateTime'];
  }
}
