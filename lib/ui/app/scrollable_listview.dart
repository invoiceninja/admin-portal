// Flutter imports:
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
    return ListView(
      padding: widget.padding,
      children: widget.children,
      controller: widget.scrollController ?? _scrollController,
      shrinkWrap: true,
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
    return widget.separatorBuilder != null
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
          );
  }
}
