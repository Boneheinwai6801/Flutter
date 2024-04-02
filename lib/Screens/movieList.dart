// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/playMovie.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
   List movlist = [
    ['Fast & Furious 1','assets/images/fs1.jpg',false,"https://www.youtube.com/watch?v=2TAOizOnNPo"],
    ['Fast & Furious 2','assets/images/fs5.jpg',false,"https://www.youtube.com/watch?v=bTkDPjAx_2o"],
    ['Fast & Furious 3','assets/images/fs6.jpg',false,"https://www.youtube.com/watch?v=CyRtw_ckKFs"],
    ['Fast & Furious 4','assets/images/fs8.jpg',false,"https://www.youtube.com/watch?v=9WCZIE-ufzY"]
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Movies List'),
      ),
      body:  GridView.builder(
  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
     childAspectRatio: 1.6,
    crossAxisCount: 1, // number of items in each row
    mainAxisSpacing:10, // spacing between rows
    crossAxisSpacing: 8.0, // spacing between columns
  ),
  padding:const EdgeInsets.all(8.0), // padding around the grid
  itemCount: movlist.length, // total number of items
  itemBuilder: (context, index) {
    return InkWell(
      onTap: (){
     Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DetailMov(movlist[index][3])),
  );
    },
      child: Container(  
      
           decoration: BoxDecoration(
                color:const Color.fromARGB(255, 143, 191, 228),
                borderRadius:  BorderRadius.circular(10)
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Stack(
            children: [
        
               Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width*0.47,
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Image.asset(movlist[index][1],fit: BoxFit.fill,),
            ),
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Center(child: Image.asset('assets/images/re.png',width: 50,)),
                      ),
            ],
           ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(movlist[  index][0],style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
            )
          ],
        ),
      ),
    );
  },
)
    );
  }
}