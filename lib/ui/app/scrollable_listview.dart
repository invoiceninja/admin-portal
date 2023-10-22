// Flutter imports:
import 'package:flutter/material.dart';

class ScrollableListView extends StatefulWidget {
  const ScrollableListView({
    Key? key,
    required this.children,
    this.scrollController,
    this.padding,
    this.primary,
    this.showScrollbar = false,
  }) : super(key: key);

  final List<Widget>? children;
  final ScrollController? scrollController;
  final EdgeInsetsGeometry? padding;
  final bool? primary;
  final bool showScrollbar;

  @override
  _ScrollableListViewState createState() => _ScrollableListViewState();
}

class _ScrollableListViewState extends State<ScrollableListView> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.primary == true
        ? null
        : widget.scrollController ?? _scrollController;
    Widget child = ListView(
      padding: widget.padding,
      children: widget.children!,
      controller: controller,
      shrinkWrap: true,
      primary: widget.primary,
    );

    if (widget.showScrollbar) {
      child = Scrollbar(
        child: child,
        controller: controller,
        thumbVisibility: true,
      );
    }

    return child;
  }
}

class ScrollableListViewBuilder extends StatefulWidget {
  const ScrollableListViewBuilder({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.separatorBuilder,
    this.scrollController,
    this.padding,
    this.primary = false,
  }) : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final int? itemCount;
  final ScrollController? scrollController;
  final EdgeInsetsGeometry? padding;
  final bool primary;

  @override
  _ScrollableListViewBuilderState createState() =>
      _ScrollableListViewBuilderState();
}

class _ScrollableListViewBuilderState extends State<ScrollableListViewBuilder> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.separatorBuilder != null
        ? ListView.separated(
            primary: widget.primary,
            separatorBuilder: widget.separatorBuilder!,
            padding: widget.padding,
            itemBuilder: widget.itemBuilder,
            itemCount: widget.itemCount!,
            controller: widget.primary
                ? null
                : widget.scrollController ?? _scrollController,
            shrinkWrap: true,
          )
        : ListView.builder(
            primary: widget.primary,
            padding: widget.padding,
            itemBuilder: widget.itemBuilder,
            itemCount: widget.itemCount,
            controller: widget.primary
                ? null
                : widget.scrollController ?? _scrollController,
            shrinkWrap: true,
          );
  }
}
