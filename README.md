# flutter_flash_curve

A Flutter package to create a flash curve animation.

<p align="center">
<img src="./example/assets/gifs/opacity_flash.gif" alt="opacityFlash" title="FlashCurveAnimType.opacity" height="500"/>
<img src="./example/assets/gifs/opacity_flash.gif" alt="scaleFlash" title="FlashCurveAnimType.scale" height="500"/>
<img src="./example/assets/gifs/opacity_flash.gif" alt="translateFlash" title="FlashCurveAnimType.translate" height="500"/>
<img src="./example/assets/gifs/opacity_flash.gif" alt="rotateFlash" title="FlashCurveAnimType.rotate" height="500"/>
</p>

## 📱 Usage

1. Import package in your file

```
import 'package:flutter_flash_curve/flutter_flash_curve.dart';
```

2. Use one of the `FlashCurve | InFlashCurve | OutFlashCurve` curve classes.

```dart
    //...

    final _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
    );

    //...

    final curve = FlashCurve(flashes = 8);
    // or
    // final curve = InFlashCurve(flashes = 8);
    // or
    // final curve = OutFlashCurve(flashes = 8);

    final opacityTween = Tween(begin: 1.0, end: 0.2).animate(CurvedAnimation(
        parent: _controller,
        reverseCurve: curve.flipped,
        curve: curve,
    ));

    //...

    AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
            return Opacity(
                opacity: opacityTween.value,
                child: child,
            );
        },
        child: const FlutterLogo(size: 100),
    ),

    //...
```

## 🎛 Attributes

| Attribute | Data type | Description             | Default |
| --------- | --------- | ----------------------- | ------- |
| flashes   | int       | Number of flash periods | 8       |

## 🎨 Flash Curve Types Enum

- flash -> FlashCurveType.flash
- inFlash -> FlashCurveType.inFlash
- outFlash -> FlashCurveType.outFlash

## 📦 Extensions

| Extension             | Description                             | Result |
| --------------------- | --------------------------------------- | ------ |
| FlashCurveType->curve | Returns the curve of the FlashCurveType | Curve  |

## 💻 Author

Anıl Sorgit - [GitHub](https://github.com/ANILSRGT)
