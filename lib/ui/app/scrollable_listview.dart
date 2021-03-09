import 'package:flutter/material.dart';

class ScrollableListView extends StatefulWidget {
  const ScrollableListView({this.children});
  final List<Widget> children;

  @override
  _ScrollableListViewState createState() => _ScrollableListViewState();
}

class _ScrollableListViewState extends State<ScrollableListView> {
  ScrollController _scrollController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: Scrollbar(
        child: ListView(
          children: widget.children,
          controller: _scrollController,
          shrinkWrap: true,
        ),
        controller: _scrollController,
        isAlwaysShown: _isHovered,
      ),
    );
  }
}
