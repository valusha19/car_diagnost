import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class FirebaseNotifications {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Запит дозволів на отримання сповіщень
    NotificationSettings notificationSettings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (notificationSettings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint("❌ Доступ до сповіщень заборонено");
      return;
    }

    // Отримання FCM токену
    String? token = await _messaging.getToken();
    debugPrint("🔑 Firebase Messaging Token: $token");

    // Ініціалізація локальних сповіщень
    var androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var localSettings = InitializationSettings(android: androidSettings);
    await _localNotifications.initialize(localSettings);

    // Обробка повідомлень у foreground (коли додаток відкритий)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(
        message.notification?.title ?? "Новий меседж",
        message.notification?.body ?? "Текст повідомлення",
      );
    });

    // Обробка повідомлень, коли користувач відкрив додаток через пуш-нотифікацію
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("📩 Користувач натиснув на повідомлення: ${message.data}");
    });

    // Обробка повідомлень у background (фонові)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Фоновий обробник повідомлень
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    debugPrint("📨 Отримано фонове повідомлення: ${message.messageId}");
  }

  // Функція для відображення сповіщень
  static Future<void> _showNotification(String title, String body) async {
    var androidDetails = const AndroidNotificationDetails(
      'channel_id',
      'Основний канал',
      importance: Importance.high,
      priority: Priority.high,
    );

    var details = NotificationDetails(android: androidDetails);
    await _localNotifications.show(0, title, body, details);
  }
}