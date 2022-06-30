import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'cart.dart';
import 'pharmacyUser.dart';

class Order {
  PharmacyUser user;
  List<Cart> listCart;
  double price;
  String status;
  DateTime date;

  Order({
    required this.user,
    required this.listCart,
    required this.price,
    required this.status,
    required this.date,
  });

  Order copyWith({
    PharmacyUser? user,
    List<Cart>? listCart,
    double? price,
    String? status,
    DateTime? date,
  }) {
    return Order(
      user: user ?? this.user,
      listCart: listCart ?? this.listCart,
      price: price ?? this.price,
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'listCart': listCart.map((x) => x.toMap()).toList(),
      'price': price,
      'status': status,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      user: PharmacyUser.fromMap(map['user'] as Map<String, dynamic>),
      listCart: List<Cart>.from(
        (map['listCart'] as List<dynamic>).map<Cart>(
          (x) => Cart.fromMap(x as Map<String, dynamic>),
        ),
      ),
      price: map['price'] as double,
      status: map['status'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(user: $user, listCart: $listCart, price: $price, status: $status, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.user == user &&
        listEquals(other.listCart, listCart) &&
        other.price == price &&
        other.status == status &&
        other.date == date;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        listCart.hashCode ^
        price.hashCode ^
        status.hashCode ^
        date.hashCode;
  }
}

Order dummyOrder = Order(
  user: dummyUser,
  date: DateTime.now(),
  listCart: [],
  price: 0,
  status: '',
);
