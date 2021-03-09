import 'package:flutter/material.dart';

class ScrollableListView extends StatefulWidget {
  const ScrollableListView({
    Key key,
    @required this.children,
    this.scrollController,
    this.padding,
  }) : super(key: key);

  final List<Widget> children;
  final ScrollController scrollController;
  final EdgeInsetsGeometry padding;

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
          padding: widget.padding,
          children: widget.children,
          controller: widget.scrollController ?? _scrollController,
          shrinkWrap: true,
        ),
        controller: widget.scrollController ?? _scrollController,
        isAlwaysShown: _isHovered,
      ),
    );
  }
}

class ScrollableListViewBuilder extends StatefulWidget {
  const ScrollableListViewBuilder({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
    this.separatorBuilder,
    this.scrollController,
    this.padding,
  }) : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder separatorBuilder;
  final int itemCount;
  final ScrollController scrollController;
  final EdgeInsetsGeometry padding;

  @override
  _ScrollableListViewBuilderState createState() =>
      _ScrollableListViewBuilderState();
}

class _ScrollableListViewBuilderState extends State<ScrollableListViewBuilder> {
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
        child: widget.separatorBuilder != null
            ? ListView.separated(
                separatorBuilder: widget.separatorBuilder,
                padding: widget.padding,
                itemBuilder: widget.itemBuilder,
                itemCount: widget.itemCount,
                controller: widget.scrollController ?? _scrollController,
                shrinkWrap: true,
              )
            : ListView.builder(
                padding: widget.padding,
                itemBuilder: widget.itemBuilder,
                itemCount: widget.itemCount,
                controller: widget.scrollController ?? _scrollController,
                shrinkWrap: true,
              ),
        controller: widget.scrollController ?? _scrollController,
        isAlwaysShown: _isHovered,
      ),
    );
  }
}
