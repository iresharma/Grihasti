import 'package:flutter/cupertino.dart';

class SearchItem {
  final String id;
  final String name;
  final String type;

  SearchItem({this.id, this.name, this.type});

}

class Search extends ChangeNotifier {

  List<SearchItem> searchStore = [];
  List<SearchItem> searchResult = [];

  void search(String text) {
    searchResult = searchStore;
    searchResult.where((element) => element.name.contains(text));
    notifyListeners();
  }

  void add(SearchItem item) {
    searchStore.add(item);
    notifyListeners();
  }

  int get len => searchResult.length;

}