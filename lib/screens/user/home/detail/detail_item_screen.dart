import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:foodrop/core/models/item.dart';

class DetailItemScreen extends StatefulWidget {
  final Item item;

  DetailItemScreen({this.item});

  @override
  _DetailItemScreenState createState() => _DetailItemScreenState();
}

class _DetailItemScreenState extends State<DetailItemScreen> {
  int _photoIndex = 0;
  bool _isFavorite = false;
  bool _isFollowed = false;
  double _commonSpacing = 8;

  void onPhotoChange(int index) {
    setState(() {
      _photoIndex = index;
    });
  }

  void onFavoriteTapped() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void onFollowTapped() {
    setState(() {
      _isFollowed = !_isFollowed;
    });
  }

  void onAvatorTapped() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.grey[900], title: Text(widget.item.name)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PhotoCarousel(item: widget.item, onChange: onPhotoChange),
              PhotoIndexIndicator(photoLength: widget.item.photoUrlList.length, index: _photoIndex, size: 5),
              SizedBox(height: _commonSpacing),
              Price(newPrice: widget.item.price, oldPrice: widget.item.price * 1.2),
              SizedBox(height: _commonSpacing),
              TitleAndLikes(item: widget.item, isFavorite: _isFavorite, onTap: (item) => onFavoriteTapped()),
              SizedBox(height: _commonSpacing),
              BusinessInformationAndFollowButton(item: widget.item, isFollowed: _isFollowed, onFollowTap: onFollowTapped),
              SizedBox(height: _commonSpacing),
              Text(
                widget.item.description,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoCarousel extends StatelessWidget {
  final Item item;
  final Function(int index) onChange;

  PhotoCarousel({this.item, this.onChange});
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          onChange(index);
        },
        enlargeCenterPage: true,
        viewportFraction: 0.8,
      ),
      items: List.generate(
        item.photoUrlList.length,
        (index) => Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(24))),
          child: Image.network(
            item.photoUrlList[index],
            loadingBuilder: (context, image, chunk) {
              return chunk == null ? image : Center(child: Text("loading...", style: TextStyle(color: Colors.white)));
            },
          ),
        ),
      ),
    );
  }
}

class PhotoIndexIndicator extends StatelessWidget {
  final int photoLength;
  final int index;
  double size;
  PhotoIndexIndicator({
    @required this.photoLength,
    @required this.index,
    this.size = 12,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        photoLength,
        (i) => Container(
          height: size,
          width: size,
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == index ? Colors.red : Colors.grey[500],
          ),
        ),
      ),
    );
  }
}

class Price extends StatelessWidget {
  final num newPrice;
  final double oldPrice;

  Price({
    @required this.newPrice,
    this.oldPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$${newPrice.toDouble().toString()}',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          SizedBox(width: 8),
          RichText(
            text: TextSpan(
              text: "\$${oldPrice.toDouble().toString()}",
              style: TextStyle(decoration: TextDecoration.lineThrough),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleAndLikes extends StatelessWidget {
  final Item item;
  bool isFavorite;
  final Function(Item) onTap;

  TitleAndLikes({
    @required this.item,
    @required this.isFavorite,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Text(
            item.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
            fit: FlexFit.loose,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  onTap(item);
                },
                child: AnimatedContainer(
                  duration: Duration(seconds: 5),
                  child: Icon(
                    Icons.favorite,
                    color: isFavorite ? Colors.red : Colors.white,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}

class BusinessInformationAndFollowButton extends StatelessWidget {
  final Item item;
  bool isFollowed;

  Function() onFollowTap;
  Function() onAvatarTap;

  BusinessInformationAndFollowButton({
    @required this.item,
    this.isFollowed,
    this.onFollowTap,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: CircleAvatar(backgroundImage: NetworkImage(item.businessAvatarUrl)),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 6,
          child: Text(
            item.tradingName,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerRight,
            child: ActionChip(
                onPressed: onFollowTap,
                backgroundColor: isFollowed ? Colors.grey[500] : Colors.red,
                avatar: !isFollowed
                    ? Icon(
                        Icons.add,
                        color: Colors.white,
                      )
                    : null,
                label: Text(
                  isFollowed ? "Followed" : "Follow",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                )),
          ),
        )
      ],
    );
  }
}

class Review extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
