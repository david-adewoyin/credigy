import 'package:credigy/commands/app/bootstrap_command.dart';
import 'package:credigy/models/app_model.dart';
import 'package:credigy/routes.dart';
import 'package:credigy/services/app_service.dart';
import 'package:credigy/views/onboarding/splash_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppModel()),
        Provider(create: (_) => AppService()),
      ],
      builder: (context, _) {
        BootstrapCommand().run(context);
        return MaterialApp(
          title: 'Credigy',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.pink,
          ),
          onGenerateRoute: initialGenerateRoute,
          home: const Scaffold(
            body: SplashScreenPage(),
          ),
        );
      },
    );
  }
}
