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
  bool pass_secure = false;
  bool isPass = false;
  bool isWrite = false;
  var product_formKey = GlobalKey<FormState>();
  var pass_formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasryCubit,MasryStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = MasryCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              title: Text(
                'Add Product',
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
                            return 'password must not be empty';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            if (password_controller.text == "12345") {
                              isPass = true;
                            }
                            else{
                              isPass = false;
                            }
                            if (pass_formKey.currentState
                                ?.validate() ==
                                true) {
                            }
                          });
                        },
                        onChanged: (value){
                          setState(() {
                            isWrite = true;
                            if (password_controller.text == "12345") {
                              isPass = true;
                            }
                            else{
                              isPass = false;
                            }
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Enter password",
                          prefixIcon: Icon(
                            Icons.password,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              pass_secure ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                pass_secure = !pass_secure;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Expanded(
                    child: isWrite
                        ? Center(
                      child: SingleChildScrollView(
                        child: isPass
                            ? Form(
                          key: product_formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                controller: name_controller,
                                validator: (value) {
                                  if (value?.isEmpty == true) {
                                    return 'name must not be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Product name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      16.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: bar_controller,
                                validator: (value) {
                                  if (value?.isEmpty == true) {
                                    return 'barcode must not be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Product barcode",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      16.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      if (product_formKey.currentState
                                          ?.validate() ==
                                          true) {
                                        cubit.InsertToDatabase(barcode: bar_controller.text,name: name_controller.text,);
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'Add',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
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
                              'Password is not correct',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 30.0,
                              ),
                            )),
                      ),
                    )
                        : Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}
