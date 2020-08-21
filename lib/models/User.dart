import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Search.dart';

class User {

	String Name;
	String Uid;
	int Coins;
	String address;
	String Email;
	String Tel;
	String photoUrl;
	List<ProductCart> cart;
	String Noti;
	int coins;
	List<SearchItem> recentlySearch = [];

}

User Activeuser = new User();