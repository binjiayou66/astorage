import 'dart:async';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui show window;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'dart:collection';
import 'dart:ui' as ui show window, PointerDataPacket;

void runScreenAdapter(Widget app, {@required Size uiSize}) {
  AWidgetsFlutterBinding.ensureInitialized(uiSize)
    ..scheduleAttachRootWidget(app)
    ..scheduleWarmUpFrame();
}

class AWidgetsFlutterBinding extends WidgetsFlutterBinding {
  static const String TAG = "【ZYWidgetsFlutterBinding】";
  final Size uiSize;

  AWidgetsFlutterBinding(this.uiSize);

  static AWidgetsFlutterBinding ensureInitialized(Size uiSize) {
    assert(uiSize != null);
    if (WidgetsBinding.instance == null) AWidgetsFlutterBinding(uiSize);
    return WidgetsBinding.instance;
  }

  @protected
  void scheduleAttachRootWidget(Widget rootWidget) {
    Timer.run(() {
      attachRootWidget(RoorRenderObjectWidget(rootWidget));
    });
    Text("", textScaleFactor: 1);
  }

  @override
  ViewConfiguration createViewConfiguration() {
    //super.createViewConfiguration();
    return ViewConfiguration(
      size: window.physicalSize / _getAdapterDevicePixelRatio(),
      devicePixelRatio: _getAdapterDevicePixelRatio(),
    );
  }

  @override
  void initInstances() {
    super.initInstances();
    ui.window.onPointerDataPacket = _handlePointerDataPacket;
  }

  @override
  void unlocked() {
    super.unlocked();
    _flushPointerEventQueue();
  }

  final Queue<PointerEvent> _pendingPointerEvents = Queue<PointerEvent>();

  void _handlePointerDataPacket(ui.PointerDataPacket packet) {
    _pendingPointerEvents.addAll(PointerEventConverter.expand(
        packet.data, _getAdapterDevicePixelRatio()));
    if (!locked) _flushPointerEventQueue();
  }

  @override
  void cancelPointer(int pointer) {
    if (_pendingPointerEvents.isEmpty && !locked)
      scheduleMicrotask(_flushPointerEventQueue);
    _pendingPointerEvents.addFirst(PointerCancelEvent(pointer: pointer));
  }

  void _flushPointerEventQueue() {
    assert(!locked);
    while (_pendingPointerEvents.isNotEmpty)
      _handlePointerEvent(_pendingPointerEvents.removeFirst());
  }

  final Map<int, HitTestResult> _hitTests = <int, HitTestResult>{};

  void _handlePointerEvent(PointerEvent event) {
    assert(!locked);
    HitTestResult result;
    if (event is PointerDownEvent) {
      assert(!_hitTests.containsKey(event.pointer));
      result = HitTestResult();
      hitTest(result, event.position);
      _hitTests[event.pointer] = result;
      assert(() {
        if (debugPrintHitTestResults) debugPrint('$event: $result');
        return true;
      }());
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      result = _hitTests.remove(event.pointer);
    } else if (event.down) {
      result = _hitTests[event.pointer];
    } else {
      return; // We currently ignore add, remove, and hover move events.
    }
    if (result != null) dispatchEvent(event, result);
  }

  double _getAdapterDevicePixelRatio() {
    return ui.window.physicalSize.width / uiSize.width;
  }
}

class RoorRenderObjectWidget extends SingleChildRenderObjectWidget {
  RoorRenderObjectWidget(rootChild) : super(child: rootChild);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderInner();
  }
}

class RenderInner extends RenderPadding {
  RenderInner() : super(padding: EdgeInsets.all(0));

  @override
  Size get size => printSize();

  printSize() {
    return super.size;
  }
}
