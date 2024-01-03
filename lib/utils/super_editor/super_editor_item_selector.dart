import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

/// A selection control, which displays a button with the selected item, and upon tap, displays a
/// popover list of available text options, from which the user can select a different
/// option.
///
/// Unlike Flutter `DropdownButton`, which displays the popover list in a separate route,
/// this widget displays its popover list in an `Overlay`. By using an `Overlay`, focus can be shared
/// with the [parentFocusNode]. This means that when the popover list requests focus, [parentFocusNode]
/// still has non-primary focus.
///
/// The popover list is positioned based on the following rules:
///
///    1. The popover is displayed below the selected item, if there's enough room, or
///    2. The popover is displayed above the selected item, if there's enough room, or
///    3. The popover is displayed with its bottom aligned with the bottom of
///         the given boundary, and it covers the selected item.
///
/// The popover list height is based on the following rules:
///
///    1. The popover is displayed as tall as all items in the list, if there's enough room, or
///    2. The popover is displayed as tall as the available space and becomes scrollable.
///
/// The popover list includes keyboard selection behaviors:
///
///   * Pressing UP/DOWN moves the "active" item selection up/down.
///   * Pressing UP with the first item active moves the active item selection to the last item.
///   * Pressing DOWN with the last item active moves the active item selection to the first item.
///   * Pressing ENTER selects the currently active item and closes the popover list.
class SuperEditorDemoTextItemSelector extends StatefulWidget {
  const SuperEditorDemoTextItemSelector({
    super.key,
    this.parentFocusNode,
    this.boundaryKey,
    this.id,
    required this.items,
    required this.onSelected,
  });

  /// The [FocusNode], to which the popover list's [FocusNode] will be added as a child.
  ///
  /// In Flutter, [FocusNode]s have parents and children. This relationship allows an
  /// entire ancestor path to "have focus", but only the lowest level descendant
  /// in that path has "primary focus". This path is important because various
  /// widgets alter their presentation or behavior based on whether or not they
  /// currently have focus, even if they only have "non-primary focus".
  ///
  /// When the popover list of items is visible, that list will have primary focus.
  /// Moreover, because the popover list is built in an `Overlay`, none of your
  /// widgets are in the natural focus path for that popover list. Therefore, if you
  /// need your widget tree to retain focus while the popover list is visible, then
  /// you need to provide the [FocusNode] that the popover list should use as its
  /// parent, thereby retaining focus for your widgets.
  final FocusNode? parentFocusNode;

  /// A [GlobalKey] to a widget that determines the bounds where the popover list can be displayed.
  ///
  /// As the popover list follows the selected item, it can be displayed off-screen if this [SuperEditorDemoTextItemSelector]
  /// is close to the bottom of the screen.
  ///
  /// Passing a [boundaryKey] causes the popover list to be confined to the bounds of the widget
  /// bound to the [boundaryKey].
  ///
  /// If `null`, the popover list is confined to the screen bounds, defined by the result of `MediaQuery.sizeOf`.
  final GlobalKey? boundaryKey;

  /// The currently selected value or `null` if no item is selected.
  ///
  /// This value is used to build the button.
  final SuperEditorDemoTextItem? id;

  /// The items that will be displayed in the popover list.
  ///
  /// For each item, its [SuperEditorDemoTextItem.label] is displayed.
  final List<SuperEditorDemoTextItem> items;

  /// Called when the user selects an item on the popover list.
  final void Function(SuperEditorDemoTextItem? value) onSelected;

  @override
  State<SuperEditorDemoTextItemSelector> createState() =>
      _SuperEditorDemoTextItemSelectorState();
}

