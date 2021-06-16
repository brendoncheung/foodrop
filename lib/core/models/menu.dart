class Menu {
  String _title;

  String _image_url;
  String _avatar_url;
  String _business_id;
  String _business_name;
  String _description;
  String _lastUpdated;
  String _creationDate;
  int _favourite;
  int _numSold;
  double _price;
  List<String> _review_id;

  Menu.fromMap(Map<String, dynamic> map) {
    map['title'] = _title;
    map['image_url'] = _image_url;
    map['avatar_url'] = _avatar_url;
    map['business_id'] = _business_id;
    map['business_name'] = _business_name;
    map['description'] = _description;
    map['lastUpdated'] = _lastUpdated;
    map['creationDate'] = _creationDate;
    map['favorites'] = _favourite;
    map['sold'] = _numSold;
    map['price'] = _price;
    map['reviews'] = _review_id;
  }

  String get title => this._title;

  set title(String value) => this._title = value;
  get image_url => this._image_url;

  set image_url(value) => this._image_url = value;

  get avatar_url => this._avatar_url;

  set avatar_url(value) => this._avatar_url = value;

  get business_id => this._business_id;

  set business_id(value) => this._business_id = value;

  get business_name => this._business_name;

  set business_name(value) => this._business_name = value;

  get description => this._description;

  set description(value) => this._description = value;

  get lastUpdated => this._lastUpdated;

  set lastUpdated(value) => this._lastUpdated = value;

  get creationDate => this._creationDate;

  set creationDate(value) => this._creationDate = value;

  get favourite => this._favourite;

  set favourite(value) => this._favourite = value;

  get numSold => this._numSold;

  set numSold(value) => this._numSold = value;

  get price => this._price;

  set price(value) => this._price = value;

  get review_id => this._review_id;

  set review_id(value) => this._review_id = value;

  @override
  String toString() {
    return 'Menu(_title: $_title, _image_url: $_image_url, _avatar_url: $_avatar_url, _business_id: $_business_id, _business_name: $_business_name, _description: $_description, _lastUpdated: $_lastUpdated, _creationDate: $_creationDate, _favourite: $_favourite, _numSold: $_numSold, _price: $_price, _review_id: $_review_id)';
  }
}
