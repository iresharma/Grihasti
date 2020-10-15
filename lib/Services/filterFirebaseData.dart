import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Category.dart';
import 'package:customerappgrihasti/models/Offers.dart';
import 'package:customerappgrihasti/models/Order.dart';
import 'package:customerappgrihasti/models/Products.dart';
import 'package:customerappgrihasti/models/Search.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'dart:core';

import 'package:provider/provider.dart';

Future<void> topProducts() async {
  print('topproduct');
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
          if(variey['Nstock'] != 0) {
            prices.add(variey['price']);
            variety.add(variey['name']);
          }
        });
        Top.add(Products(
            id:element.documentID,
            Name: element.data['Name'],
            desc: element.data['desc'],
            thumb: element.data['thumb'],
            price: prices,
            pictures: element.data['Pic'],
            hash: element.data['Hash'],
            category: element.data['categoryParent'],
            variety: variety,
            SubCategory: element.data['categoryId']));
      });
    }
  });
}

Future<void> hotDeals() async {
  print('hotDeal');
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
          if(variey['Nstock'] != 0) {
            prices.add(variey['price']);
            variety.add(variey['name']);
          }
        });
        hotdeals.add(Products(
            id:element.documentID,
            Name: element.data['Name'],
            desc: element.data['desc'],
            thumb: element.data['thumb'],
            price: prices,
            pictures: element.data['Pic'],
            hash: element.data['Hash'],
            category: element.data['categoryParent'],
            variety: variety,
            SubCategory: element.data['categoryId']));
      });
    }
  });
}

Future<void> offerProducts() async {
  print('offer products');
  Firestore.instance.collection('products').where('offers', isEqualTo: true).snapshots().listen((event) {
    if(event.documents.length != 0) {
      List<DocumentSnapshot> stream = event.documents;
      offerProduct = [];
      List<int> prices = [];
      List<String> variety = [];
      stream.forEach((element) {
        prices = [];
        variety = [];
        element.data['Variety'].forEach((variey) {
          if(variey['Nstock'] != 0) {
            prices.add(variey['price']);
            variety.add(variey['name']);
          }
        });
        offerProduct.add(Products(
            id:element.documentID,
            Name: element.data['Name'],
            desc: element.data['desc'],
            thumb: element.data['thumb'],
            price: prices,
            pictures: element.data['Pic'],
            hash: element.data['Hash'],
            category: element.data['categoryParent'],
            variety: variety,
            SubCategory: element.data['categoryId']));
      });
    }
  });
}

List<ProductCart> processOrders(List<dynamic> items) {
  List<ProductCart> temp = [];
  items.forEach((adds) {
    List<int> prices = [];
    List<String> variety = [];
    Firestore.instance.collection('products').document(adds['id']).get().then((element) {
      prices = [];
      variety = [];
      element.data['Variety'].forEach((variey) {
        if(variey['Nstock'] != 0) {
          prices.add(variey['price']);
          variety.add(variey['name']);
        }
      });
      Prev.add(Products(
          id:element.documentID,
          Name: element.data['Name'],
          desc: element.data['desc'],
          thumb: element.data['thumb'],
          price: prices,
          pictures: element.data['Pic'],
          hash: element.data['Hash'],
          category: element.data['categoryParent'],
          variety: variety,
          SubCategory: element.data['categoryId']));
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
        adds['variety'],
        adds['pictures']
    ));
  });
  return temp;
}

bool order() {
  print('order');
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
              element.data['status'],
              element.data['discount'] ?? 40
          ));
        });
      }
      return true;
    });
  } else return true;
}

Future<void> category() async {
  print('category');
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
    Firestore.instance.collection('searchItems').getDocuments().then((value) {
      Provider.of<Search>(context).searchStore = [];
      if(value.documents.length != 0) {
        value.documents.forEach((element) {
          Provider.of<Search>(context).add(SearchItem(
              name: element.data['name'],
              id: element.data['id'],
              type: element.data['type'],
              categoryId: element.data['categoryId'] ?? '',
          ));
        });
      }
    });
  }
}

Future<void> offereded() {
  Firestore.instance.collection('offers').getDocuments().then((value) {
    if(value.documents.length != 0) {
      offers = [];
      value.documents.forEach((element) {
        offers.add(Offers(
          code: element.data['code'],
          icon: element.data['icon'],
          main: element.data['name'],
          fineprint: element.data['description'],
          maxVal: element.data['maxVal'],
          minVal: element.data['minVal'],
          percentage: element.data['percentage']
        ));
      });
    }
  });
  print(offers);
}