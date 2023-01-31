import 'package:flutter/material.dart';
import 'package:homestay_raya_beta/Config.dart';
import 'package:homestay_raya_beta/model/user.dart';
import 'package:homestay_raya_beta/view/addproductscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SellerScreen extends StatefulWidget {
  SellerScreen({Key? key}) : super(key: key);

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {

    List<User> productlist = <User>[];
    String titlecenter = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seller")
      ),

      body: productlist.isEmpty 
      ? Center(
          child: Text(titlecenter, 
            style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold))) 
        : Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text("Subjects",
              style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
                children: List.generate(productlist.length, (index) {
                  return Card(
                    child: Column(
                      children: [
                        Flexible(flex: 6,
                        child: CachedNetworkImage(imageUrl: Config.server + "/my_tutor/mobile/assets/courses/" + 
                        productlist[index]
                        .id
                        .toString() + '.jpg'),
                        ),
                        Flexible(flex:4, child: Column(
                          children: [
                            Text(productlist[index]
                            .name
                            .toString())
                          ],
                        ))
                      ],
                    )
                  );
                }
              )
            )
          )
          
        ],
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (content) => AddProductScreen()));
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
    );
  }
}