// import 'dart:convert';

// import 'package:dehub/providers/user_provider.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:dehub/models/notification.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:dehub/screens/notification/notification_page.dart';
// // import 'package:dehub/screens/suit/post_detail_page.dart';
// import '../../main.dart';

// import '../../services/navigation.dart';
// import '../../services/dialog.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();

//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   debugPrint('Handling a background message ${message.messageId}');
// }

// /// Create a [AndroidNotificationChannel] for heads up notifications
// late AndroidNotificationChannel channel;

// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
// DialogService dialogService = locator<DialogService>();

// class FirebaseUtils extends StatefulWidget {
//   const FirebaseUtils({Key? key}) : super(key: key);

//   static main() async {
//     debugPrint("******************FIREBASE CONNECTION******************");
//     FirebaseMessaging messaging = FirebaseMessaging.instance;

//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     debugPrint('User granted permission: ${settings.authorizationStatus}');

//     try {
//       getToken() async {
//         final token = (await FirebaseMessaging.instance.getToken());
//         debugPrint("********************MESSAGE GET TOKEN******************");
//         debugPrint(token.toString());
//         await UserProvider().setDeviceToken(token);
//       }

//       getToken();
//       FirebaseMessaging.onBackgroundMessage(
//           _firebaseMessagingBackgroundHandler);
//       if (!kIsWeb) {
//         channel = const AndroidNotificationChannel(
//           'high_importance_channel',
//           'High Importance Notifications',
//           importance: Importance.high,
//           playSound: true,
//         );

//         flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//         await flutterLocalNotificationsPlugin
//             .resolvePlatformSpecificImplementation<
//                 AndroidFlutterLocalNotificationsPlugin>()
//             ?.createNotificationChannel(channel);

//         await FirebaseMessaging.instance
//             .setForegroundNotificationPresentationOptions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//       }

//       FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//         RemoteNotification? notification = message.notification;
//         AndroidNotification? android = message.notification?.android;
//         debugPrint("+++++ +++++ +++++ON MESSAGE CHANGE+++++ +++++ +++++");
//         debugPrint(message.data.toString());
//         FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//             FlutterLocalNotificationsPlugin();
//         const AndroidInitializationSettings initializationSettingsAndroid =
//             AndroidInitializationSettings('@mipmap/ic_launcher');
//         const IOSInitializationSettings initializationSettingsIOS =
//             IOSInitializationSettings();
//         const MacOSInitializationSettings initializationSettingsMacOS =
//             MacOSInitializationSettings();
//         const InitializationSettings initializationSettings =
//             InitializationSettings(
//           android: initializationSettingsAndroid,
//           iOS: initializationSettingsIOS,
//           macOS: initializationSettingsMacOS,
//         );
//         await flutterLocalNotificationsPlugin.initialize(
//           initializationSettings,
//           onSelectNotification: (payload) {
//             try {
//               Map<String, dynamic> valueMap = json.decode(message.data['data']);
//               Notify notify = Notify.fromJson(valueMap);
//               if (notify.isNavigation == true) {
//                 switch (notify.navigation) {
//                   case "POST":
//                     locator<NavigationService>().pushNamed(
//                         routeName: PostDetailPage.routeName,
//                         arguments: PostDetailPageArguments(
//                           id: notify.navigationId.toString(),
//                           type: "NOTIFICATION",
//                         ));
//                     break;
//                   default:
//                 }
//               } else {
//                 locator<NavigationService>()
//                     .pushNamed(routeName: NotificationPage.routeName);
//               }
//             } catch (err) {
//               debugPrint("==========on message listen error==========> $err");
//             }
//           },
//         );

//         if (notification != null && android != null && !kIsWeb) {
//           flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 icon: 'launch_background',
//               ),
//             ),
//           );
//         }
//       });

//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//         try {
//           Map<String, dynamic> valueMap = json.decode(message.data['data']);
//           Notify notify = Notify.fromJson(valueMap);
//           if (notify.isNavigation == true) {
//             switch (notify.navigation) {
//               case "POST":
//                 locator<NavigationService>().pushNamed(
//                   routeName: PostDetailPage.routeName,
//                   arguments: PostDetailPageArguments(
//                       id: notify.navigationId.toString(), type: "NOTIFICATION"),
//                 );
//                 break;
//               default:
//             }
//           } else {
//             locator<NavigationService>().pushNamed(
//               routeName: NotificationPage.routeName,
//             );
//           }
//         } catch (err) {
//           debugPrint("==========open app error==========> $err");
//         }
//       });
//     } catch (err) {
//       debugPrint(
//           "******************FIREBASE CONNECTION ERRROR******************");
//       debugPrint(err.toString());
//     }
//   }

//   @override
//   // ignore: no_logic_in_create_state
//   State<StatefulWidget> createState() {
//     throw UnimplementedError();
//   }
// }
