import 'package:first_flutter_proj/constants/assetConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../dio_service/listmodel.dart';
import '../constants/textConstants.dart';
import '../main.dart';
import '../poc_materials/singleTon_poc.dart';
import 'CafeView.dart';

class cartViewPage extends StatefulWidget {
  String title;
  cartViewPage(this.title);

  @override
  State<cartViewPage> createState() => _cartViewPageState();
}

class _cartViewPageState extends State<cartViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          Singleton.instance.SelectedIndexValues = [];
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyHomePage()));
          },),
        title: Text(widget.title),
      ),
      body: ListView.builder(itemBuilder: ( context,  index) {
        listmodel currentItem = Singleton.instance.SelectedIndexValues[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                leading: CircleAvatar(child:Image.network(currentItem.Image,height: 25,width: 25,)),
                title: Text(currentItem.Name),
                textColor: Colors.yellowAccent,
                tileColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                trailing: Icon(Icons.delete_forever_rounded),
                onTap: ()=> setState(() {
                  showDialog(context: context,builder: (context) {
                    return AlertDialog(
                      title: const Text("Confirmation"),
                      content: Text(textConstants.ConfirmationToDelete),
                      actions: [
                        FlatButton(
                          color:Colors.red,
                          onPressed: (){
                           setState(() {
                             Singleton.instance.SelectedIndexValues.removeWhere((element) => element==currentItem);
                          Navigator.of(context).pop();
                           if(Singleton.instance.SelectedIndexValues.isEmpty){
                             Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyHomePage()));
                           }});
                        }, child: const Text('Yes',style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,backgroundColor: Colors.redAccent,color: Colors.white54),)),
                        FlatButton(
                          color:Colors.blue,
                          onPressed: (){
                          Navigator.of(context).pop();
                        }, child: const Text('No',style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,backgroundColor: Colors.blueAccent,color: Colors.white54),))
                      ],
                    );
                  });
                  }
              )),
            ),
          ],
        );
      },
        itemCount: Singleton.instance.SelectedIndexValues.length,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: IconButton(icon: SvgPicture.asset(assetConstants.paymentIcon,height: 35,width: 35),
          onPressed: () {
          double totalPrice=0;
          Singleton.instance.SelectedIndexValues.forEach((element) {
            String Price = element.Price.substring(1);
            totalPrice += double.parse(Price);
          });
          String PriceTotal = totalPrice.toStringAsFixed(2);//₹
          showDialog(context: context,builder: (Lcontext) {
            return AlertDialog(
              title: const Text("Confirmation"),
              content: Container(
                height: 60,
                child: Column(
                  children: [
                    Text(textConstants.ConfirmationPayment),
                    Text('Total Price is : $PriceTotal',style: TextStyle(fontWeight:  FontWeight.bold,color: Colors.blueAccent))
                  ],
                ),
              ),
              actions: [
                FlatButton(
                    color: Colors.blue,
                    onPressed: (){
                  setState(() {
                    Singleton.instance.isOrderPlaced = true;
                    Singleton.instance.SelectedIndexValues = [];
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyHomePage()));
                  });
                }, child: const Text('Yes',style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,backgroundColor: Colors.blue,color: Colors.white54),)),
                FlatButton(
                    color: Colors.black,
                    onPressed: (){
                      Singleton.instance.isOrderPlaced = false;
                  Navigator.of(context).pop();
                }, child: const Text('No',style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,backgroundColor: Colors.black,color: Colors.white54),))
              ],
            );
          });
        },),
      ),);
  }
}

