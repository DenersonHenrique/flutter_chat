import 'constants/app_string.dart';
import 'package:flutter/material.dart';
import 'common/pages/loading_page.dart';
import 'modules/authentication/pages/auth_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = ThemeData();

    return MaterialApp(
      title: AppString.appTitle,
      theme: _themeData.copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: _themeData.colorScheme.copyWith(
          primary: Colors.indigo,
          secondary: Colors.amber,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
    );
  }
}
