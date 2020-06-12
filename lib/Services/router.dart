import '../home.dart';
import 'package:flutter/material.dart';

import 'globalVariables.dart';

Map<String, Widget Function(BuildContext)> Router() {
	var router = {
		'/' : (_) => landing,
	};

	return router;
}