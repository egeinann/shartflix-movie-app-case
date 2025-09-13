import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shartflix_movie_app_case/connectivity/connectivitiy_state.dart';
import 'package:http/http.dart' as http;

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityCubit(this.connectivity) : super(ConnectivityInitial()) {
    _init();
  }

  void _init() async {
    final hasInternet = await _checkInternet();
    emit(hasInternet ? ConnectivityConnected() : ConnectivityDisconnected());

    _subscription = connectivity.onConnectivityChanged.listen((results) async {
      final hasInternet = await _checkInternet();
      if (hasInternet) {
        emit(ConnectivityConnected());
      } else {
        emit(ConnectivityDisconnected());
      }
    });
  }

  Future<bool> _checkInternet() async {
    try {
      final response = await http
          .get(Uri.parse('https://google.com'))
          .timeout(const Duration(seconds: 3));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
