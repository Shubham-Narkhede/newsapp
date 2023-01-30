import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../helper/helperColor.dart';

class WidgetShadeImage extends StatefulWidget {
  final double height, width;
  final String? imageUrl;
  WidgetShadeImage({this.height = 230, this.width = 230, this.imageUrl});

  @override
  _WidgetShadeImageState createState() => _WidgetShadeImageState();
}

class _WidgetShadeImageState extends State<WidgetShadeImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          height: widget.height,
          width: widget.width,
          fit: BoxFit.cover,
          imageUrl: widget.imageUrl != null
              ? widget.imageUrl!
              : "http://via.placeholder.com/350x150",
          placeholder: (context, url) => Center(
              child: LoadingAnimationWidget.inkDrop(
            color: HelperColor.colorWhite,
            size: 40,
          )),
          errorWidget: (context, url, error) => Center(
              child: Icon(
            Icons.error,
            color: HelperColor.colorWhite,
          )),
        ),
        Container(
          height: widget.height,
          decoration: const BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                  stops: [
                    0.0,
                    1.0
                  ])),
        )
      ],
    );
  }
}
