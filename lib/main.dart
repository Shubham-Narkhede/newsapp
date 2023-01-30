import 'package:flutter/material.dart';
import 'package:news_app/modules/news/providers/providerGetNews.dart';
import 'package:provider/provider.dart';

import 'modules/news/screens/screenNews.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ProviderGetNews(),
          ),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'Flutter Stateless Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: ScreenNews(),
            debugShowCheckedModeBanner: false,
          );
        }));
  }
}
