import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/Utils.dart';
import '../../bloc/netflix_bloc.dart';
import '../../widgets/ProfileIcon.dart';
import 'AddProfile.dart';

class ProfileSelectionScreen extends StatefulWidget {


  const ProfileSelectionScreen({super.key});

  @override
  State<ProfileSelectionScreen> createState() => _ProfileSelectionScreenState();
}

class _ProfileSelectionScreenState extends State<ProfileSelectionScreen> {
  final NetflixBloc netflixBloc = NetflixBloc();

  @override
  void initState() {
    netflixBloc.add(ShowAllUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        GoRouter.of(context).go('/');
        return false;

      },
      child: BlocConsumer(
        bloc: netflixBloc,
        listener: (context, state) {

        },
        builder: (context, state) {
          if(state is ShowUserList){
            return Scaffold(
              appBar: AppBar(
                title: Image.asset(
                  'assets/netflix_logo.png',
                  height: 52.0,
                  fit: BoxFit.fitHeight,
                ),
                centerTitle: true,
                actions: [
                  IconButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddProfile()),
                    );
                  }, icon: const Icon(LucideIcons.pencil))
                ],
                elevation: 0.0,
              ),
              body: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Who\'s Watching?',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  GridView.builder(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 32.0,
                          crossAxisSpacing: 8.0,
                          crossAxisCount: 2),
                      itemCount: state.users.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () async {
                            final SharedPreferences prefs = await SharedPreferences
                                .getInstance();
                            await prefs.setInt('profileIndex', index);
                            context.go('/home');
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: AspectRatio(
                                      aspectRatio: 1,
                                      child: ProfileIcon(
                                        color: profileColors[index],
                                      )),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(state.users[index].name)
                            ],
                          ),
                        );
                      }),
                ],
              ),
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}

class Smile extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var center = size / 2;
    var paint = Paint()
      ..color = Colors.white;

    canvas.drawCircle(Offset(size.width * .20, center.height * .50),
        size.shortestSide * .05, paint);

    canvas.drawCircle(Offset(size.width * .80, center.height * .50),
        size.shortestSide * .05, paint);

    var startPoint = Offset(size.width * .25, size.height / 2);
    var controlPoint1 = Offset(size.width * .3, size.height / 1.6);
    var controlPoint2 = Offset(size.width * .6, size.height / 1.6);
    var endPoint = Offset(size.width * .8, size.height / 2);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);

    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    path.cubicTo(size.width * .8, size.height / 2, size.width * .86,
        size.height / 2, size.width * .8, size.height / 1.8);

    path.cubicTo(size.width * .6, size.height / 1.4, size.width * .3,
        size.height / 1.46, size.width * .25, size.height / 1.7);

    path.cubicTo(size.width * .25, size.height / 1.68, size.width * .18,
        size.height / 2, size.width * .25, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(Smile oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(Smile oldDelegate) => false;
}

