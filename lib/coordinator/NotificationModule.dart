import 'package:firebase_messaging/firebase_messaging.dart';

abstract class INotification {
  void initializeNotificationModule();
}

class NotificationModule implements INotification {
  static final NotificationModule _instance = NotificationModule._internal();
  factory NotificationModule() {
    return _instance;
  }
  NotificationModule._internal();

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  void _initialize() {
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        print("onLaunch called");
      },
      onResume: (Map<String, dynamic> msg) {
        print("onResume called");
      },
      onMessage: (Map<String, dynamic> msg) {
        print("onMessage called");
      }
    );
    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        alert: true,
        badge: true
      )
    );
    firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings setting){
      print ('IOS Setting Registed');
    });
    firebaseMessaging.getToken().then((token){
      update(token);
    });
  }

  void update(String token) {
    print(token);
  }

  @override
  void initializeNotificationModule() {
    this._initialize();
  }
}

