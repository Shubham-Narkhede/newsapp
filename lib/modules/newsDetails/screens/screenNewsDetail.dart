import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/modules/news/models/modelNews.dart';

import '../../../helper/helperColor.dart';
import '../../../widget/widgetShadeImage.dart';

class ScreenNewsDetail extends StatefulWidget {
  final Article item;
  ScreenNewsDetail({required this.item});
  @override
  _ScreenNewsDetailState createState() => _ScreenNewsDetailState();
}

class _ScreenNewsDetailState extends State<ScreenNewsDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Hero(
              tag: "Image ${widget.item.title}",
              child: WidgetShadeImage(
                imageUrl: widget.item.urlToImage,
                height: size.height,
                width: size.width,
              )),
              
        ],
      ),
    );
  }
}
