import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:customerappgrihasti/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Color(0xffF9F9F9),
			body: SafeArea(
				top: true,
				child: SingleChildScrollView(
					child: Padding(
						padding:
						EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
						child: Column(
							children: <Widget>[
								CircleAvatar(
									maxRadius: 48,
									backgroundImage:Activeuser.photoUrl == '' || Activeuser.photoUrl == null ? AssetImage('assets/images/avataaars.png') : NetworkImage(Activeuser.photoUrl),
								),
								Row(
									mainAxisAlignment: MainAxisAlignment.center,
									children: <Widget>[
										Padding(
											padding: const EdgeInsets.all(8.0),
											child: Text(
												Activeuser.Name ?? 'Name Sharma',
												style: TextStyle(fontWeight: FontWeight.bold),
											),
										),
										IconButton(
											icon: Icon(FlutterIcons.edit_2_fea, size: 15,),
											onPressed: () => Navigator.of(context).pushNamed('/edit'),
										)
									],
								),
								Container(
									margin: EdgeInsets.symmetric(vertical: 16.0),
									decoration: BoxDecoration(
										borderRadius: BorderRadius.only(
											topLeft: Radius.circular(8),
											topRight: Radius.circular(8),
											bottomLeft: Radius.circular(8),
											bottomRight: Radius.circular(8)),
										color: Colors.white,
										boxShadow: [
											BoxShadow(
												color: Color.fromRGBO(253, 184, 70, 0.7),
												blurRadius: 4,
												spreadRadius: 1,
												offset: Offset(0, 1))
										]),
									height: 150,
									child: Center(
										child: Row(
											mainAxisAlignment: MainAxisAlignment.spaceAround,
											children: <Widget>[
												Column(
													mainAxisAlignment: MainAxisAlignment.center,
													children: <Widget>[
														IconButton(
															icon: Image.asset('assets/icons/truck.png'),
															onPressed: () => Navigator.of(context).pushNamed('/orders')
														),
														Text(
															'Track Orders',
															style: TextStyle(fontWeight: FontWeight.bold),
														)
													],
												),
												Column(
													mainAxisAlignment: MainAxisAlignment.center,
													children: <Widget>[
														IconButton(
															icon: Image.asset('assets/icons/wallet.png'),
															onPressed:()=> print('Coins ${Activeuser.coins}'),
														),
														Text(
															'Coins ${Activeuser.coins}',
															style: TextStyle(fontWeight: FontWeight.bold),
														)
													],
												),
												Column(
													mainAxisAlignment: MainAxisAlignment.center,
													children: <Widget>[
														IconButton(
															icon: Image.asset('assets/icons/contact_us.png'), onPressed: () {},
														),
														Text(
															'Support',
															style: TextStyle(fontWeight: FontWeight.bold),
														)
													],
												),
											],
										),
									),
								),
								ListTile(
									title: Text('Settings'),
									subtitle: Text('Privacy and logout'),
									leading: Image.asset('assets/icons/settings_icon.png', fit: BoxFit.scaleDown, width: 30, height: 30,),
									trailing: Icon(Icons.chevron_right, color: primaryMain),
									onTap: () => Navigator.of(context).push(
										MaterialPageRoute(builder: (_) => SettingsPage())),
								),
								Divider(),
								ListTile(
									title: Text('Help & Support'),
									subtitle: Text('Help center and legal support'),
									leading: Image.asset('assets/icons/support.png'),
									trailing: Icon(
										Icons.chevron_right,
										color: primarySec,
									),
								),
								Divider(),
								Padding(
									padding: EdgeInsets.symmetric(
										vertical: 10
									),
									child: Align(
										alignment: Alignment.centerRight,
										child: FlatButton(
											child: Text(
												'Developed with ♥️ by iresharma and team'
											),
											onPressed: () => launch('https://iresharma.me'),
										),
									),
								)
							],
						),
					),
				),
			),
		);
	}
}