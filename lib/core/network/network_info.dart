import 'package:connectivity_plus/connectivity_plus.dart';

/// Abstract interface for checking network connectivity
abstract class NetworkInfo {
  /// Check if device is currently connected to the internet
  Future<bool> get isConnected;

  /// Stream that emits connectivity changes
  Stream<bool> get onConnectivityChanged;
}

/// Implementation of NetworkInfo using connectivity_plus package
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl(this._connectivity);

  @override
  Future<bool> get isConnected async {
    try {
      final result = await _connectivity.checkConnectivity();
      return _isConnectedResult(result);
    } catch (e) {
      // If we can't check connectivity, assume we're offline
      return false;
    }
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map(_isConnectedResult);
  }

  /// Helper to determine if a ConnectivityResult means we're connected
  bool _isConnectedResult(List<ConnectivityResult> results) {
    // If the list contains anything other than 'none', we consider it connected
    return results.isNotEmpty && !results.contains(ConnectivityResult.none);
  }
}
