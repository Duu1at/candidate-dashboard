abstract interface class ConnectionService {
  Future<bool> checkInternetConnection();
  Stream<bool> get onConnectivityChanged;
}
