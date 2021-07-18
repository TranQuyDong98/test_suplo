import 'package:flutter/material.dart';
import 'package:test_suplo/data/model/model.dart';
import 'package:test_suplo/routes.dart';
import 'package:test_suplo/ui/screens.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Routes.initScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == Routes.postScreen) {
          final String userId = settings.arguments;
          return MaterialPageRoute(
            builder: (_) => PostScreen(
              userId,
            ),
          );
        }
        if (settings.name == Routes.postDetailScreen) {
          List<dynamic> argument = settings.arguments;
          final String userId = argument[1];
          final Post post = argument[0];
          return MaterialPageRoute(
            builder: (_) => PostDetailScreen(
              userId,
              post,
            ),
          );
        }
        return null;
      },
      routes: Routes.routes,
    );
  }
}
