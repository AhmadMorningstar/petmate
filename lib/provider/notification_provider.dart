import 'package:flutter/material.dart';
import 'package:petmate/models/cart_model.dart';

class NotificationProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _notifications = [];

  List<Map<String, dynamic>> get notifications => _notifications;

  void addNotification(List<CartModel> items, double totalAmount) {
    _notifications.add({
      'items': List.from(items), // Clone the list to avoid reference issues
      'totalAmount': totalAmount,
      'date': DateTime.now(),
    });
    notifyListeners();
  }

  void clearNotifications() {
    _notifications.clear();
    notifyListeners();
  }
}
