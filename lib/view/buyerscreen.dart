import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Config.dart';
import '../model/product.dart';

class BuyerScreen extends StatefulWidget {
  const BuyerScreen({Key? key}) : super(key: key);

  @override
  State<BuyerScreen> createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {

List<Products> productList = <Products>[];
  String titlecenter = "";
  late double screenHeight, screenWidth, resWidth;
  int rowcount = 2;
  TextEditingController searchController = TextEditingController();
  String search = "all";
  var seller;

  var color;
  var numofpage, curpage = 1;
  int numberofresult = 0;

  @override
  void initState() {
    super.initState();
    _loadProducts(1, search);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      rowcount = 3;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buyer"),
        actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                
              },
            ),
          ]
      ),
            body: productList.isEmpty 
      ? Center(
          child: Text(titlecenter, 
            style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold))) 
        : Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text("Homestay",
              style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
                children: List.generate(productList.length, (index) {
                  return Card(
                    child: Column(
                      children: [

                        Flexible(
                          flex: 6,
                          child: CachedNetworkImage(
                            imageUrl: Config.server + "/homestay_raya/mobile/assets/productimages/" + 
                            productList[index]
                            .id
                            .toString() + '.png',
                            imageBuilder: (context, imageProvider) =>
                            Container(
                              decoration: BoxDecoration(
                              border: const Border(
                              bottom: BorderSide(
                                color: Colors.black),
                              ),
                              image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fitHeight,
                              colorFilter:
                              const ColorFilter.mode(
                                Colors.white,
                                BlendMode.colorBurn),
                              )
                            ),
                          ),
                          placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),),
                        ),

                        Flexible(flex:4, child: Column(
                          children: [
                            Text(
                                    productList[index].name.toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    softWrap: true,
                                  ),
                            
                          ],
                        ))
                      ],
                    )
                  );
                }
              )
            )
          ),
                    SizedBox(
                height: 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: numofpage,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if ((curpage - 1) == index) {
                      color = Colors.red;
                    } else {
                      color = Colors.black;
                    }
                    return SizedBox(
                      width: 40,
                      child: TextButton(
                          onPressed: () => {_loadProducts(index + 1, "")},
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: color),
                          )),
                    );
                  },
                ),
          ),
                  ],
                ),
        
      );
  }
  
  void _loadProducts(int pageno, String _search) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(Uri.parse("${Config.server}/homestay_raya/mobile/php/load_products.php"),
      body: {
        'pageno' : pageno.toString(),
        'search': _search,
        }).timeout(
          const Duration(seconds: 5),
          onTimeout: (){
            titlecenter = "Timeout Please retry again later";
            return http.Response(
              'Error', 404
            );
          },
        ).then((response) {
          
        print(response.body);

        var jsonResponse = json.decode(response.body);
        if(response.statusCode == 200 && jsonResponse['status'] == 'success') {
          Products product = Products.fromJson(jsonResponse['data']);
          var extractdata = jsonResponse['data'];
            
            if (extractdata['product'] != null) {

              

            titlecenter = "Found";
        
          }else {
              titlecenter =
                  "No Product"; 
              productList.clear();
            }
          } else {
            titlecenter = "No Product Available"; //status code other than 200
            productList.clear(); //clear productList array
          }
        setState(() {});
      }
    );
  }
}