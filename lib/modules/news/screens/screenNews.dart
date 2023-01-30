import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/helper/helperColor.dart';
import 'package:news_app/modules/news/providers/providerGetNews.dart';
import 'package:news_app/modules/news/screens/screenNewsListView.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../widget/widgetText.dart';

class ScreenNews extends StatefulWidget {
  @override
  _ScreenNewsState createState() => _ScreenNewsState();
}

class _ScreenNewsState extends State<ScreenNews> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderGetNews>(context, listen: false).getProductsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelperColor.colorBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HelperColor.colorBlack,
        title: widgetText("headlines".toUpperCase(),
            textStyle: textStyle(
                textColor: HelperColor.colorWhite,
                fontWeight: FontWeight.bold,
                fontSize: 29.sp)),
      ),
      body: Consumer<ProviderGetNews>(
        builder: (context, callback, child) {
          if (callback.response.status == "ok") {
            if (callback.response.articles!.isNotEmpty) {
              return ScreenNewsListView(
                news: callback.response,
              );
            } else {
              return Center(
                child: widgetText("No Article Found"),
              );
            }
          } else if (callback.response.status == "error") {
            return Center(
              child: widgetText("Some Error occurred"),
            );
          }
          return Center(
            child: LoadingAnimationWidget.inkDrop(
              color: HelperColor.colorWhite,
              size: 40,
            ),
          );
        },
      ),
    );
  }
}
