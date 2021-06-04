class HomeTile {
  String _title;
  String _image_url;
  String _avatar_url;
  String _username;
  int _favourite;

  HomeTile({String title, String image_url, String avatar_url, String username, int favourite})
      : _title = title,
        _image_url = image_url,
        _avatar_url = avatar_url,
        _username = username,
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
}
