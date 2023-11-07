import 'package:be_aydi_masria/modules/admin_product_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController barcode_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'بأيدي مصرية',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: barcode_controller,
                    onFieldSubmitted: (value) {
                      // Search by barcode
                    },
                    decoration: InputDecoration(
                      labelText: "Search by barcode of item",
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          16.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    onPressed: () {

                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminProduct(),
            ),
          );
        },
        backgroundColor: Colors.red,
        child: Icon(
          Icons.edit,
          size: 30.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
