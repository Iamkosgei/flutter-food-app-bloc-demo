import 'dart:developer';

import 'package:bloc/bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    log(event.toString(), name: 'BLoC !!');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(transition.toString(), name: 'BLoC >>');
  }

  @override
  void onChange(Cubit cubit, Change change) {
    super.onChange(cubit, change);
    log(change.toString(), name: 'BLoC EE');
  }
}
