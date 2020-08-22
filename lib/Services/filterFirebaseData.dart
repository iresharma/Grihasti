import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Category.dart';
import 'package:customerappgrihasti/models/Order.dart';
import 'package:customerappgrihasti/models/Products.dart';
import 'package:customerappgrihasti/models/Search.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'dart:core';

import 'package:provider/provider.dart';

void topProducts() async {

  Firestore.instance.collection('products').where('featured', isEqualTo: true).snapshots().listen((event) {
    if(event.documents.length != 0) {
      List<DocumentSnapshot> stream = event.documents;
      Top = [];

      List<int> prices = [];
      List<String> variety = [];
      stream.forEach((element) {
        prices = [];
        variety = [];
        element.data['Variety'].forEach((variey) {
          prices.add(variey['price']);
          variety.add(variey['name']);
        });
        Top.add(Products(
            element.documentID,
            element.data['Name'],
            element.data['Desc'],
            prices,
            element.data['Pic'],
            element.data['Hash'],
            element.data['Category']['name'],
            variety,
            element.data['Subcategory']['name']));
      });
    }
  });
}

void hotDeals() async {

  Firestore.instance.collection('products').where('hotdeals', isEqualTo: true).snapshots().listen((event) {
    if(event.documents.length != 0) {
      List<DocumentSnapshot> stream = event.documents;
      hotdeals = [];
      List<int> prices = [];
      List<String> variety = [];
      stream.forEach((element) {
        prices = [];
        variety = [];
        element.data['Variety'].forEach((variey) {
          prices.add(variey['price']);
          variety.add(variey['name']);
        });
        hotdeals.add(Products(
            element.documentID,
            element.data['Name'],
            element.data['Desc'],
            prices,
            element.data['Pic'],
            element.data['Hash'],
            element.data['Category']['name'],
            variety,
            element.data['Subcategory']['name']));
      });
    }
  });
}

List<ProductCart> processOrders(List<dynamic> items) {
  List<ProductCart> temp = [];
  items.forEach((adds) {
    List<int> prices = [];
    List<String> variety = [];
    Prev = [];
    Firestore.instance.collection('products').document(adds['id']).get().then((element) {
      prices = [];
      variety = [];
      element.data['Variety'].forEach((variey) {
        prices.add(variey['price']);
        variety.add(variey['name']);
      });
      Prev.add(Products(
          element.documentID,
          element.data['Name'],
          element.data['Desc'],
          prices,
          element.data['Pic'],
          element.data['Hash'],
          element.data['Category']['name'],
          variety,
          element.data['Subcategory']['name']));
    });
    temp.add(ProductCart(
        adds['id'],
        adds['Name'],
        adds['desc'],
        adds['price'],
        adds['Pic'],
        adds['hash'],
        adds['count'],
        adds['category'],
        adds['variety']));
  });
  return temp;
}

bool order() {
  if(orders.length == 0) {
    Firestore.instance
        .collection('orders')
        .where('uid', isEqualTo: Activeuser.Uid)
        .orderBy('ordered_on', descending: true)
        .snapshots()
        .listen((event) {
      orders = [];
      if (event.documents.length != 0) {
        event.documents.forEach((element) {
          print('==================${element.data['price']}');
          orders.add(Order(
              element.data['orderId'] ?? element.documentID,
              element.data['price'].toString(),
              processOrders(element.data['items']),
              element.data['paymentId'] ?? 'COD',
              element.data['uid'],
              element.data['ordered_on'].toString(),
              element.data['status']));
        });
      }
      return true;
    });
  } else return true;
}

void category() {
  Firestore.instance.collection('categories').where('parent', isEqualTo: '').getDocuments().then((value) {
    cat = [];
    value.documents.forEach((element) {
      cat.add(Category(
          element.data['name'],
          element.data['id'],));
    });
  });
}


void searchFire(context) {
  if(Provider.of<Search>(context).searchStore.length == 0) {
    print('running');
    Firestore.instance.collection('searchItems').getDocuments().then((value) {
      Provider.of<Search>(context).searchStore = [];
      if(value.documents.length != 0) {
        value.documents.forEach((element) {
          Provider.of<Search>(context).add(SearchItem(
              name: element.data['name'],
              id: element.data['id'],
              type: element.data['type']
          ));
        });
      }
    });
  }
}
