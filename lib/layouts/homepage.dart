// ignore_for_file: prefer_const_constructors

import 'package:be_aydi_masria/cubit/cubit.dart';
import 'package:be_aydi_masria/cubit/state.dart';
import 'package:be_aydi_masria/modules/admin_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController barcode_controller = TextEditingController();
  bool isBarcode = false;
  bool isWrite = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasryCubit, MasryStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MasryCubit.get(context);
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
                          setState(() {
                            if (value == "") {
                              isWrite = false;
                            }
                            if (cubit.Products.containsKey(
                                barcode_controller.text)) {
                              isBarcode = true;
                            } else {
                              isBarcode = false;
                            }
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            if (value == "") {
                              isWrite = false;
                            } else {
                              isWrite = true;
                            }
                            if (cubit.Products.containsKey(
                                barcode_controller.text)) {
                              isBarcode = true;
                            } else {
                              isBarcode = false;
                            }
                          });
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

                        onPressed: () async {
                          var res = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SimpleBarcodeScannerPage(),
                              ));
                          setState(() {
                            isWrite = true;
                            if (res == "") {
                              isWrite = false;
                            }
                            if (res is String) {
                              barcode_controller.text = res;
                              if (cubit.Products.containsKey(
                                  barcode_controller.text)) {
                                isBarcode = true;
                              } else {
                                isBarcode = false;
                              }
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Expanded(
                  child: isWrite
                      ? Center(
                          child: SingleChildScrollView(
                            child: isBarcode
                                ? Center(
                                    child: Container(
                                      child: Text(
                                        '${cubit.Products[barcode_controller.text]?["name"]}',
                                        style: TextStyle(
                                          fontSize: 50.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      'Not found...',
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                          ),
                        )
                      : Center(
                          child: Text(
                            'Search or Scan barcode',
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.grey),
                          ),
                        ),
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
      },
    );
  }
}

void ShowToastMessage({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ChooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color ChooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
