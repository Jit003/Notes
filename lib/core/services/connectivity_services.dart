import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:notes_app/core/services/sync_services.dart';

class ConnectivityService {
  static final ConnectivityService _instance =
  ConnectivityService._internal();

  factory ConnectivityService() => _instance;

  ConnectivityService._internal();

  final _sync = SyncService();

  void listen() {
    Connectivity().onConnectivityChanged.listen((status) {
      if (status != ConnectivityResult.none) {
        _sync.processQueue();
      }
    });
  }
}