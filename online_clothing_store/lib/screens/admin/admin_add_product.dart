import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/screens/address/address.dart';
import 'package:health_app_fyp/screens/admin/admin_inventory/admin_home.dart';
import 'package:health_app_fyp/widgets/customised_appbar.dart';
import 'package:health_app_fyp/widgets/customised_navbar.dart';

import '../../model/product.dart';

class AdminAddProduct extends StatelessWidget {
  AdminAddProduct({Key? key}) : super(key: key);

  late String name;
  late num price;
  late String description;
  late String category;
  late String manufacturer;
  late String color;
  late String color2;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late int stock;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController color2Controller = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController imgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomisedAppBar(
          title: ('Add Product'),
        ),
        bottomNavigationBar: CustomisedNavigationBar(),
        backgroundColor: Color.fromARGB(255, 0, 2, 3),
        body: SafeArea(
            bottom: false,
            child: ListView(children: [
              SizedBox(
                height: 25,
              ),
              Heading("Enter Product Details"),
              SizedBox(
                height: 25,
              ),
              Form(
                key: formKey,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white.withOpacity(.9)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(12, 26),
                                blurRadius: 50,
                                spreadRadius: 0,
                                color: Colors.grey.withOpacity(.1)),
                          ]),
                          child: TextField(
                            controller: nameController,
                            onChanged: (value) {
                              value = nameController.text;
                            },
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xff161C22),
                              hintText: 'Enter Product Name',
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(.75)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white.withOpacity(.9)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(12, 26),
                                blurRadius: 50,
                                spreadRadius: 0,
                                color: Colors.grey.withOpacity(.1)),
                          ]),
                          child: TextField(
                            controller: priceController,
                            obscureText: true,
                            onChanged: (value) {
                              value = priceController.text;
                            },
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xff161C22),
                              hintText: 'Enter Product Price',
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(.75)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white.withOpacity(.9)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(12, 26),
                                blurRadius: 50,
                                spreadRadius: 0,
                                color: Colors.grey.withOpacity(.1)),
                          ]),
                          child: TextField(
                            controller: descriptionController,
                            obscureText: true,
                            onChanged: (value) {
                              value = descriptionController.text;
                            },
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xff161C22),
                              hintText: 'Enter Product Description',
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(.75)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " Category",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white.withOpacity(.9)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(12, 26),
                                blurRadius: 50,
                                spreadRadius: 0,
                                color: Colors.grey.withOpacity(.1)),
                          ]),
                          child: TextField(
                            controller: categoryController,
                            onChanged: (value) {
                              value = categoryController.text;
                            },
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xff161C22),
                              hintText: 'Enter Product Category',
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(.75)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " Manufacturer",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white.withOpacity(.9)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(12, 26),
                                blurRadius: 50,
                                spreadRadius: 0,
                                color: Colors.grey.withOpacity(.1)),
                          ]),
                          child: TextField(
                            controller: manufacturerController,
                            onChanged: (value) {
                              value = manufacturerController.text;
                            },
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xff161C22),
                              hintText: 'Enter Product Manufacturer',
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(.75)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " Primary Color",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white.withOpacity(.9)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(12, 26),
                                blurRadius: 50,
                                spreadRadius: 0,
                                color: Colors.grey.withOpacity(.1)),
                          ]),
                          child: TextField(
                            controller: colorController,
                            onChanged: (value) {
                              value = colorController.text;
                            },
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xff161C22),
                              hintText: 'Enter Product Primary Color',
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(.75)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alternative Color",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white.withOpacity(.9)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(12, 26),
                                blurRadius: 50,
                                spreadRadius: 0,
                                color: Colors.grey.withOpacity(.1)),
                          ]),
                          child: TextField(
                            controller: color2Controller,
                            onChanged: (value) {
                              value = color2Controller.text;
                            },
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xff161C22),
                              hintText: 'Enter Product Alternative Color',
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(.75)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " Quantity",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white.withOpacity(.9)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(12, 26),
                                blurRadius: 50,
                                spreadRadius: 0,
                                color: Colors.grey.withOpacity(.1)),
                          ]),
                          child: TextField(
                            controller: stockController,
                            onChanged: (value) {
                              value = stockController.text;
                            },
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xff161C22),
                              hintText: 'Enter Product Quantity',
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(.75)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Image URL",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white.withOpacity(.9)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(12, 26),
                                blurRadius: 50,
                                spreadRadius: 0,
                                color: Colors.grey.withOpacity(.1)),
                          ]),
                          child: TextField(
                            controller: imgController,
                            onChanged: (value) {
                              value = imgController.text;
                            },
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xff161C22),
                              hintText: 'Enter Product Image URL',
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(.75)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 54,
                      width: double.infinity,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(255, 105, 114, 110),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff5ED5A8).withOpacity(.15),
                              offset: Offset(0, 10),
                              blurRadius: 20,
                              spreadRadius: 0,
                            )
                          ]),
                      child: TextButton(
                        child: Text("Add Product",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          int itemID = Random().nextInt(100000);
//Auto generates ID for the product
                          // String autoID = FirebaseFirestore.instance
                          //     .collection("product")
                          //     .doc()
                          //     .id;

                          if (nameController.text.isNotEmpty &&
                              priceController.text.isNum &&
                              colorController.text.isNotEmpty &&
                              color2Controller.text.isNotEmpty &&
                              stockController.text.isNum &&
                              imgController.text.isNotEmpty) {
                            FirebaseFirestore.instance
                                .collection("product")
                                .doc(itemID.toString())
                                .set({
                              "name": nameController.text,
                              "price": double.parse(priceController.text),
                              "color": colorController.text,
                              "color2": color2Controller.text,
                              "stock": double.parse(stockController.text),
                              "imageUrl": imgController.text,
                              "itemID": itemID.toString(),
                              "manufacturer": manufacturerController.text,
                              "category": categoryController.text,
                              "description": descriptionController.text,
                            });
                            Get.to(const AdminHomePage());
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Error"),
                                    content: const Text(
                                        "Please fill all the fields & make sure the price and stock is a numeric value"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text("OK"),
                                        onPressed: () {
                                          Get.to(const AdminHomePage());
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                        },
                      ))
                ]),
              ),
            ])));
  }
}

class ImageUrlInput extends StatelessWidget {
  ImageUrlInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Image URL",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.white.withOpacity(.9)),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
            child: TextField(
              onChanged: (value) {
                print(value);
              },
              style: TextStyle(fontSize: 14, color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xff161C22),
                hintText: 'Enter Product Image URL',
                hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Heading extends StatelessWidget {
  final String text;
  Heading(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, left: 15.0),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
