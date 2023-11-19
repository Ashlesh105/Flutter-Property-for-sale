import 'package:flutter/material.dart';
import 'package:property_sale/helperClass.dart';
import 'package:property_sale/widget.dart';
import 'Drawer.dart';
import 'property_model.dart';

void main(){
  runApp(MaterialApp(home:Categories(),debugShowCheckedModeBanner: false,));
}
class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late List<Property> properties = [];
  bool showHouse = true;
  bool showOffice = true;
  bool showOther = true;
  double minPrice = 500;
  double maxPrice = 10000;

  @override
  void initState() {
    super.initState();
    _loadUserInformation();
  }

  Future<void> _loadUserInformation() async {
    List<Property> loadedProperties = await DatabaseHelper.instance.getProperties();
    setState(() {
      properties = loadedProperties;
    }); // Update the UI with loaded data
  }

  List<Property> _filterProperties() {
    return properties.where((property) {
      bool nameCondition = true;

      if (!showHouse && property.type == 'house') {
        nameCondition = false;
      } else if (!showOffice && property.type == 'office') {
        nameCondition = false;
      } else if (!showOther && property.type == 'other') {
        nameCondition = false;
      }

      bool priceCondition = property.minPrice >= minPrice && property.maxPrice <= maxPrice;

      return nameCondition && priceCondition;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  DrawerPage(
        userName: '',
        userEmail: '',
        userPhoneNumber: '',
        userProfileImage: null,
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.deepPurple),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                if (value == 'filters') {
                  // Show a dialog or perform any action when the user selects "Filters"
                  _showFilterDialog(context);
                }
              });
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'filters',
                  child: Text('Filters'),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              children: _filterProperties().isEmpty
                  ? [const Center(child: Text('No Info'))]
                  : _filterProperties().map((property) {
                return Template(
                  imageUrl: property.imageUrl,
                  text:
                  '${property.type.toUpperCase()}\nMin: \$${property.minPrice}\nMax: \$${property.maxPrice}',
                  height:
                  MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  // Show a filter dialog
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Options'),
          content: Column(
            children: [
              CheckboxListTile(
                title: const Text('House'),
                value: showHouse,
                onChanged: (bool? value) {
                  setState(() {
                    showHouse = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Office'),
                value: showOffice,
                onChanged: (bool? value) {
                  setState(() {
                    showOffice = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Other'),
                value: showOther,
                onChanged: (bool? value) {
                  setState(() {
                    showOther = value!;
                  });
                },
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Price Range:'),
                  Text('\$${minPrice.toInt()} - \$${maxPrice.toInt()}'),
                ],
              ),
              Slider(
                value: minPrice,
                onChanged: (double value) {
                  setState(() {
                    minPrice = value;
                  });
                },
                min: 0,
                max: 10000,
                divisions: 100,
                label: '$minPrice',
              ),
              Slider(
                value: maxPrice,
                onChanged: (double value) {
                  setState(() {
                    maxPrice = value;
                  });
                },
                min: 0,
                max: 10000,
                divisions: 100,
                label: '$maxPrice',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }
}
