import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/Utils.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  int _currentIndex = 0;

  List<List<String>> listCarouselString = [
    ["Unlimited \nentertainment,\none low price","All of Netflix,starting at just  \n₹149"],
    ["Download and \nwatch offline","Always have something to watch"],
    ["Cancel online \nany time","Join today,no reason to wait"],
    ["Watch \neverywhere","Stream on your phone,tablet,laptop,TV \nand more"]
  ];
  CarouselController _carouselController = CarouselController();


  @override
  void initState() {
   // loadSharedPreferences();
    super.initState();
  }


  /*void loadSharedPreferences() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isGetStarted = prefs.getBool('getstarted') ?? false;
    if(isGetStarted== true){
      GoRouter.of(context).go('/profile');
    }
  }*/
  void saveDataSharedPreferences() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("getstarted", true);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:
          Stack(
            children: [
          //    Image.asset('assets/netflix_bg.jpg',width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
              Stack(
                      alignment: Alignment.topCenter,
                      children: [
              Container(
                margin: EdgeInsets.only(left: 5, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/netflix_logo.png',
                      height: 52.0,
                      fit: BoxFit.fitHeight,
                    ),
                    Row(
                      children: [
                        Text(
                          "Privacy",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Log In",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      height: MediaQuery.of(context).size.height,
                      enableInfiniteScroll: false,
                    ),
                    items: listCarouselString.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height,
                              child: listCarouselWidget(i[0],i[1]));
                        },
                      );
                    }).toList(),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          listCarouselString.length,
                          (index) => GestureDetector(
                            onTap: (){
                              setState(() {
                                _currentIndex= index;
                                print(_currentIndex);
                              });
                              _carouselController.animateToPage(
                                index,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                              child: buildIndicator(index)),
                        ),
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () {
                          saveDataSharedPreferences();
                          GoRouter.of(context).go('/profile');

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // No border radius
                          ),
                        ),

                        child:Container(
                          width: 300,
                          child: Center(
                            child: Text('Get Started',style: TextStyle(color: Colors.white),),
                          ),
                        ),

                      ),
                      SizedBox(height: 5,),
                    ],
                  ),
                ],
              ),
                      ],
                    ),
            ],
          )),
    );
  }

  Widget buildIndicator(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: _currentIndex == index ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? redColor : Colors.grey,
      ),
    );
  }

  Widget listCarouselWidget(String text,String subtext) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                  softWrap: true,
                ),
                SizedBox(height: 20,),
                Text(
                  subtext,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white60,),
                ),
              ],
            )),
      ],
    );
  }
}
