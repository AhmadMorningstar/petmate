import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petmate/provider/FavsProvider.dart';
import 'package:petmate/widgets/product.dart';
import 'package:petmate/pages/home_page.dart';

class FavsPage extends StatefulWidget {
  const FavsPage({Key? key}) : super(key: key);

  @override
  State<FavsPage> createState() => _FavsPageState();
}

class _FavsPageState extends State<FavsPage> {
  int selectedPage = 1;

  final List<IconData> icons = [Icons.home, Icons.favorite];
  final Color deepPurple = Colors.deepPurple;
  final Color grey = Colors.grey;
  final Color white = Colors.white;

  @override
  Widget build(BuildContext context) {
    final favsProvider = Provider.of<FavsProvider>(context);

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text("Favorites"),
        backgroundColor: white,
        elevation: 0.5,
      ),
      body: favsProvider.favorites.isEmpty
          ? const Center(
        child: Text(
          "No favorites yet",
          style: TextStyle(fontSize: 18, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 115),
    child: ListView.builder(
    itemCount: favsProvider.favorites.length,
    itemBuilder: (context, index) {
    final product = favsProvider.favorites[index];
    return Dismissible(
    key: Key(product.name!), // Unique key for each item
    direction: DismissDirection.endToStart, // Swipe left
    background: Container(
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    color: Colors.red, // Background when swiping
    child: const Icon(Icons.delete, color: Colors.white, size: 32),
    ),
      onDismissed: (direction) {
        favsProvider.toggleFavorite(product); // Remove item
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${product.name} removed from favorites"),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Row(
        children: [
          Expanded(
            child: ProductItem(product: product),
          ),
        ],
      ),
    );
    },
    ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        child: BottomNavigationBar(
          backgroundColor: white,
          selectedItemColor: deepPurple,
          unselectedItemColor: grey,
          elevation: 1,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedPage,
          onTap: (value) {
            if (value != selectedPage) {
              setState(() {
                selectedPage = value;
              });

              Widget nextPage = value == 0 ? const HomePage() : const FavsPage();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => nextPage),
              );
            }
          },
          items: List.generate(
            icons.length,
                (index) => BottomNavigationBarItem(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    icons[index],
                    color: selectedPage == index ? deepPurple : grey,
                  ),
                  const SizedBox(height: 5),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: selectedPage == index ? 15 : 0,
                    height: selectedPage == index ? 3 : 0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: deepPurple,
                    ),
                  ),
                ],
              ),
              label: '',
            ),
          ),
        ),
      ),
    );
  }
}
