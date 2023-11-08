// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_import, non_constant_identifier_names, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:be_aydi_masria/cubit/cubit.dart';
import 'package:be_aydi_masria/cubit/state.dart';
import 'package:be_aydi_masria/layouts/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminProduct extends StatefulWidget {
  const AdminProduct({super.key});

  @override
  State<AdminProduct> createState() => _AdminProductState();
}

class _AdminProductState extends State<AdminProduct> {
  TextEditingController password_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();
  TextEditingController bar_controller = TextEditingController();
  bool pass_secure = true;
  bool isPass = false;
  bool isWrite = false;
  var product_formKey = GlobalKey<FormState>();
  var pass_formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasryCubit, MasryStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MasryCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF212121),
            title: Text(
              'أضف منتج',
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
                  Container(
                    child: Form(
                      key: pass_formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: password_controller,
                        obscureText: pass_secure,
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            setState(() {
                              isWrite = false;
                            });
                            return 'من فضلك أدخل كلمة المرور';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            if (password_controller.text == "12345") {
                              isPass = true;
                            } else {
                              isPass = false;
                            }
                            if (pass_formKey.currentState?.validate() ==
                                true) {}
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            isWrite = true;
                            if (password_controller.text == "12345") {
                              isPass = true;
                            } else {
                              isPass = false;
                            }
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "أدخل كلمة المرور",
                          labelStyle: TextStyle(
                            color: Colors.white70,
                          ),
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.white70,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              pass_secure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              setState(() {
                                pass_secure = !pass_secure;
                              });
                            },
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
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    child: isWrite
                        ? Center(
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: isPass
                                  ? Form(
                                      key: product_formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'معلومات المنتج',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 30.0,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.text,
                                            controller: name_controller,
                                            validator: (value) {
                                              if (value?.isEmpty == true) {
                                                return 'من فضلك أدخل الإسم';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              labelText: "أسم المنتج",
                                              labelStyle: TextStyle(
                                                color: Colors.white70,
                                              ),
                                              fillColor: Color(0xFF303030),
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white54,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF2196F3),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                            ),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 12.0,
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: bar_controller,
                                            validator: (value) {
                                              if (value?.isEmpty == true) {
                                                return 'من فضلك أدخل الباركود';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              labelText: "باركود المنتج",
                                              labelStyle: TextStyle(
                                                color: Colors.white70,
                                              ),
                                              fillColor: Color(0xFF303030),
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white54,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF2196F3),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                            ),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              border: Border.all(
                                                color: Colors.red,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (product_formKey
                                                          .currentState
                                                          ?.validate() ==
                                                      true) {
                                                    cubit.InsertToDatabase(
                                                      barcode:
                                                          bar_controller.text,
                                                      name:
                                                          name_controller.text,
                                                    );
                                                  }
                                                });
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                child: Center(
                                                  child: Text(
                                                    'أضف المنتج',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (product_formKey
                                                          .currentState
                                                          ?.validate() ==
                                                      true) {
                                                    cubit.UpdateDatabase(
                                                      barcode:
                                                          bar_controller.text,
                                                      name:
                                                          name_controller.text,
                                                    );
                                                  }
                                                });
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                child: Center(
                                                  child: Text(
                                                    'تعديل المنتج',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (product_formKey
                                                          .currentState
                                                          ?.validate() ==
                                                      true) {
                                                    cubit.DeleteDatabase(
                                                        barcode: bar_controller
                                                            .text);
                                                  }
                                                });
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                child: Center(
                                                  child: Text(
                                                    'حذف المنتج',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                      'كلمة مرور غير صحيحة',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 30.0,
                                      ),
                                    )),
                            ),
                          )
                        : Center(
                            child: SingleChildScrollView(
                              child: Text(
                                'أدخل كلمة المرور لإضافة منتج',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.grey),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
