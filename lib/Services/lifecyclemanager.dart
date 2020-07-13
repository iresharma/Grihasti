import 'package:flutter/material.dart';

class LifeCycleManager extends StatefulWidget {

	final Widget child;

  const LifeCycleManager({Key key, this.child}) : super(key: key);

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
      print('HI');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
