import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nextflix/model/GetTrending.dart';
import 'package:nextflix/screens/NewAndHot/NewAndHotScreen.dart';
import 'package:nextflix/screens/details/MovieDetailsScreen.dart';
import 'package:nextflix/screens/home/Home.dart';
import 'package:nextflix/screens/profile/ProfileSelection.dart';
import 'package:nextflix/utils/Utils.dart';
import 'package:nextflix/widgets/NetflixScaffold.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return  ProfileSelectionScreen();
      },
    ),
    ShellRoute(
      // observers: [_heroController],
      builder: (context, state, child) {
        return NetflixScaffold(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
            name: 'Home',
            path: '/home',
            builder: (BuildContext context, GoRouterState state) {
              return const HomeScreen();
            },
            routes: [
              GoRoute(
                  name: 'TV Shows',
                  path: 'tvshows',
                  builder: (BuildContext context, GoRouterState state) {
                    return HomeScreen(name: state.name);
                  },
),
              GoRoute(
                path: 'details',
                builder: (BuildContext context, GoRouterState state) {
                  final extra = (state.extra as Map<String, dynamic>)['extra'] as Result?;
                  final configExtra= (state.extra as Map<String,dynamic>)['configExtra'];
                  final type= (state.extra as Map<String,dynamic>)['type'];
                  return MovieDetailsScreen(Movie: extra!, configuration: configExtra,type: type);
                },
              ),
            ]),
        GoRoute(
            path: '/newandhot',
            builder: (BuildContext context, GoRouterState state) {
              return const NewAndHotScreen();
            },
            routes: [
            ]),
      ],
    ),
  ],
);
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Netflix',
      theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: backgroundColor,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
            ),
          )),
    );
  }
}
