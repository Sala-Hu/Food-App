import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../dio_service/listmodel.dart';

class cardsexample extends StatelessWidget {
  late List<listmodel> detailedFoods;
  cardsexample(this.detailedFoods);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 10),
        itemCount: detailedFoods.length,
        itemBuilder: ( context,  index)
        {
          listmodel detailedFood = detailedFoods[index];
          return GestureDetector(
            child: Container(
              child: Column(
                children: [
                  Image.asset(detailedFood.Image,),
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [SvgPicture.asset('assets/veg.svg',height: 15,width: 25,color: Colors.green,),Text(detailedFood.Name)],)
                ],
              ),
            ),
          );
        },
    ),
    );
  }
}
