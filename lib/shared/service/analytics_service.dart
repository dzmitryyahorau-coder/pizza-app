import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  final FirebaseAnalytics _instance = FirebaseAnalytics.instance;

  Future<void> loadAppOpen() async {
    await _instance.logAppOpen();
  }

  Future<void> logViewItem({
    required String id,
    required String name,
    required String category,
    required int price,
  }) async {
    try {
      await _instance.logViewItem(
        items: [
          AnalyticsEventItem(
            itemId: id,
            itemName: name,
            itemCategory: category,
            price: price,
          ),
        ],
      );
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  Future<void> logAddToCart({
    required String id,
    required String name,
    required String category,
    required String variant,
    required int price,
    required int quantity,
  }) async {
    await _instance.logAddToCart(
      items: [
        AnalyticsEventItem(
          itemId: id,
          itemName: name,
          itemCategory: category,
          price: price,
          quantity: quantity,
        ),
      ],
    );
  }
}
