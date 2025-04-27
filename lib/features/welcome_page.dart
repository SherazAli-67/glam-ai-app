import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glam_ai/features/home_page.dart';
import 'package:glam_ai/res/app_constants.dart';
import 'package:glam_ai/res/app_icons.dart';
import 'package:glam_ai/res/app_textstyles.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.images});
  final List<String> images;
  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final ScrollController _scrollController3 = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double min1 = _scrollController1.position.minScrollExtent;
      double max1 = _scrollController1.position.maxScrollExtent;

      double min2 = _scrollController2.position.minScrollExtent;
      double max2 = _scrollController2.position.maxScrollExtent;

      double min3 = _scrollController3.position.minScrollExtent;
      double max3 = _scrollController3.position.maxScrollExtent;

      // Row 1 - Start downwards
      animateToMaxMin(max1, min1, max1, 8, _scrollController1);

      // Row 2 - Start upwards (reverse scroll)
      animateToMaxMin(max2, min2, min2, 10, _scrollController2);

      // Row 3 - Start downwards
      animateToMaxMin(max3, min3, max3, 12, _scrollController3);
    });
  }

  animateToMaxMin(double max, double min, double direction, int seconds, ScrollController scrollController) {
    scrollController
        .animateTo(direction,
        duration: Duration(seconds: seconds), curve: Curves.linear)
        .then((value) {
      direction = direction == max ? min : max;
      if(scrollController.hasClients){
        animateToMaxMin(max, min, direction, seconds, scrollController);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        children: [
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: MoviesListView(
                  scrollController: _scrollController1,
                  images: widget.images,
                ),
              ),
              Expanded(
                child:  MoviesListView(
                  scrollController: _scrollController2,
                  images: widget.images,
                ),
              ),
              Expanded(
                child:  MoviesListView(
                  scrollController: _scrollController3,
                  images: widget.images,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Card(
              color: Colors.white,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 30, right: 10, left: 10),
                child: Column(
                  spacing: 15,
                  children: [
                    Text("Welcome to GLAMS AI", style: AppTextStyles.largeTextStyle,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(appDescription, textAlign: TextAlign.center,),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=> HomePage()), (value)=> false);
                        _scrollController1.dispose();
                        _scrollController2.dispose();
                        _scrollController3.dispose();
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          backgroundColor: Colors.white
                      ),
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppIcons.icGoogle, height: 25,),
                          Text("Continue with Google", style: AppTextStyles.titleTextStyle,)
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15),
                        backgroundColor: Colors.black
                      ),
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppIcons.icApple, height: 25, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),),
                          Text("Continue with Apple", style: AppTextStyles.titleTextStyle.copyWith(color: Colors.white),)
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          backgroundColor: Colors.blueAccent
                      ),
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppIcons.icFacebook, height: 25,),
                          Text("Continue with Facebook", style: AppTextStyles.titleTextStyle.copyWith(color: Colors.white),)
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          backgroundColor: Colors.white
                      ),
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppIcons.icMail, height: 25,),
                          Text("Continue with Email", style: AppTextStyles.titleTextStyle.copyWith(color: Colors.black),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
            
            /*Container(
              padding: EdgeInsets.only(top: 45, right: 10, left: 10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black
                      ])
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Welcome to\n', style: AppTextStyles.largeTextStyle.copyWith(color: Colors.white, fontFamily: appFontFamilyJakarta,)
                        ),
                        TextSpan(
                            text: 'Turn Me Into ', style: AppTextStyles.largeTextStyle.copyWith(color: Colors.white, fontFamily: appFontFamilyJakarta, fontSize: 45)
                        ),
                      ]
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 100, top: 10),
                    child: Text(appDescription, style: AppTextStyles.regularTextStyle.copyWith(color: Colors.white, fontFamily: appFontFamilyJakarta),),
                  )
                ],
              ),
            ),*/
          )
        ],
      )
    );
  }
}

class MoviesListView extends StatelessWidget {
  final ScrollController scrollController;
  final List<String> images;

  const MoviesListView({
    super.key,
    required this.scrollController,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height, // Set how much height this vertical list will take
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.vertical, // ✅ changed to vertical
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                images[index],
                fit: BoxFit.cover,
                height: size.height*0.2,
              ),
            )
          );
        },
      ),
    );
  }
}