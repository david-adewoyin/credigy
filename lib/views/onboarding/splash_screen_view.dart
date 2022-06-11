import 'package:credigy/commands/app/bootstrap_command.dart';
import 'package:credigy/models/app_model.dart';
import 'package:credigy/views/home/landing_page.dart';
import 'package:credigy/views/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Stream<bool> stream = BootstrapCommand.poolIsBoosted();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<bool>(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  final isFreshInstall =
                      context.read<AppModel>().isFreshInstall();
                  if (isFreshInstall) return const OnboardingPage();
                  return const LandingPage();
                }
              }
              return Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 200,
                ),
              );
            }) /* FutureBuilder<void>(
        future: future,
        builder: (context, _) {
       
          if (BootstrapCommand.done()) {
            final isFreshInstall = context.read<AppModel>().isFreshInstall();
            if (isFreshInstall) return const OnboardingPage();
            return const LandingPage();
          }
          return Center(
            child: Image.asset(
              "assets/images/logo.png",
              width: 200,
            ),
          );
        },
      ), */
        );
  }
}
