import 'package:connectivity/connectivity.dart';

class ConnectionChecker {
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print("Connected");
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      print("Not connected");
      return false;
    }
  }
}
