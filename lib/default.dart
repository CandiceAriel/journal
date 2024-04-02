import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

// ignore: must_be_immutable
class DefaultScaffold extends StatefulWidget {
  DefaultScaffold({ 
    Key? key,
    required this.bodyWidget,
    this.title = '',
    this.isShowLeading = false,
    this.isShowAction = false,
    this.isBodyScroll = true,
    this.disableExpiryCheck = false,
    this.isFullWidth = false
  }) : super(key: key);

  Widget bodyWidget;
  String title;
  bool isShowLeading;
  bool isShowAction;
  bool isBodyScroll;
  bool disableExpiryCheck;
  bool isFullWidth;
  bool isNewMessage = false;
  @override
  State<DefaultScaffold> createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<DefaultScaffold> {
  @override
  Widget build(BuildContext context) {
    Widget tabWidget = Container(
        alignment: Alignment.center,
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  // constraints:
                  //     BoxConstraints(maxWidth: ScreenConstants.maxWidth),
                  child: widget.bodyWidget),
            ]));

    return Scaffold(
      appBar: _createAppBar( context, widget.title, widget.isShowLeading ),
      body: SafeArea(
        child: widget.isBodyScroll
          ? SingleChildScrollView(
            child: widget.isFullWidth ||
              MediaQuery.of(context).size.width < ScreenConstants.tabWidth
              ? widget.bodyWidget
              : tabWidget
          )
          : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: widget.isFullWidth ||
              MediaQuery.of(context).size.width < ScreenConstants.tabWidth
              ? widget.bodyWidget
              : tabWidget
          )
        ),
    );
  }

  goToHomePage(){
    Navigator.pushNamed(context, '/home');
  }
}

AppBar _createAppBar(context, title, isShowLeading){
    return AppBar(
      centerTitle: true,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      leading: Builder( 
        builder: (BuildContext context) {
          return isShowLeading 
          ? IconButton(
            padding: EdgeInsets.zero,
            //constraints: const BoxConstraints(),
            icon: const Icon(Icons.menu_rounded),
            onPressed: () {})
          : IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              icon: Icon(Icons.chevron_left),
            );
        }),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          }, 
            icon: Icon(Icons.shopping_cart)
        )
      ],
    );
  }

