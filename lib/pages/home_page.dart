import 'package:coffeeapp/constants/constants.dart';
import 'package:coffeeapp/widgets/coffeelistItem.dart';
import 'package:coffeeapp/widgets/custombuttontop.dart';
import 'package:coffeeapp/widgets/customcard.dart';
import 'package:coffeeapp/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<String> coffeeTypes = [
  "All Coffee",
];

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  String searchQuery = "";

  final List<Map<String, dynamic>> coffeeItems = [
    {
      "name": "Cappuccino",
      "description": "With Steamed Milk",
      "price": 50.000,
      "image": "coffee1",
      "category": "coffee"
    },
    {
      "name": "Americano",
      "description": "Double Shots",
      "price": 35.000,
      "image": "coffee2",
      "category": "coffee"
    },
    {
      "name": "Caramel Macchiato",
      "description": ".",
      "price": 60.000,
      "image": "coffee3",
      "category": "coffee"
    },
    {
      "name": "Espresso",
      "description": ".",
      "price": 35.000,
      "image": "coffee10",
      "category": "coffee"
    },
    {
      "name": "Latte Macchiato",
      "description": ".",
      "price": 50.000,
      "image": "coffee4",
      "category": "coffee1"
    },
    {
      "name": "Mocha Latte",
      "description": ".",
      "price": 50.000,
      "image": "coffee5",
      "category": "coffee1"
    },
    {
      "name": "Hazelnut Latte",
      "description": ".",
      "price": 60.000,
      "image": "coffee6",
      "category": "coffee1"
    },
    {
      "name": "Espresso",
      "description": "With Lychee Honey Lemon",
      "price": 60.000,
      "image": "coffee11",
      "category": "coffee1"
    },
    {
      "name": "Flat White Coffee",
      "description": "With rosetta latte",
      "price": 35.000,
      "image": "coffee7",
      "category": "coffee2"
    },
    {
      "name": "Caramel Frapucino",
      "description": ".",
      "price": 50.000,
      "image": "coffee8",
      "category": "coffee2"
    },
    {
      "name": "Cookies and Cream",
      "description": "Coffee",
      "price": 35.000,
      "image": "coffee9",
      "category": "coffee2"
    },
    {
      "name": "Avocado Coffee",
      "description": ".",
      "price": 60.000,
      "image": "coffee12",
      "category": "coffee2"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              const _TopBar(),
              const SizedBox(height: 30),
              const _Header(),
              const SizedBox(height: 30),
              _SearchField(
                onChanged: (query) {
                  setState(() {
                    searchQuery = query.toLowerCase();
                  });
                },
              ),
              const SizedBox(height: 30),
              _CoffeeTypeSelector(
                selectedIndex: selectedIndex,
                onSelect: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              const SizedBox(height: 30),
              _FilteredCoffeeCardList(
                searchQuery: searchQuery,
                category: "coffee",
                title: "Coffee",
                coffeeItems: coffeeItems,
              ),
              const SizedBox(height: 20),
              _FilteredCoffeeCardList(
                searchQuery: searchQuery,
                category: "coffee1",
                title: "",
                coffeeItems: coffeeItems,
              ),
              const SizedBox(height: 20),
              _FilteredCoffeeCardList(
                searchQuery: searchQuery,
                category: "coffee2",
                title: "",
                coffeeItems: coffeeItems,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButtonTop(models: Models.lang, text: "ID"),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
          child: CustomButtonTop(models: Models.profile),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Serenity\nCoffee ",
        style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(fontSize: 16, color: Cdarkgray),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF141921),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          hintText: "Find Your Coffee...",
          hintStyle: const TextStyle(
            fontSize: 12,
            color: Cdarkgray,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(
              "assets/icons/search-normal.svg",
              width: 20,
              height: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _CoffeeTypeSelector extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelect;

  const _CoffeeTypeSelector({
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: coffeeTypes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CoffeeListItem(
              text: coffeeTypes[index],
              isSelected: selectedIndex == index,
              onTap: () => onSelect(index),
            ),
          );
        },
      ),
    );
  }
}

class _FilteredCoffeeCardList extends StatelessWidget {
  final String searchQuery;
  final String category;
  final String title;
  final List<Map<String, dynamic>> coffeeItems;

  const _FilteredCoffeeCardList({
    required this.searchQuery,
    required this.category,
    required this.title,
    required this.coffeeItems,
  });

  @override
  Widget build(BuildContext context) {
    final filteredItems = coffeeItems.where((item) {
      return item["category"] == category &&
          item["name"].toLowerCase().contains(searchQuery);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        const SizedBox(height: 10),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];
              return Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: CustomCard(
                  model: Model.coffee,
                  numRate: 4.5,
                  nameProduct: item["name"],
                  descriptionProduct: item["description"].isNotEmpty
                      ? item["description"]
                      : "No description available",
                  priceProduct: item["price"],
                  nameImageFile: item["image"],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
