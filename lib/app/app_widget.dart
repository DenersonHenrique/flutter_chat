import 'constants/app_string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modules/authentication/pages/auth_app_page.dart';
import 'package:flutter_chat/app/modules/chat/services/chat_notification_service.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = ThemeData();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatNotificationService(),
        ),
      ],
      child: MaterialApp(
        title: AppString.appTitle,
        theme: _themeData.copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: _themeData.colorScheme.copyWith(
            primary: Colors.indigo,
            secondary: Colors.amber,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const AuthAppPage(),
      ),
    );
  }
}