class _SuperEditorDemoTextItemSelectorState
    extends State<SuperEditorDemoTextItemSelector> {
  /// Shows and hides the popover.
  final PopoverController _popoverController = PopoverController();

  /// The [FocusNode] of the popover list.
  final FocusNode _popoverFocusNode = FocusNode();

  @override
  void dispose() {
    _popoverController.dispose();
    _popoverFocusNode.dispose();
    super.dispose();
  }

  void _onItemSelected(SuperEditorDemoTextItem? value) {
    _popoverController.close();
    widget.onSelected(value);
  }

  @override
  Widget build(BuildContext context) {
    return PopoverScaffold(
      controller: _popoverController,
      buttonBuilder: _buildButton,
      popoverFocusNode: _popoverFocusNode,
      parentFocusNode: widget.parentFocusNode,
      boundaryKey: widget.boundaryKey,
      popoverBuilder: (context) => RoundedRectanglePopoverAppearance(
        child: ItemSelectionList<SuperEditorDemoTextItem>(
          focusNode: _popoverFocusNode,
          value: widget.id,
          items: widget.items,
          itemBuilder: _buildPopoverListItem,
          onItemSelected: _onItemSelected,
          onCancel: () => _popoverController.close(),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return SuperEditorPopoverButton(
      padding: const EdgeInsets.only(left: 16.0, right: 24),
      onTap: () => _popoverController.open(),
      child: widget.id == null //
          ? const SizedBox()
          : Text(
              widget.id!.label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
    );
  }

  Widget _buildPopoverListItem(BuildContext context,
      SuperEditorDemoTextItem item, bool isActive, VoidCallback onTap) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isActive ? Colors.grey.withOpacity(0.2) : Colors.transparent,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints:
              const BoxConstraints(minHeight: kMinInteractiveDimension),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            item.label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

/// An option that is displayed as text by a [SuperEditorDemoTextItemSelector].
///
/// Two [SuperEditorDemoTextItem]s are considered to be equal if they have the same [id].
class SuperEditorDemoTextItem {
  const SuperEditorDemoTextItem({
    required this.id,
    required this.label,
  });

  /// The value that identifies this item.
  final String id;

  /// The text that is displayed.
  final String label;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuperEditorDemoTextItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// A selection control, which displays a button with the selected item, and upon tap, displays a
/// popover list of available icons, from which the user can select a different option.
///
/// Unlike Flutter `DropdownButton`, which displays the popover list in a separate route,
/// this widget displays its popover list in an `Overlay`. By using an `Overlay`, focus can be shared
/// with the [parentFocusNode]. This means that when the popover list requests focus, [parentFocusNode]
/// still has non-primary focus.
///
/// The popover list is positioned based on the following rules:
///
///    1. The popover is displayed below the selected item, if there's enough room, or
///    2. The popover is displayed above the selected item, if there's enough room, or
///    3. The popover is displayed with its bottom aligned with the bottom of
///         the given boundary, and it covers the selected item.
///
/// The popover list height is based on the following rules:
///
///    1. The popover is displayed as tall as all items in the list, if there's enough room, or
///    2. The popover is displayed as tall as the available space and becomes scrollable.
///
/// The popover list includes keyboard selection behaviors:
///
///   * Pressing UP/DOWN moves the "active" item selection up/down.
///   * Pressing UP with the first item active moves the active item selection to the last item.
///   * Pressing DOWN with the last item active moves the active item selection to the first item.
///   * Pressing ENTER selects the currently active item and closes the popover list.
class SuperEditorDemoIconItemSelector extends StatefulWidget {
  const SuperEditorDemoIconItemSelector({
    super.key,
    this.parentFocusNode,
    this.boundaryKey,
    this.value,
    required this.items,
    required this.onSelected,
  });

  /// The [FocusNode], to which the popover list's [FocusNode] will be added as a child.
  ///
  /// In Flutter, [FocusNode]s have parents and children. This relationship allows an
  /// entire ancestor path to "have focus", but only the lowest level descendant
  /// in that path has "primary focus". This path is important because various
  /// widgets alter their presentation or behavior based on whether or not they
  /// currently have focus, even if they only have "non-primary focus".
  ///
  /// When the popover list of items is visible, that list will have primary focus.
  /// Moreover, because the popover list is built in an `Overlay`, none of your
  /// widgets are in the natural focus path for that popover list. Therefore, if you
  /// need your widget tree to retain focus while the popover list is visible, then
  /// you need to provide the [FocusNode] that the popover list should use as its
  /// parent, thereby retaining focus for your widgets.
  final FocusNode? parentFocusNode;

  /// A [GlobalKey] to a widget that determines the bounds where the popover list can be displayed.
  ///
  /// As the popover list follows the selected item, it can be displayed off-screen if this [SuperEditorDemoIconItemSelector]
  /// is close to the bottom of the screen.
  ///
  /// Passing a [boundaryKey] causes the popover list to be confined to the bounds of the widget
  /// bound to the [boundaryKey].
  ///
  /// If `null`, the popover list is confined to the screen bounds, defined by the result of `MediaQuery.sizeOf`.
  final GlobalKey? boundaryKey;

  /// The currently selected value or `null` if no item is selected.
  ///
  /// This value is used to build the button.
  final SuperEditorDemoIconItem? value;

  /// The items that will be displayed in the popover list.
  ///
  /// For each item, its [SuperEditorDemoIconItem.icon] is displayed.
  final List<SuperEditorDemoIconItem> items;

  /// Called when the user selects an item on the popover list.
  final void Function(SuperEditorDemoIconItem? value) onSelected;

  @override
  State<SuperEditorDemoIconItemSelector> createState() =>
      _SuperEditorDemoIconItemSelectorState();
}

class _SuperEditorDemoIconItemSelectorState
    extends State<SuperEditorDemoIconItemSelector> {
  /// Shows and hides the popover.
  final PopoverController _popoverController = PopoverController();

  /// The [FocusNode] of the popover list.
  final FocusNode _popoverFocusNode = FocusNode();

  @override
  void dispose() {
    _popoverController.dispose();
    _popoverFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopoverScaffold(
      controller: _popoverController,
      buttonBuilder: _buildButton,
      popoverFocusNode: _popoverFocusNode,
      parentFocusNode: widget.parentFocusNode,
      popoverBuilder: (context) => RoundedRectanglePopoverAppearance(
        child: ItemSelectionList<SuperEditorDemoIconItem>(
          value: widget.value,
          items: widget.items,
          itemBuilder: _buildItem,
          onItemSelected: _onItemSelected,
          onCancel: () => _popoverController.close(),
          focusNode: _popoverFocusNode,
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, SuperEditorDemoIconItem item,
      bool isActive, VoidCallback onTap) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isActive ? Colors.grey.withOpacity(0.2) : Colors.transparent,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints:
              const BoxConstraints(minHeight: kMinInteractiveDimension),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(item.icon),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return SuperEditorPopoverButton(
      onTap: () => _popoverController.open(),
      padding: const EdgeInsets.only(left: 8.0, right: 24),
      child: widget.value == null //
          ? const SizedBox()
          : Icon(widget.value!.icon),
    );
  }

  void _onItemSelected(SuperEditorDemoIconItem? value) {
    _popoverController.close();
    widget.onSelected(value);
  }
}

/// An option that is displayed as an icon by a [SuperEditorDemoIconItemSelector].
///
/// Two [SuperEditorDemoIconItem]s are considered to be equal if they have the same [id].
class SuperEditorDemoIconItem {
  const SuperEditorDemoIconItem({
    required this.id,
    required this.icon,
  });

  /// The value that identifies this item.
  final String id;

  /// The icon that is displayed.
  final IconData icon;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuperEditorDemoIconItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// A button with a center-left aligned [child] and a right aligned arrow icon.
///
/// The arrow is displayed above the [child].
class SuperEditorPopoverButton extends StatelessWidget {
  const SuperEditorPopoverButton({
    super.key,
    this.padding,
    required this.onTap,
    this.child,
  });

  /// Padding around the [child].
  final EdgeInsets? padding;

  /// Called when the user taps the button.
  final VoidCallback onTap;

  /// The Widget displayed inside this button.
  ///
  /// If `null`, only the arrow is displayed.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            if (child != null) //
              Padding(
                padding: padding ?? EdgeInsets.zero,
                child: child,
              ),
            const Positioned(
              right: 0,
              child: Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
      ),
    );
  }
}
