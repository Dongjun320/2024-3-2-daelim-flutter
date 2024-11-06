import 'package:flutter/material.dart';
import 'package:daelim_project/common/scaffold/app_navigation_rail.dart';
import 'package:daelim_project/routes/app_screen.dart';

class AppScaffold extends StatelessWidget {
  final AppScreen appScreen;
  final Widget child;

  const AppScaffold({
    super.key,
    required this.appScreen,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            AppNavigationRail(
              appScren: appScreen, // 철자도 맞추어야 합니다.
            ),
            Expanded(
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
