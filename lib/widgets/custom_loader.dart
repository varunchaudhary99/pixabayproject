import 'package:flutter/material.dart';
var appLoader =CustomLoader();
class CustomLoader {
  static CustomLoader? _loader;

  CustomLoader._createObject();

  factory CustomLoader() {
    if (_loader != null) {
      return _loader!;
    } else {
      _loader = CustomLoader._createObject();
      return _loader!;
    }
  }

  OverlayState? _overlayState;
  OverlayEntry? _overlayEntry;

  _buildLoader() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              child: buildLoader(),
              color: Colors.black.withOpacity(.3),
            )
          ],
        );
      },
    );
  }

  show(context, {bool hideDelay = false})async {
    if(!hideDelay)await Future.delayed(Duration(microseconds: 300));
    _overlayState = Overlay.of(context);
    _buildLoader();
    _overlayState!.insert(_overlayEntry!);
  }

  hide() {
    try {
      if (_overlayEntry != null) {
        _overlayEntry!.remove();
        _overlayEntry = null;
      }
    } catch (_) {}
  }

  buildLoader({isTransparent = false}) {
    return Center(
      child: Container(
        color: isTransparent ? Colors.transparent : Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.redAccent,
            backgroundColor: Colors.white,
          ),), //CircularProgressIndicator(),
      ),
    );
  }
}
