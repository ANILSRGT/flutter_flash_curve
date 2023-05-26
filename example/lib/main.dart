import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_flash_curve/flutter_flash_curve.dart';

void main() => runApp(const MyApp());

enum _AnimationType {
  opacity,
  scale,
  translate,
  rotate,
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  _AnimationType _animationType = _AnimationType.opacity;
  FlashCurveType _curveType = FlashCurveType.inFlash;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      value: 0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChangedAnimationType(_AnimationType value) {
    setState(() {
      _animationType = value;
      _controller.reset();
    });
  }

  void _playAnim({required FlashCurveType curveType}) {
    if (_controller.isAnimating) return;
    setState(() {
      _curveType = curveType;
      _controller.isCompleted ? _controller.reverse(from: 1) : _controller.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flash Curve'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity), // full width for other widgets
                const SizedBox(height: 20),
                _flashAnimBuilder,
                const SizedBox(height: 20),
                _animationTypeDropdown,
                _flashButton,
                _inFlashButton,
                _outFlashButton,
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimatedBuilder get _flashAnimBuilder {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        final tween = _animationType == _AnimationType.opacity
            ? Tween(begin: 1.0, end: 0.2)
            : _animationType == _AnimationType.scale
                ? Tween(begin: 1.0, end: 0.2)
                : _animationType == _AnimationType.translate
                    ? Tween(begin: 0.0, end: 1.0)
                    : _animationType == _AnimationType.rotate
                        ? Tween(begin: 0.0, end: 1.0)
                        : Tween(begin: 0.0, end: 1.0);

        final anim = tween.animate(CurvedAnimation(
          parent: _controller,
          reverseCurve: _curveType.curve.flipped,
          curve: _curveType.curve,
        ));

        return _animationType == _AnimationType.opacity
            ? _opacityAnimWidget(value: anim.value, child: child)
            : _animationType == _AnimationType.scale
                ? _scaleAnimWidget(value: anim.value, child: child)
                : _animationType == _AnimationType.translate
                    ? _translateAnimWidget(value: anim.value, child: child)
                    : _animationType == _AnimationType.rotate
                        ? _rotateAnimWidget(value: anim.value, child: child)
                        : _errorAnimWidget;
      },
      child: const FlutterLogo(size: 100),
    );
  }

  Text get _errorAnimWidget {
    return const Text(
      'Error!',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    );
  }

  Widget _opacityAnimWidget({double value = 1, Widget? child}) {
    return Opacity(
      opacity: value,
      child: child,
    );
  }

  Widget _scaleAnimWidget({double value = 1, Widget? child}) {
    return Transform.scale(
      scale: value,
      child: child,
    );
  }

  Widget _translateAnimWidget({double value = 0, Widget? child}) {
    return Transform.translate(
      offset: Offset(lerpDouble(-100, 100, value) ?? -100, 0),
      child: child,
    );
  }

  Widget _rotateAnimWidget({double value = 0, Widget? child}) {
    return Transform.rotate(
      angle: value * 2 * math.pi,
      child: child,
    );
  }

  DropdownButton<_AnimationType> get _animationTypeDropdown {
    return DropdownButton<_AnimationType>(
      value: _animationType,
      onChanged: (value) => _onChangedAnimationType(value!),
      items: const [
        DropdownMenuItem(
          value: _AnimationType.opacity,
          child: Text('Opacity'),
        ),
        DropdownMenuItem(
          value: _AnimationType.scale,
          child: Text('Scale'),
        ),
        DropdownMenuItem(
          value: _AnimationType.translate,
          child: Text('Translate'),
        ),
        DropdownMenuItem(
          value: _AnimationType.rotate,
          child: Text('Rotate'),
        ),
      ],
    );
  }

  ElevatedButton get _flashButton {
    return ElevatedButton(
      onPressed: () => _playAnim(
        curveType: FlashCurveType.flash,
      ),
      child: const Text('Flash'),
    );
  }

  ElevatedButton get _inFlashButton {
    return ElevatedButton(
      onPressed: () => _playAnim(
        curveType: FlashCurveType.inFlash,
      ),
      child: const Text('InFlash'),
    );
  }

  ElevatedButton get _outFlashButton {
    return ElevatedButton(
      onPressed: () => _playAnim(
        curveType: FlashCurveType.outFlash,
      ),
      child: const Text('OutFlash'),
    );
  }
}
