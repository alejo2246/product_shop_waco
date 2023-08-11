import 'package:flutter/material.dart';
import 'package:product_shop/presentation/pages/edit_page.dart';
import 'package:product_shop/presentation/pages/products_page.dart';
import 'package:product_shop/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = <Widget>[
    const ProductsPage(),
    const EditPage(),
    const ProfilePage(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Shop',
          style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white70),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Admin'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]),
    );
  }
}


