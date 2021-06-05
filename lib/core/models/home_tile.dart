class HomeTile {
  String _title;
  String _image_url;
  String _avatar_url;
  String _username;
  int _favourite;
  double _price;
  int _numSold;

  HomeTile({String title, String image_url, String avatar_url, String username, int favourite, double price, int numSold})
      : _title = title,
        _image_url = image_url,
        _avatar_url = avatar_url,
        _username = username,
        _price = price,
        _numSold = numSold,
        _favourite = favourite;

  String get imageurl {
    return _image_url;
  }

  String get avatarurl {
    return _avatar_url;
  }

  String get username {
    return _username;
  }

  int get numOfFavourites {
    return _favourite;
  }

  String get title {
    return _title;
  }

  double get price {
    return _price;
  }

  int get numSold {
    return _numSold;
  }
}
