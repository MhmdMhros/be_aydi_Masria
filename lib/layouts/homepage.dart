// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers, constant_identifier_names, prefer_const_literals_to_create_immutables

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
  bool isBarcode_scanner = false;
  bool isWrite = false;
  String barcode_scanner = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasryCubit, MasryStates>(
      listener: (context, state) {
        if (state is MasryCreateDatabaseState)
        {
          MasryCubit.get(context).insertDataFromJSON('product.json');
        }
        if(state is MasryDeleteDatabaseState){
          isWrite = false;
        }
      },
      builder: (context, state) {
        var cubit = MasryCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF212121),
            title: Text(
              'بأيدي مصرية',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Container(
            color: Color(0xFF121212),
            child: Padding(
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
                                isBarcode_scanner = false;
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
                                isBarcode_scanner = false;
                              } else {
                                isBarcode = false;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "أدخل باركود المنتج",
                            labelStyle: TextStyle(
                              color: Colors.white70,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white70,
                            ),
                            fillColor: Color(0xFF303030),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white54, width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF2196F3), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Color(0xFF2196F3),
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
                                      SimpleBarcodeScannerPage(lineColor: colorToHex(Colors.blue),),
                                ));
                            setState(() {
                              isWrite = true;
                              if (res == "") {
                                isWrite = false;
                              }
                              if (res is String && res != "") {
                                barcode_scanner = res;
                                if (cubit.Products.containsKey(
                                    barcode_scanner)) {
                                  isBarcode_scanner = true;
                                  isBarcode = true;
                                  barcode_controller.text = "";
                                } else {
                                  isBarcode_scanner = false;
                                  isBarcode = false;
                                }
                              }
                              else{
                                isBarcode_scanner = false;
                                isBarcode = false;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    child: isWrite
                        ? Center(
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: isBarcode
                                  ? Center(
                                      child: Container(
                                        width: double.infinity,
                                        height: 350.0,
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF303030),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[800],
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                border: Border.all(
                                                  color: Colors.blue,
                                                  width: 0.50,
                                                ),
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "رية",
                                                      style: TextStyle(
                                                        fontSize: 40,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      "مص",
                                                      style: TextStyle(
                                                        fontSize: 40,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      "بأيدي",
                                                      style: TextStyle(
                                                        fontSize: 40,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40,
                                            ),
                                            Text(
                                              'Name: ${isBarcode_scanner ? cubit.Products[barcode_scanner]!["name"] : cubit.Products[barcode_controller.text]!["name"]}',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.red,
                                              thickness: 1.0,
                                              height: 15.0,
                                              indent: 40,
                                              endIndent: 40,
                                            ),
                                            Divider(
                                              color: Colors.white,
                                              thickness: 1.0,
                                              height: 5.0,
                                              indent: 40,
                                              endIndent: 40,
                                            ),
                                            Divider(
                                              color: Colors.black,
                                              thickness: 1.0,
                                              height: 15.0,
                                              indent: 40,
                                              endIndent: 40,
                                            ),
                                            Text(
                                              'Barcode: ${isBarcode_scanner ? cubit.Products[barcode_scanner]!["barcode"] : cubit.Products[barcode_controller.text]!["barcode"]}',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        '!غير موجود ',
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                            ),
                          )
                        : Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'أدخل باركود المنتج',
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.grey),
                                  ),
                                  Text(
                                    'أو',
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.grey),
                                  ),
                                  Text(
                                    'قم بقرائته بإستخدام الكاميرا',
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
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
            backgroundColor: Color(0xFF2196F3),
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

String colorToHex(Color color) {
  String hex = color.value.toRadixString(16);
  return '#${hex.substring(2)}';
}
