// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tutorial_app/components/components.dart';
import 'package:tutorial_app/shop_app/login/shopLoginScreen.dart';
import 'package:tutorial_app/shop_app/shared_preferences/cache_helper.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.body,
    required this.image,
    required this.title,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;

  List<BoardingModel> boarding = [
    BoardingModel(
      body: 'Body 1',
      image: 'assets/images/onboard.png',
      title: 'Title 1',
    ),
    BoardingModel(
      body: 'Body 2',
      image: 'assets/images/onboard.png',
      title: 'Title 2',
    ),
    BoardingModel(
      body: 'Body 3',
      image: 'assets/images/onboard.png',
      title: 'Title 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var pageController = PageController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text(
              'SKIP',
              style: TextStyle(color: Colors.purple),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: ((context, index) =>
                    onBoardingItem(boarding[index])),
                itemCount: boarding.length,
                controller: pageController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                    print('last page');
                  } else {
                    setState(() {
                      isLast = false;
                    });
                    print('not last page');
                  }
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.purple,
                    expansionFactor: 4,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    }

                    pageController.nextPage(
                        duration: Duration(
                          milliseconds: 700,
                        ),
                        curve: Curves.fastOutSlowIn);
                  },
                  child: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateNoBack(context, ShopLoginScreen());
      }
    });
  }

  Widget onBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          model.title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          model.body,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
