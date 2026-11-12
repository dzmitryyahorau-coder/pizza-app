import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;
    _isInitialized = true;

    final settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else {
      debugPrint('User declined or has not accepted permission');
      return;
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final apnsToken = await _fcm.getAPNSToken();
      if (apnsToken == null) {
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    FirebaseMessaging.instance.onRegistered.listen(
      (fid) {
        debugPrint('Received FID: $fid');
        _saveTokenToSupabase(fid);
      },
      onError: (e) {
        debugPrint('FID registration error: $e');
      },
    );

    await FirebaseMessaging.instance.register();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint(
          'Notification: ${message.notification?.title} - ${message.notification?.body}',
        );
      }
    });
  }

  Future<void> _saveTokenToSupabase(String token) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      debugPrint('Cannot save FID: User is not logged in');
      return;
    }

    try {
      const userTable = 'user';
      await Supabase.instance.client
          .from(userTable)
          .update({'fid_token': token})
          .eq('id', userId);
      debugPrint('FID saved to Supabase for user: $userId');
    } catch (e) {
      debugPrint('Error saving FID to Supabase: $e');
    }
  }
}
