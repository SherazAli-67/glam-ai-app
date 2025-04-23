import 'package:flutter/material.dart';
import 'package:glam_ai/res/app_constants.dart';
import 'package:glam_ai/res/app_textstyles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.images});
  final List<String> images;
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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
      animateToMaxMin(max, min, direction, seconds, scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Stack(
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
            child: Container(
              padding: EdgeInsets.only(top: 45, right: 10, left: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.black45,
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
                  Text(appDescription, style: AppTextStyles.regularTextStyle.copyWith(color: Colors.white, fontFamily: appFontFamilyJakarta),)
                ],
              ),
            ),
          )
        ],
      )),
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