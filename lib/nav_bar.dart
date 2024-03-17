import 'package:e_commerce/pages/bag_page.dart';
import 'package:e_commerce/pages/cart_page.dart';
import 'package:e_commerce/pages/favourite_page.dart';
import 'package:e_commerce/pages/home_page.dart';
import 'package:e_commerce/pages/profile_page.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex=0;
  List<Widget> Page=[
    HomePage(),
    CartPage(),
    BagPage(),
    Favourite(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex= index;
          });
        },
        iconSize: 35,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.red,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_rounded),label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined),label: "Bag"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined),label: "Favourite"),
          BottomNavigationBarItem(icon: Icon(Icons.supervisor_account),label: "Profile"),

        ],
        ),
      body: Page[currentIndex],
    );
  }
}