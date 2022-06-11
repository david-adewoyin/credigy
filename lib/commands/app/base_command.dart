import 'package:credigy/models/app_model.dart';
import 'package:credigy/services/app_service.dart';
import 'package:credigy/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

BuildContext? _mainContext;
BuildContext get mainContext => _mainContext!;
bool get hasContext => _mainContext != null;

void setContext(BuildContext c) {
  _mainContext = c;
}

class BaseAppCommand {
  UserService get userService => getProvided();
  AppService get appService => getProvided();
  AppModel get appModel => getProvided();

  T getProvided<T>() {
    assert(_mainContext != null,
        "You must call setcontext(buildcontext before call commands");
    return _mainContext!.read<T>();
  }
}
