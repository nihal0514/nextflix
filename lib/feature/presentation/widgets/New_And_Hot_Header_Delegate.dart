import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/utils/Utils.dart';
import 'Netflix_Tab.dart';
import 'ProfileIcon.dart';
class NewAndHotHeaderDelegate extends SliverPersistentHeaderDelegate {
  NewAndHotHeaderDelegate({required this.tabController,required this.profileIndex});

  final TabController tabController;
   int profileIndex;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text('New & Hot',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              Stack(
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(LucideIcons.bell)),
                  Positioned(
                    right: 6.0,
                    top: 2.0,
                    child: Container(
                      padding: const EdgeInsets.all(1.0),
                      constraints: const BoxConstraints(
                        minWidth: 18.0,
                        minHeight: 18.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100.0)),
                      child: const Text(
                        '1',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              IconButton(onPressed: () {
                context.go('/profile');
              }, icon: Builder(builder: (context) {
               // final state = context.watch<ProfileSelectorBloc>().state;
                return ProfileIcon(
                  color: profileColors[profileIndex],
                  iconSize: IconTheme.of(context).size,
                );
              })),
            ],
          ),
        /*  Container(
            height: 50.0,
            child: TabBar(
              controller: tabController,
              indicatorPadding: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              isScrollable: true,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: const Color.fromARGB(255, 248, 248, 248),
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              tabs: const [
                NetflixTab(
                  icon: 'popcorn.png',
                  label: 'Coming Soon',
                ),
                NetflixTab(
                  icon: 'fire.png',
                  label: 'Everyone\'s Watching',
                ),
                NetflixTab(
                  icon: 'controller.png',
                  label: 'Games',
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }

  @override
  double get maxExtent => 70.0;

  @override
  double get minExtent => 70.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
