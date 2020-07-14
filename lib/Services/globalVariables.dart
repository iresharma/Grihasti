import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Order.dart';
import 'package:customerappgrihasti/models/Products.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';


List<Map<String, BiometricType>> available = [];

Color primaryMain = Color(0xFFFF3F47);
Color primarySec = Colors.redAccent;
Color secondaryMain = Colors.white;
Color secondarySec = Color(0xFFF9A825);


List<Products> Top = [];

List<Products> Prev = [];

List<Order> orders = [];