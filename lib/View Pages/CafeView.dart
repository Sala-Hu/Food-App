import 'package:first_flutter_proj/constants/textConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../dio_service/listmodel.dart';
import '../constants/assetConstants.dart';
import '../main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import  '../model/customIcons.dart';
import '../poc_materials/singleTon_poc.dart';
import 'cart_viewpage.dart';

class gridViewList extends StatefulWidget {
  String title;
  List<listmodel> listModel;
  gridViewList(this.title,this.listModel);

  @override
  State<gridViewList> createState() => _gridViewListState();
}

class _gridViewListState extends State<gridViewList> {
    late int initListCount;
    late List<int> _list;
    late List<bool> _selected;
    int _selectedIndex = 0;
    @override
    void initState() {
      initListCount = widget.listModel.length;
      _list=List.generate(initListCount, (i) => i);
      _selected=List.generate(initListCount, (i) => false);
    }

   MyApp myappObject = MyApp();
   Color cardColor = Colors.black87;
   Color selectedCardColor = Colors.black54;
   @override
  Widget build(BuildContext context) {
     widget.listModel.removeWhere((element) => element.Name=="Ginger Lemon Ice Tea");
    return
      // appBar: AppBar(
      //     automaticallyImplyLeading: false,
      //   title: Text(widget.title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.tealAccent),),
      //     actions: [
      //       InkWell(
      //           onTap: (){
      //             if(widget.SelectedIndexValues.isNotEmpty) {
      //               Navigator.push(context, MaterialPageRoute(builder: (context) =>  cartViewPage(textConstants.CartTitle,widget.SelectedIndexValues,widget.listModel)));
      //             } else{
      //             null;
      //             }
      //             },
      //           child: SvgPicture.asset(assetConstants.AddToCartIcon,height: 40,width: 40,color: Colors.yellow,))]
      // ),
      //body:
      Container(
          color: Colors.white54,
          child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10),
                itemCount: widget.listModel.length,
                itemBuilder: ( context,  index) {
                  listmodel cafeDetail = widget.listModel[index];
                  return GridTile(
                    child: InkWell(
                      onTap: () { setState(() {
                        _selected[index] = !_selected[index];
                        if(_selected[index]) {
                          Singleton.instance.SelectedIndexValues.add(widget.listModel[index]);
                        }
                        else{
                          Singleton.instance.SelectedIndexValues.removeWhere((element) => element==widget.listModel[index]);
                        }
                      });
                        },
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(5),

                        ),
                        color:  Singleton.instance.SelectedIndexValues.contains(widget.listModel[index]) ? selectedCardColor :cardColor,
                        child:  SizedBox(
                          height: MediaQuery.of(context).size.height*3,
                          child: Tooltip(
                            message: cafeDetail.Name,
                            child: Column(
                                  children: [
                                    Center(child: Image.network(cafeDetail.Image,width: 90,height: 80,fit: BoxFit.fill,)),
                                    Container(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: SvgPicture.asset('assets/veg.svg',height: 20,width: 20,color: Colors.green ),
                                        ),
                                        Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Text(overflow: TextOverflow.ellipsis,cafeDetail.Name,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.lightBlue,fontSize: 10)),
                                            ),
                                        ),
                                        Expanded(
                                             child: Padding(
                                               padding: const EdgeInsets.all(2.0),
                                               child: Text(overflow: TextOverflow.ellipsis,cafeDetail.Price,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.yellowAccent,fontSize: 10)),
                                             ),
                                          ),
                                        ],
                                ),
                                  ],
                      ),
                          ),
                        ),
                    )),
                  );
                }
              )
            );
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.emoji_food_beverage),
        //       label: 'Available Beverages',
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: Colors.amber[800],
        //   onTap: _onItemTapped,
        // )


          }

           colorChange(){
              cardColor = Colors.black87;
          }
}

//
// child: ClipRRect(
// borderRadius: BorderRadius.circular(4.0),
// child:  decoration: const BoxDecoration(
//                                       borderRadius: BorderRadius.only(
//                                           topRight: Radius.circular(40.0),
//                                           bottomRight: Radius.circular(40.0),
//                                       topLeft: Radius.circular(40.0),
//                                       bottomLeft: Radius.circular(40.0))),