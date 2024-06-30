import 'package:flutter/material.dart';
import 'package:flutterfirebasetest/screens/bottom_nav_screen.dart';
import 'package:flutterfirebasetest/screens/game_screen.dart';
import 'package:flutterfirebasetest/screens/home_screen.dart';
import 'package:flutterfirebasetest/screens/items_screen.dart';
import 'package:flutterfirebasetest/screens/login_screen.dart';
import 'package:flutterfirebasetest/screens/signup_screen.dart';

Route<dynamic> genarateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpScreen());

    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());

    case BottomNavScreen.routeName:
      return MaterialPageRoute(builder: (_) => const BottomNavScreen());

    case GameScreen.routeName:
      return MaterialPageRoute(builder: (_) => const GameScreen());

    case ItemsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ItemsScreen());

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("This route does not exist"),
          ),
        ),
      );
  }
}
