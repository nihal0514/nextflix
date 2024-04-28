import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nextflix/feature/data/model/GetTrending.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/Utils.dart';
import 'feature/presentation/screens/NewAndHot/NewAndHotScreen.dart';
import 'feature/presentation/screens/details/MovieDetailsScreen.dart';
import 'feature/presentation/screens/getStarted/GetStartedScreen.dart';
import 'feature/presentation/screens/home/Home.dart';
import 'feature/presentation/screens/profile/ProfileSelection.dart';
import 'feature/presentation/screens/search/SearchScreen.dart';
import 'feature/presentation/screens/videoPlayer/VideoPlayerScreen.dart';
import 'feature/presentation/widgets/NetflixScaffold.dart';

bool isGetStarted= false;
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  isGetStarted = prefs.getBool('getstarted') ?? false;
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
   MyApp({super.key});

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

   final GoRouter _router = GoRouter(
     routes: <RouteBase>[

       if(isGetStarted)
         GoRoute(
         path: '/',
         builder: (BuildContext context, GoRouterState state) {
           //return  ProfileSelectionScreen();
           return ProfileSelectionScreen();
         },
       ),
       if(!isGetStarted)
         GoRoute(
           path: '/',
           builder: (BuildContext context, GoRouterState state) {
             //return  ProfileSelectionScreen();
             return GetStartedScreen();
           },
         ),

       GoRoute(
         path: '/profile',
         builder: (BuildContext context, GoRouterState state) {
           //return  ProfileSelectionScreen();
           return ProfileSelectionScreen();
         },
       ),
       GoRoute(
           path: '/video',
           builder: (BuildContext context, GoRouterState state) {
             final extra =
             (state.extra as Map<String, dynamic>)['extra'] as Result?;
             final configExtra =
             (state.extra as Map<String, dynamic>)['configExtra'];
             final type = (state.extra as Map<String, dynamic>)['type'];
             return  VideoPlayerScreen(Movie: extra!, configuration: configExtra, type: type);
           }),
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
                       final extra =
                       (state.extra as Map<String, dynamic>)['extra'] as Result?;
                       final configExtra =
                       (state.extra as Map<String, dynamic>)['configExtra'];
                       final type = (state.extra as Map<String, dynamic>)['type'];
                       return MovieDetailsScreen(
                           Movie: extra!, configuration: configExtra, type: type);
                     },
                     routes: [

                     ]

                 ),

                 /*   GoRoute(
                  path: '/video',
                  builder: (BuildContext context, GoRouterState state) {
                    return const VideoPlayerScreen();
                  })*/
               ]),
           GoRoute(
               path: '/newandhot',
               builder: (BuildContext context, GoRouterState state) {
                 return const NewAndHotScreen();
               },
               routes: []),
           GoRoute(
               path: '/try',
               builder: (BuildContext context, GoRouterState state) {
                 return const NewAndHotScreen();
               },
               routes: []),
           GoRoute(
               path: '/search',
               builder: (BuildContext context, GoRouterState state) {
                 return const SearchScreen();
               },
               routes: []),
           /*  GoRoute(
            path: '/video',
            builder: (BuildContext context, GoRouterState state) {
              return const VideoPlayerScreen();
            },
            routes: [
            ])*/
         ],
       ),
     ],
   );


}
