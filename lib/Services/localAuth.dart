import 'dart:io';

import 'package:local_auth/local_auth.dart';

import 'globalVariables.dart';

void initLA() async {
	LocalAuthentication localAuth = new LocalAuthentication();
	bool checkBiometrics = await localAuth.canCheckBiometrics;
	if(checkBiometrics) {
		List<BiometricType> availableDevices = await localAuth.getAvailableBiometrics();
		if(Platform.isIOS) {
			if (availableDevices.contains(BiometricType.face)) {
				available.add({
					'FaceId': BiometricType.face
				});
			} else if (availableDevices.contains(BiometricType.fingerprint)) {
				available.add({
					'TouchId': BiometricType.fingerprint
				});
			}
		}
		else if(Platform.isAndroid) {
			if (availableDevices.contains(BiometricType.face)) {
				available.add({
					'Face Unlock': BiometricType.face
				});
			} else if (availableDevices.contains(BiometricType.fingerprint)) {
				available.add({
					'Fingerprint': BiometricType.fingerprint
				});
			}
		}
	}
}


