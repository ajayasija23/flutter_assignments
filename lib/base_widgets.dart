
import 'package:flutter/material.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({super.key});

  /// Child classes must implement this method
  Widget buildBody(BuildContext context);

  void initState(){}

  @override
  State<BaseStatefulWidget> createState() => _BaseStatefulWidgetState();
}

class _BaseStatefulWidgetState extends State<BaseStatefulWidget> {

  @override
  void initState() {
    super.initState();
    widget.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.buildBody(context),
    );
  }
}

abstract class BaseStatelessWidget extends StatelessWidget {
  const BaseStatelessWidget({super.key});

  /// Child classes must implement this method
  Widget buildBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }
}
