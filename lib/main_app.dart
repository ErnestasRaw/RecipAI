import 'package:flutter/material.dart';
import 'package:receptai/components/theme/sizes.dart';
import 'package:receptai/components/theme/theme.dart';
import 'package:receptai/controllers/routing/navigator_utils.dart';
import 'package:receptai/controllers/user_controller.dart';
import 'package:receptai/globals.dart';
import 'package:receptai/helpers/logger_helper.dart';
import 'package:receptai/views/app/home_view.dart';
import 'package:receptai/views/start/auth_view.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Widget _determineHomePage(BuildContext context) {
    if (!UserController().isLoggedIn) return const AuthView();

    return const HomeView();
  }

  void _onFirstBuild(BuildContext context) {
    if (appInitCompleter.isCompleted) {
      xlog('WARNING', tag: 'MainApp._onFirstBuild', error: '_onFirstBuild called when appInitCompleter isCompleted');
      return;
    }

    appInitCompleter.complete();
    xlog('appInitCompleter completed', tag: 'MainApp');

    setState(() {
      Sizes.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receptai',
      initialRoute: 'Home',
      navigatorKey: navigatorKey,
      theme: appTheme,
      locale: const Locale('en', 'EN'),
      debugShowCheckedModeBanner: false,
      routes: {
        "Home": (context) {
          final child = _determineHomePage(context);
          xlog('Going home to: ${child.runtimeType}', tag: 'MainApp');
          return child;
        }
      },
      onGenerateRoute: (RouteSettings settings) {
        xlog('Generating route: ${settings.name}', tag: 'MainApp.onGenerateRoute');
        return null;
      },
      builder: (context, child) {
        if (!appInitCompleter.isCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!appInitCompleter.isCompleted) _onFirstBuild(context);
          });
        }
        return child ?? _determineHomePage(context);
      },
    );
  }
}
