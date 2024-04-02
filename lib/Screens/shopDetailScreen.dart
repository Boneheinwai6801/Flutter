// ignore_for_file: must_be_immutable, file_names, prefer_final_fields

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShoppingCart {
  static final ShoppingCart _instance = ShoppingCart._internal();

  List<dynamic> _cartItems = [];

  factory ShoppingCart() {
    return _instance;
  }

  ShoppingCart._internal();

  void addItem(dynamic item) {
    _cartItems.add(item);
  }

  List<dynamic> getCartItems() {
    return _cartItems;
  }
}

class ShopDetail extends StatefulWidget {
  List<dynamic> shoplist;
  ShopDetail(this.shoplist, {super.key});

  @override
  State<ShopDetail> createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  bool isselect = true;
  bool isreach = true;

  String formatPrice(int price) {
    NumberFormat formatter = NumberFormat("#,##0", "en_US");
    return formatter.format(price);
  }

  int incres = 1;
  int total = 0;

  @override
  void initState() {
    super.initState();
    total = widget.shoplist[5];
  }
  bool itemExistsInCart(String category) {
    List<dynamic> cartItems = ShoppingCart().getCartItems();
    for (var item in cartItems) {
      if (item['0'] == category) {
        return true;
      }
    }
    return false;
  }
void showCheckoutSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
     const SnackBar(
        content: Text('Checkout Successful!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  //       actions: [
  //         InkWell(
  //           focusColor: Colors.transparent,
  //           highlightColor: Colors.transparent,
  //           splashColor: Colors.transparent,
  //           onTap: () {
  //             setState(() {
  //               isselect = !isselect;
  //               if (isselect) {
  //                Map<String, dynamic> itemDetails = Map.fromIterable(widget.shoplist, key: (item) => widget.shoplist.indexOf(item).toString(), value: (item) => item);
  //                 itemDetails['quantity'] = incres;
  //                 ShoppingCart().addItem(itemDetails);
  //               }
  //             });
  //           },
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(8),
  //                   color: isselect ? Colors.yellow : Colors.green),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: isselect
  //                     ? const Row(
  //                         children: [
  //                           Text('Add to Card'),
  //                           Icon(CupertinoIcons.shopping_cart)
  //                         ],
  //                       )
  //                     : InkWell(
  //                       onTap: (){
  //                           Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => CartHistory()),
  // );
  //   },
                        
  //                       child: const Row(
  //                           children: [
  //                             Text('Added'),
  //                             Icon(
  //                               CupertinoIcons.shopping_cart,
  //                               color: Colors.red,
  //                             )
  //                           ],
  //                         ),
  //                     ),
  //               ),
  //             ),
  //           ),
  //         )
  //       ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.amber,
            child: Image.asset(
              widget.shoplist[1],
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Category -'),
                          Text(widget.shoplist[0].toString())
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Color -'),
                          Text(widget.shoplist[3].toString()),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Manufacture Date -'),
                          Text(widget.shoplist[4].toString()),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Price -'),
                          Text(formatPrice(widget.shoplist[5])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Quantity'),
              const SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: isreach
                            ? () {
                                setState(() {
                                  incres = incres - 1;
                                  total = widget.shoplist[5] * incres;
                                  if (incres == 1) {
                                    isreach = !isreach;
                                  }
                                });
                              }
                            : () {
                                setState(() {
                                  if (incres == 1) {
                                    isreach = !isreach;
                                  }
                                });
                              },
                        color: Colors.green,
                      ),
                      Text(incres.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            incres = incres + 1;
                            total = widget.shoplist[5] * incres;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Total'),
              const SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(), borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text(total.toString()),
                  ),
                ),
              )
            ],
          ),
          TextButton(onPressed: (){

              setState(() {
                isselect = !isselect;
                if (isselect) {
                  Map<String, dynamic> itemDetails = { for (var item in widget.shoplist) widget.shoplist.indexOf(item).toString() : item };
                  itemDetails['quantity'] = incres;

                  // Check if an item with the same category already exists in the cart
                  if (itemExistsInCart(widget.shoplist[0])) {
                    // Update the quantity of the existing item
                    for (var item in ShoppingCart().getCartItems()) {
                      if (item['0'] == widget.shoplist[0]) {
                        item['quantity'] += incres;
                        break;
                      }
                    }
                  } else {
                    // Add a new item to the cart
                    ShoppingCart().addItem(itemDetails);
                  }
                  showCheckoutSnackbar(context);
                }
              });
            

          }, child: Container(
            decoration:BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(8),color: Colors.yellow), child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Check Out'),
            ),))
        ],

        
      ),
    );
  }
}
class CartHistory extends StatefulWidget {
  const CartHistory({super.key});

  @override
  State<CartHistory> createState() => _CartHistoryState();
}

class _CartHistoryState extends State<CartHistory> {
  String formatPrice(int? price) {
    if (price != null) {
      NumberFormat formatter = NumberFormat("#,##0", "en_US");
      return formatter.format(price);
    } else {
      return 'N/A'; // Handle the case where the price is null
    }
  }

  @override
  Widget build(BuildContext context) {
    List cartItems = ShoppingCart().getCartItems();
  setState(() {
    log(cartItems.toString());
    
  });
    return Scaffold(
      appBar: AppBar(
        title:const Text('Cart History'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> item = cartItems[index];
          String itemName = item['0'].toString(); // Assuming '0' is the category, adjust it based on your actual data structure
          int? itemPrice = item['5'];
          int itemQuantity = item['quantity'] ?? 1;

          int? totalPrice = itemPrice != null ? itemPrice * itemQuantity : null;

          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Card(
              color: Colors.white,
              elevation: 2,
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 50,height: 50,
                    child: Image.asset(item['1'])),
                ),
                title: Text(itemName),
                subtitle: Text(item['3']),
                trailing: 
               Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Price: ${formatPrice(itemPrice)}'),
                    Text('Quantity: $itemQuantity'),
                    Text('Total: ${formatPrice(totalPrice)}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
