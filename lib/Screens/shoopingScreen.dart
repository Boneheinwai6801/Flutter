// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/shopDetailScreen.dart';

class ShopList extends StatefulWidget {
  const ShopList({super.key});

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {

  List shoplist = [
    ['Laptop','assets/images/laptop.jpg',false,"Black",'2022',50020],
    ['Mouse','assets/images/mouse.jpg',false,"Blue",'2022',5000],
    ['Laptop Bag','assets/images/bag1.jpg',false,"Green",'2022',5000],
    ['Phone','assets/images/ph.jpg',false,"Brown",'2022',5000]
  ];
  bool isfav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Shopping List'),
      ),
      body:  GridView.builder(
  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
     childAspectRatio: 0.7,
    crossAxisCount: 2, // number of items in each row
    mainAxisSpacing:10, // spacing between rows
    crossAxisSpacing: 8.0, // spacing between columns
  ),
  padding:const EdgeInsets.all(8.0), // padding around the grid
  itemCount: shoplist.length, // total number of items
  itemBuilder: (context, index) {
    return InkWell(
      onTap: (){
     Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ShopDetail(shoplist[index])),
  );
    },
      child: Container(
      
           decoration: BoxDecoration(
                color:const Color.fromARGB(255, 143, 191, 228),
                borderRadius:  BorderRadius.circular(10)
              ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2,left: 2,right: 2),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 0.5,
                  color: Colors.blue,
                  child:Image.asset(shoplist[index][1],fit: BoxFit.fill,),
                ),
              ),
              ListTile(
                leading: Text(shoplist[index][0]),
                trailing: InkWell(
                  onTap: (){
                                       
      
                    setState(() {
                      shoplist[index][2] = !shoplist[index][2];
                      isfav = !isfav;
      
                      if (shoplist[index][2]== true){
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Selected Favourite'),
              backgroundColor: (Colors.black12),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  setState(() {
                      shoplist[index][2] = !shoplist[index][2];
                  });
                },
              ),
            ));
                      }
                      else{
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('UnSelected Favourite'),
              backgroundColor: (Colors.black12),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  setState(() {
                      shoplist[index][2] = !shoplist[index][2];
                  });
                },
              ),
            ));
                      }
                
                    });
                  },
                  child:  shoplist[index][2] == false ? const Icon(Icons.favorite_border) : const Icon(Icons.favorite)),
              )
            ],
          )
        ),
      ),
    );
  },
)
    );
  }
}