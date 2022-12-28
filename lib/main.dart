import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'providers/chat_provider.dart';
import 'screens/login_screen.dart';
import 'services/api.dart';
import 'services/navigation_service.dart';

void main() {
  API.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        title: 'Chatting by Teknoborneo',
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        home: const LoginScreen(),
      )
    );
  }
}