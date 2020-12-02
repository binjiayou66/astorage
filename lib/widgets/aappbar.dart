import 'package:astorage/defines/acolors.dart';
import 'package:astorage/defines/afont.dart';
import 'package:flutter/material.dart';

class AAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool noLeading;
  final Widget leading;
  final Widget title;
  final String textTitle;
  final List<Widget> actions;
  final Widget flexibleSpace;
  final PreferredSizeWidget bottom;
  final double elevation;
  final ShapeBorder shape;
  final Color backgroundColor;
  final Brightness brightness;
  final IconThemeData iconTheme;
  final IconThemeData actionsIconTheme;
  final TextTheme textTheme;
  final bool primary;
  final double titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  final VoidCallback callBack;

  AAppBar({
    Key key,
    this.noLeading = false,
    this.leading,
    this.title,
    this.textTitle,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation = 0.0,
    this.shape,
    this.backgroundColor = AColors.white,
    this.brightness = Brightness.light,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.callBack,
  })  : assert(elevation == null || elevation >= 0.0),
        assert(primary != null),
        assert(titleSpacing != null),
        assert(toolbarOpacity != null),
        assert(bottomOpacity != null),
        preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final usedLeading =
        noLeading ? null : (leading ?? _defualtLeading(context));
    return AppBar(
      key: key,
      leading: usedLeading,
      title: textTitle == null ? title : _defualtTextTitle(context),
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      shape: shape,
      backgroundColor: backgroundColor,
      brightness: brightness,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      textTheme: textTheme,
      primary: primary,
      titleSpacing: titleSpacing,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
      automaticallyImplyLeading: false,
      centerTitle: true,
    );
  }

  @override
  final Size preferredSize;

  Widget _defualtLeading(BuildContext context) {
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 56.0),
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(
          useCloseButton ? Icons.close : Icons.arrow_back_ios,
          size: 24,
          color: AColors.textMain,
        ),
        onPressed: () {
          callBack?.call();
          Navigator.maybePop(context);
        },
      ),
    );
  }

  Widget _defualtTextTitle(BuildContext context) {
    return Text(
      textTitle,
      style: TextStyle(
        fontSize: AFontSize.title2,
        fontWeight: FontWeight.bold,
        color: AColors.textMain,
      ),
    );
  }
}
