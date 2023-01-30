import 'package:flutter/material.dart';
import 'package:news_app/modules/news/models/modelNews.dart';
import 'package:news_app/widget/widgetText.dart';
import 'package:sizer/sizer.dart';

import '../../../helper/helperColor.dart';
import '../../../helper/helperCore.dart';
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                  left: size.width * 22 / 360,
                  right: size.width * 22 / 360,
                  bottom: size.width * 5 / 360),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widgetText(widget.item.title!,
                      maxLine: 4,
                      textStyle: textStyle(
                          fontSize: 22.sp,
                          textColor: HelperColor.colorTitle,
                          fontWeight: FontWeight.bold)),
                  Container(
                    margin: EdgeInsets.only(
                        top: size.width * 59 / 360,
                        bottom: size.width * 15 / 360),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: widgetText("${widget.item.author}",
                              maxLine: 2,
                              textStyle: textStyle(
                                textColor: HelperColor.colorTitle,
                                fontSize: 16.sp,
                              )),
                        ),
                        widgetText(
                            "${HelperCore.dateFormat("yyyy/M/d", widget.item.publishedAt!)}",
                            textStyle: textStyle(
                                textColor: HelperColor.colorTitle,
                                fontSize: 16.sp))
                      ],
                    ),
                  ),
                  widgetText(widget.item.content!,
                      maxLine: 7,
                      textStyle: textStyle(
                          fontSize: 11.sp,
                          textColor: HelperColor.colorHelperText))
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: size.width * 18 / 360, top: size.width * 40 / 360),
              height: size.height * 20.7 / 360,
              width: size.height * 20.7 / 360,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black12),
              child: const Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  }
}
