import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:restaurant_picker/utils/colorSetting.dart';
//https://pub.dev/packages/flutter_card_swiper

Container foodItem(name){
    return Container(
      width: double.infinity,
      //height: 400, 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3, // 佔據 3/4 的空間
            child: Container(
              decoration: BoxDecoration(
                image:DecorationImage(
                image: AssetImage('assets/food/$name.png'),
                fit: BoxFit.fill,
                ),
                color: appColors.onSecond,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              ),
            ),
          // 文字區域
          Expanded(
            flex: 1, // 佔據 1/4 的空間
            child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.topLeft,
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
}

class Swipe extends StatefulWidget {
  @override
  State<Swipe> createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> {

  CardSwiperController controller = CardSwiperController();

  List<Container> cards = [
    foodItem('Ramen'),
    foodItem('Sushi'),
    foodItem('Pizza'),
    foodItem('Hamburger'),
    foodItem('Fried Chicken'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: CardSwiper(
                  controller: controller,
                  cardsCount: cards.length,
                  numberOfCardsDisplayed: 3,
                  backCardOffset: const Offset(40, 40),
                  padding: const EdgeInsets.all(24.0),
                  cardBuilder: (
                    context,
                    index,
                    horizontalThresholdPercentage,
                    verticalThresholdPercentage,
                  ) =>
                      cards[index],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: (){},
                    child: Icon(Icons.keyboard_arrow_left),
                  ),
                  FloatingActionButton(
                    onPressed: (){},
                    child: Icon(Icons.keyboard_arrow_right),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}