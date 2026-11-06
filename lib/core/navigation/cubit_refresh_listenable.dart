import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitRefreshListenable<C extends Cubit<S>, S> extends ChangeNotifier {
  final C cubit;
  late final StreamSubscription<S> _subscription;

  CubitRefreshListenable(this.cubit) {
    _subscription = cubit.stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
