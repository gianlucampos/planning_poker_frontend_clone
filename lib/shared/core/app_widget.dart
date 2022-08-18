import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/desktop/home/home_page_desktop.dart';
import 'package:planning_poker_flutter/mobile/home/home_page_mobile.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ResponsiveLayout(
          desktop: HomePageDesktop(),
          mobile: HomePageMobile(),
        ));
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget desktop;
  final Widget mobile;
  static const mobileHeight = 780;
  static const mobileWidth = 760;

  const ResponsiveLayout({
    required this.desktop,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= mobileWidth || constraints.maxHeight <= mobileHeight) {
          return mobile;
        }
        return desktop;
      },
    );
  }
}