import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

@immutable
final class ConnectivityBasedConnectionChecker implements ConnectionService {
  ConnectivityBasedConnectionChecker([
    Connectivity? connectivity,
  ]) : connectivity = connectivity ?? Connectivity();

  final Connectivity connectivity;

  @override
  Future<bool> checkInternetConnection() async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      return connectivityResult.any(
        (element) =>
            element == ConnectivityResult.mobile ||
            element == ConnectivityResult.ethernet ||
            element == ConnectivityResult.wifi,
      );
    } on Object catch (e, s) {
      throw ConnectionException(e, stackTrace: s);
    }
  }
}
