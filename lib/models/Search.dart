import 'package:customerappgrihasti/models/User.dart';
import 'package:flutter/cupertino.dart';

class SearchItem {
  final String id;
  final String name;
  final String type;
  final String categoryId;

  SearchItem({this.categoryId, this.id, this.name, this.type});

}

class Search extends ChangeNotifier {

  List<SearchItem> searchStore = [];
  List<SearchItem> searchResult = [];

  void search(String text) {
    text = text.toLowerCase();
    searchResult = [];
    searchResult = searchStore.where((element) => element.name.toLowerCase().startsWith(text)).toList();
    if(text == '') searchResult = [];
    print(searchResult);
    notifyListeners();
  }

  void add(SearchItem item) {
    searchStore.add(item);
    notifyListeners();
  }

  void process(List<dynamic> recent) {
    recent.forEach((element) {
      Activeuser.recentlySearch.add(
        SearchItem(
          name: element['name'],
          type: element['type'],
          id: element['id']
        )
      );
    });
  }

  List<dynamic> deprocess(List<SearchItem> item) {
    List<dynamic> temp = [];
    item.forEach((element) {
      temp.add({
        'name': element.name,
        'type': element.type,
        'id': element.id
      });
    });
    return temp;
  }

  void addrecent(SearchItem item) {
    Activeuser.recentlySearch.add(item);
    Activeuser.recentlySearch = Set.of(Activeuser.recentlySearch).toList();
  }

  int get len => searchResult.length;

}