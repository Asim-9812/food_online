import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../API/api.dart';
import '../api_excpetions/api_exceptions.dart';
import '../states/cart_state.dart';
import '../states/order.dart';



final orderHistory = FutureProvider.autoDispose.family((ref, String id) => OrderProvider().getOrderHistory(id));
final order = Provider((ref) => OrderProvider());

class OrderProvider {

  final dio = Dio();
  Future<List<Order>> getOrderHistory(String id) async {
    try {
      final response = await dio.get('${Api.orderHistory}/$id');
      return (response.data as List).map((e) => Order.fromJson(e)).toList();
    } on DioError catch (err) {
      throw DioException.getDioError(err);
    }
  }

  Future<String> orderCreate(int amount,List<CartItem> carts, String userId, String token) async {
    try {
      final response = await dio.post(Api.orderCreate, data: {
        'amount': amount,
        'dateTime': DateTime.now().toString(),
        'products': carts.map((e) => e.toJson()).toList(),
        'userId': userId
      }, options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token'
          }
      ));
      return 'success';
    } on DioError catch (err) {
      return DioException.getDioError(err);
    }
  }


}