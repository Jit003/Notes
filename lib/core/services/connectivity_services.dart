import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:notes_app/core/services/sync_services.dart';

class ConnectivityService {
  static final ConnectivityService _instance =
  ConnectivityService._internal();

  factory ConnectivityService() => _instance;

  ConnectivityService._internal();

  final _sync = SyncService();

  // 🔥 ADD THIS METHOD
  Future<bool> isConnected() async {
    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity == ConnectivityResult.none) return false;

    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void listen() {
    Connectivity().onConnectivityChanged.listen((status) async {
      if (status != ConnectivityResult.none) {
        // 🔥 verify real internet before syncing
        final hasInternet = await isConnected();

        if (hasInternet) {
          _sync.processQueue();
        }
      }
    });
  }
}