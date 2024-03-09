import 'package:flutter/material.dart';

class AutoSizeWidget extends StatefulWidget {
  const AutoSizeWidget({
    super.key,
    required this.builder,
    required this.getWidgetToVerifySize,
  });

  //builder
  final Widget Function(BuildContext, Size) builder;

  final Widget getWidgetToVerifySize;

  @override
  State<AutoSizeWidget> createState() => _AutoSizeWidgetState();
}

class _AutoSizeWidgetState extends State<AutoSizeWidget> {
  var key = GlobalKey();

  late Widget content;

  @override
  void initState() {
    super.initState();
    content = Container(
      key: key,
      child: widget.getWidgetToVerifySize,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      content = widget.builder(context, getSize());
      setState(() {});
    });
  }

  Size getSize() {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      return renderBox.size;
    }
    return Size.zero;
  }

  @override
  Widget build(BuildContext context) {
    if(key.currentContext != null){
      return widget.builder(context, getSize());
    }
    return content;
  }
}
