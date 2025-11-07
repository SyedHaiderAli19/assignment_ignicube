import 'package:assignment_ignicube/screens/screen_a.dart';
import 'package:assignment_ignicube/screens/screen_b.dart';
import 'package:assignment_ignicube/screens/screen_c.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final GoRouter routes = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const ScreenA()),
        GoRoute(
          path: '/b',
          builder: (context, state) {
            final Map<String, dynamic>? params =
                state.extra as Map<String, dynamic>?;
            return ScreenB(params: params);
          },
        ),
        GoRoute(path: '/c', builder: (context, state) => const ScreenC()),
      ],
    );
    return MaterialApp.router(routerConfig: routes);
  }
}
