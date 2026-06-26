import 'package:candidate_dashboard/core/core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final class ConnectivityBasedConnectionChecker implements ConnectionService {
  ConnectivityBasedConnectionChecker([Connectivity? connectivity])
    : connectivity = connectivity ?? Connectivity();

  final Connectivity connectivity;

  @override
  Future<bool> checkInternetConnection() async {
    try {
      final result = await connectivity.checkConnectivity();
      return result.any(
        (e) =>
            e == ConnectivityResult.mobile ||
            e == ConnectivityResult.ethernet ||
            e == ConnectivityResult.wifi,
      );
    } on Object catch (e, s) {
      throw ConnectionException(e, s);
    }
  }
}
