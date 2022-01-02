import 'package:connectivity_plus/connectivity_plus.dart';

/// インターネットに接続しているか
Future<bool> get networkConnected async {
  final connectivity = await Connectivity().checkConnectivity();
  return connectivity != ConnectivityResult.none;
}
