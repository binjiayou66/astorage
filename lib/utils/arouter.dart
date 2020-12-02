import 'package:flutter/material.dart';

class ARouter {
  static Future push(
    BuildContext context, {
    Widget page,
    Route route,
  }) {
    if (page == null && route == null) return Future.error('Invalid Arguments');
    if (page != null)
      return Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => page),
      );
    return Navigator.of(context).push(route);
  }

  /// push route with name
  static Future pushNamed(
    BuildContext context,
    String routeName, {
    Object arguments,
  }) {
    return Navigator.of(context).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// pushReplacement page or route
  static Future pushReplacement<TO extends Object>(
    BuildContext context, {
    Widget page,
    Route route,
    TO result,
  }) {
    if (page == null && route == null) return Future.error('Invalid Arguments');
    if (page != null)
      return Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => page),
        result: result,
      );
    return Navigator.of(context).pushReplacement(route, result: result);
  }

  /// pushReplacement route with name
  static Future pushReplacementNamed<TO extends Object>(
    BuildContext context,
    String routeName, {
    TO result,
    Object arguments,
  }) {
    return Navigator.of(context).pushReplacementNamed(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  /// pushAndRemoveUntil page or route
  static Future pushAndRemoveUntil(
    BuildContext context, {
    Widget page,
    Route route,
    @required RoutePredicate predicate,
  }) {
    if (page == null && route == null) return Future.error('Invalid Arguments');
    if (page != null)
      return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => page),
        predicate,
      );
    return Navigator.of(context).pushAndRemoveUntil(route, predicate);
  }

  /// pushAndRemoveUntil route with name
  static Future pushNamedAndRemoveUntil(
    BuildContext context,
    String routeName, {
    Object arguments,
    @required RoutePredicate predicate,
  }) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  /// popAndPush route with name
  static Future popAndPushNamed<TO extends Object>(
    BuildContext context,
    String routeName, {
    TO result,
    Object arguments,
  }) {
    return Navigator.of(context).popAndPushNamed(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  static bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  static void pop<T extends Object>(BuildContext context, [T result]) {
    Navigator.of(context).pop(result);
  }

  static void maybePop<T extends Object>(BuildContext context, [T result]) {
    Navigator.of(context).maybePop(result);
  }

  static void popUntil(BuildContext context, RoutePredicate predicate) {
    Navigator.of(context).popUntil(predicate);
  }
}
