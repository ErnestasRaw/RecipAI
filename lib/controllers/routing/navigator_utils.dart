import 'package:flutter/material.dart';
import 'package:receptai/helpers/logger_helper.dart';

/// Apply this to your [MaterialApp] to use functions in this file.
/// You can use this get context anywhere with [navigatorKey.currentContext].
///   It is better to use closer context if you have it and you should always check for null.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// can only be used if [navigatorKey] is set as your MaterialApp.navigatorKey
Future<T?>? resetNavigator<T extends Object?>({BuildContext? context}) {
  xlog('Resetting navigator', tag: 'resetNavigator');
  // xlog('stacktrace: ${StackTrace.current}', tag: 'resetNavigator');

  final navigatorState = context != null && context.mounted ? Navigator.of(context) : navigatorKey.currentState;
  if (navigatorState == null) {
    xlog(
      'Could not get navigatorState! Not resetting navigator.',
      error: 'navigatorKey.currentState is null and mounted context is not provided',
      tag: 'resetNavigator',
    );
    return null;
  }
  return navigatorState.reset();
}

Future<T?>? resetNavigatorAt<T extends Object?>({
  required WidgetBuilder builder,
  BuildContext? context,
  Object? arguments,
}) {
  final navigatorState = context != null && context.mounted ? Navigator.of(context) : navigatorKey.currentState;

  if (navigatorState == null) {
    xlog(
      'Could not get navigatorState! Not resetting navigator.',
      error: 'navigatorKey.currentState is null and mounted context is not provided',
      tag: 'resetNavigatorAt',
    );
    return null;
  }

  return navigatorState.pushAndRemoveUntil(
    MaterialPageRoute(
      builder: builder,
    ),
    (_) => false,
  );
}

extension ENavigatorState on NavigatorState {
  /// Must define 'Home' route in your MaterialApp.routes
  Future<T?> reset<T extends Object?>() => resetAtNamed<T>('Home');

  Future<T?> resetAtNamed<T extends Object?>(String name, {Object? arguments}) {
    return pushNamedAndRemoveUntil(
      name,
      (route) => false,
      arguments: arguments,
    );
  }
}

/// Shortcut to pushing plain MaterialPageRoute by only providing the [context] and [builder]
Future<T?> pushMaterial<T extends Object?>(
  BuildContext context,
  WidgetBuilder builder, {
  RouteSettings? settings,
  bool maintainState = true,
  bool fullscreenDialog = false,
}) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: builder,
      settings: settings,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
    ),
  );
}
