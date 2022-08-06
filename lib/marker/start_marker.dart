import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class StarkMarkerPaint extends CustomPainter {
 final int? minutes;
final String? destination;

StarkMarkerPaint({
  this.minutes,
  this.destination
});

  @override
  void paint(Canvas canvas, Size size) {
//crear lapiz
    final blackPaint = Paint()..color = Color.fromRGBO(0, 0, 0, 1);
    final whitePaint = Paint()..color = Colors.white;

//sumar y resptar el tamaño del radio en Y y X
    const double circuleBlacklRaduis = 20;
    const double circuleWhiteRaduis = 7;
//circulo negro
    canvas.drawCircle(
        Offset(circuleBlacklRaduis, size.height - circuleBlacklRaduis),
        circuleBlacklRaduis,
        blackPaint);
    //circulo Blanco
    canvas.drawCircle(
        Offset(circuleBlacklRaduis, size.height - circuleBlacklRaduis),
        circuleWhiteRaduis,
        whitePaint);
    final path = Path();

    //dibujar una caja blanca
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);
    //sombra

    canvas.drawShadow(path, Colors.black, 10, false);

    canvas.drawPath(path, whitePaint);
    //caja negra
    const blackBox = Rect.fromLTWH(40, 20, 70, 80);

    canvas.drawRect(blackBox, blackPaint);

    //textos
    //mintos
    final textSpan = TextSpan(
      style: const TextStyle(
          color: Colors.yellow, fontSize: 30, fontWeight: FontWeight.w400),
      text: minutes.toString(),
    );
    final minutesPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(minWidth: 70, maxWidth: 70);

    minutesPainter.paint(canvas, Offset(40, 35));
    //palabra MIN
    const minutesText = TextSpan(
      style: TextStyle(
          color: Colors.yellow, fontSize: 20, fontWeight: FontWeight.w400),
      text: 'MIn',
    );
    final minuteMinPainter = TextPainter(
      text: minutesText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(minWidth: 70, maxWidth: 70);

    minuteMinPainter.paint(canvas, const Offset(40, 68));

    //description

    final locationText = TextSpan(
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w300),
      text: destination,
    );
    final locationPainter = TextPainter(
      maxLines: 2,
      ellipsis: '...',
      text: locationText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    )..layout(minWidth: size.width - 135, maxWidth: size.width - 135);
    final double offsety = (destination!.length > 20) ? 35 : 48;

    locationPainter.paint(canvas, Offset(120, offsety));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
