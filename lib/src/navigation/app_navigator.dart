import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppNavigator {
  static final navigatorKey = GlobalKey<NavigatorState>();

  const AppNavigator();

  Future<R?> push<R>(
    Route<R> route, {
    BuildContext? context,
    bool useRoot = false,
  }) async {
    return _navigator(context, useRoot: useRoot).push(route);
  }

  Future<R?> pushReplacement<R>(
    Route<R> route, {
    BuildContext? context,
    bool useRoot = false,
  }) async {
    return _navigator(context, useRoot: useRoot).pushReplacement(route);
  }

  void popUntilRoot(BuildContext context) =>
      _navigator(context).popUntil((route) => route.isFirst);

  void pop({
    BuildContext? context,
  }) =>
      _navigator(
        context,
      )..pop();

  static NavigatorState _navigator(
    BuildContext? context, {
    bool useRoot = false,
  }) =>
      (context == null || useRoot)
          ? navigatorKey.currentState!
          : Navigator.of(context);
}
