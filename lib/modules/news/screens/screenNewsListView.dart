import 'package:flutter/material.dart';
import 'package:news_app/modules/news/models/modelNews.dart';
import 'package:news_app/widget/widgetText.dart';
import 'package:sizer/sizer.dart';

import '../../../helper/helperColor.dart';
import '../../../helper/helperCore.dart';
import '../../../widget/widgetShadeImage.dart';
import '../../newsDetails/screens/screenNewsDetail.dart';

// ScreenNewsListView this class is created to show the listview of news items
class ScreenNewsListView extends StatefulWidget {
  final ModelNews news;
  ScreenNewsListView({required this.news});
  @override
  _ScreenNewsListViewState createState() => _ScreenNewsListViewState();
}

class _ScreenNewsListViewState extends State<ScreenNewsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.news.news!.length,
      itemBuilder: (BuildContext context, int index) {
        News item = widget.news.news![index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ScreenNewsDetail(
                          item: item,
                        )));
          },
          child: Container(
              margin: const EdgeInsets.only(top: 12), child: listItem(item)),
        );
      },
    );
  }

  /// this widget it used to show news item on listview
  Widget listItem(News item) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            color: Colors.black38,
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(4, 4))
      ], borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(
          left: size.width * 15 / 360,
          right: size.width * 15 / 360,
          bottom: size.width * 22 / 360),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                  tag: "Image ${item.title}",
                  child: WidgetShadeImage(
                    imageUrl: item.urlToImage,
                  ))),
          Container(
            margin: EdgeInsets.only(
                left: size.width * 11 / 360, bottom: size.width * 11 / 360),
            child: Column(
              children: [
                widgetText("${item.title}",
                    maxLine: 3,
                    textStyle: textStyle(
                        textColor: HelperColor.colorTitle, fontSize: 16.sp)),
                Container(
                  margin: EdgeInsets.only(top: size.width * 14 / 360),
                  child: Row(
                    children: [
                      Flexible(
                        child: widgetText("${item.author}",
                            maxLine: 2,
                            textStyle: textStyle(
                                textColor: HelperColor.colorHelperText,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: size.width * 10 / 360),
                          child: widgetText(
                              "${HelperCore.dateFormat("yyyy/M/d", item.publishedAt!)}",
                              textStyle: textStyle(
                                  textColor: HelperColor.colorHelperText,
                                  fontSize: 9.sp)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
