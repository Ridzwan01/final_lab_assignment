import 'package:flutter/material.dart';
import 'package:homestay_raya_beta/view/buyerscreen.dart';
import 'package:homestay_raya_beta/view/loginscreen.dart';
import 'package:homestay_raya_beta/view/profilescreen.dart';
import 'package:homestay_raya_beta/view/sellerscreen.dart';

import '../model/user.dart';

class mainscreen extends StatefulWidget {
  final User user;
  const mainscreen({super.key, required this.user});

  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homestay Raya"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.login,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
              Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (content) => const LoginScreen()));
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Seller'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (content) => BuyerScreen()));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (content) => SellerScreen()));
              },
            ),
            ListTile(
              title: const Text('Buyer'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (content) => BuyerScreen()));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (content) => BuyerScreen()));
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (content) => BuyerScreen()));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (content) => profilescreen(user: widget.user)));
              },
            ),
          ],
        ),// Populate the Drawer in the next step.
      )
    );
  }
}