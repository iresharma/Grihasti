import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LifeCycleManager extends StatefulWidget {

	final Widget child;
	final List<Map<String, dynamic>> cart;

  const LifeCycleManager({Key key, this.child, this.cart}) : super(key: key);

  @override
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager> with WidgetsBindingObserver {

	@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

	@override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('App state $state');
    if(state == AppLifecycleState.paused) {
      FirebaseAuth.instance.currentUser()
          .then((value) {
            print('HI = = = = = = = = = = = = = =');
            Firestore.instance.collection('users').document(value.uid).updateData({
              'Cart': widget.cart
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
