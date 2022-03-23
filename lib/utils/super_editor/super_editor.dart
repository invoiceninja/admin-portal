import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/super_editor/toolbar.dart';
import 'package:super_editor/super_editor.dart';

/// Example of a rich text editor.
///
/// This editor will expand in functionality as package
/// capabilities expand.
class ExampleEditor extends StatefulWidget {
  const ExampleEditor({
    Key key,
    @required this.value,
    this.onChanged,
  }) : super(key: key);

  final String value;
  final Function(String) onChanged;

  @override
  _ExampleEditorState createState() => _ExampleEditorState();
}

class _ExampleEditorState extends State<ExampleEditor> {
  final GlobalKey _docLayoutKey = GlobalKey();

  Document _doc;
  DocumentEditor _docEditor;
  DocumentComposer _composer;
  CommonEditorOperations _docOps;

  FocusNode _editorFocusNode;

  ScrollController _scrollController;

  OverlayEntry _textFormatBarOverlayEntry;
  final _textSelectionAnchor = ValueNotifier<Offset>(null);

  OverlayEntry _imageFormatBarOverlayEntry;
  final _imageSelectionAnchor = ValueNotifier<Offset>(null);

  @override
  void initState() {
    super.initState();

    _doc = deserializeMarkdownToDocument(widget.value)
      ..addListener(_hideOrShowToolbar);
    _docEditor = DocumentEditor(document: _doc as MutableDocument);
    _composer = DocumentComposer()..addListener(_hideOrShowToolbar);
    _docOps = CommonEditorOperations(
      editor: _docEditor,
      composer: _composer,
      documentLayoutResolver: () =>
          _docLayoutKey.currentState as DocumentLayout,
    );
    _editorFocusNode = FocusNode();
    _scrollController = ScrollController()..addListener(_hideOrShowToolbar);
  }

  @override
  void didUpdateWidget(ExampleEditor oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      _doc.removeListener(_hideOrShowToolbar);
      //_composer.removeListener(_hideOrShowToolbar);

      _doc = deserializeMarkdownToDocument(widget.value)
        ..addListener(_hideOrShowToolbar);
      _docEditor = DocumentEditor(document: _doc as MutableDocument);
      /*
      _composer = DocumentComposer()..addListener(_hideOrShowToolbar);
      _docOps = CommonEditorOperations(
        editor: _docEditor,
        composer: _composer,
        documentLayoutResolver: () =>
            _docLayoutKey.currentState as DocumentLayout,
      );
      */

      _editorFocusNode = FocusNode();
    }
  }

  @override
  void dispose() {
    if (_textFormatBarOverlayEntry != null) {
      _textFormatBarOverlayEntry.remove();
    }

    _doc.removeListener(_hideOrShowToolbar);
    _scrollController.removeListener(_hideOrShowToolbar);
    _composer.removeListener(_hideOrShowToolbar);

    _scrollController.dispose();
    _editorFocusNode.dispose();
    _composer.dispose();
    super.dispose();
  }

  void _hideOrShowToolbar() {
    final value = serializeDocumentToMarkdown(_docEditor.document);
    widget.onChanged(value);

    if (_gestureMode != DocumentGestureMode.mouse) {
      // We only add our own toolbar when using mouse. On mobile, a bar
      // is rendered for us.
      return;
    }

    final selection = _composer.selection;
    if (selection == null) {
      // Nothing is selected. We don't want to show a toolbar
      // in this case.
      _hideEditorToolbar();

      return;
    }
    if (selection.base.nodeId != selection.extent.nodeId) {
      // More than one node is selected. We don't want to show
      // a toolbar in this case.
      _hideEditorToolbar();
      _hideImageToolbar();

      return;
    }
    if (selection.isCollapsed) {
      // We only want to show the toolbar when a span of text
      // is selected. Therefore, we ignore collapsed selections.
      _hideEditorToolbar();
      _hideImageToolbar();

      return;
    }

    final selectedNode = _doc.getNodeById(selection.extent.nodeId);

    if (selectedNode is ImageNode) {
      // Show the editor's toolbar for image sizing.
      _showImageToolbar();
      _hideEditorToolbar();
      return;
    } else {
      // The currently selected content is not an image. We don't
      // want to show the image toolbar.
      _hideImageToolbar();
    }

    if (selectedNode is TextNode) {
      // Show the editor's toolbar for text styling.
      _showEditorToolbar();
      _hideImageToolbar();
      return;
    } else {
      // The currently selected content is not a paragraph. We don't
      // want to show a toolbar in this case.
      _hideEditorToolbar();
    }
  }

  void _showEditorToolbar() {
    if (_textFormatBarOverlayEntry == null) {
      _textFormatBarOverlayEntry ??= OverlayEntry(builder: (context) {
        return EditorToolbar(
          anchor: _textSelectionAnchor,
          editor: _docEditor,
          composer: _composer,
          closeToolbar: _hideEditorToolbar,
        );
      });

      // Display the toolbar in the application overlay.
      final overlay = Overlay.of(context);
      overlay.insert(_textFormatBarOverlayEntry);
    }

    // Schedule a callback after this frame to locate the selection
    // bounds on the screen and display the toolbar near the selected
    // text.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_textFormatBarOverlayEntry == null) {
        return;
      }

      final docBoundingBox = (_docLayoutKey.currentState as DocumentLayout)
          .getRectForSelection(
              _composer.selection.base, _composer.selection.extent);
      final docBox =
          _docLayoutKey.currentContext.findRenderObject() as RenderBox;

      final overlayBoundingBox = Rect.fromPoints(
        docBox.localToGlobal(docBoundingBox.topLeft),
        docBox.localToGlobal(docBoundingBox.bottomRight),
      );

      _textSelectionAnchor.value = overlayBoundingBox.topCenter;
    });
  }

  void _hideEditorToolbar() {
    // Null out the selection anchor so that when it re-appears,
    // the bar doesn't momentarily "flash" at its old anchor position.
    _textSelectionAnchor.value = null;

    if (_textFormatBarOverlayEntry != null) {
      // Remove the toolbar overlay and null-out the entry.
      // We null out the entry because we can't query whether
      // or not the entry exists in the overlay, so in our
      // case, null implies the entry is not in the overlay,
      // and non-null implies the entry is in the overlay.
      _textFormatBarOverlayEntry.remove();
      _textFormatBarOverlayEntry = null;
    }

    // Ensure that focus returns to the editor.
    //
    // I tried explicitly unfocus()'ing the URL textfield
    // in the toolbar but it didn't return focus to the
    // editor. I'm not sure why.
    _editorFocusNode.requestFocus();
  }

  DocumentGestureMode get _gestureMode {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return DocumentGestureMode.android;
      case TargetPlatform.iOS:
        return DocumentGestureMode.iOS;
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return DocumentGestureMode.mouse;
    }

    return null;
  }

  bool get _isMobile => _gestureMode != DocumentGestureMode.mouse;

  DocumentInputSource get _inputSource {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return DocumentInputSource.ime;
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return DocumentInputSource.keyboard;
    }

    return null;
  }

  void _cut() => _docOps.cut();
  void _copy() => _docOps.copy();
  void _paste() => _docOps.paste();
  void _selectAll() => _docOps.selectAll();

  void _showImageToolbar() {
    if (_imageFormatBarOverlayEntry == null) {
      // Create an overlay entry to build the image toolbar.
      _imageFormatBarOverlayEntry ??= OverlayEntry(builder: (context) {
        return ImageFormatToolbar(
          anchor: _imageSelectionAnchor,
          composer: _composer,
          setWidth: (dynamic nodeId, dynamic width) {
            final node = _doc.getNodeById(nodeId);
            final currentStyles =
                SingleColumnLayoutComponentStyles.fromMetadata(node);
            SingleColumnLayoutComponentStyles(
              width: width,
              padding: currentStyles.padding,
            ).applyTo(node);
          },
          closeToolbar: _hideImageToolbar,
        );
      });

      // Display the toolbar in the application overlay.
      final overlay = Overlay.of(context);
      overlay.insert(_imageFormatBarOverlayEntry);
    }

    // Schedule a callback after this frame to locate the selection
    // bounds on the screen and display the toolbar near the selected
    // text.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_imageFormatBarOverlayEntry == null) {
        return;
      }

      final docBoundingBox = (_docLayoutKey.currentState as DocumentLayout)
          .getRectForSelection(
              _composer.selection.base, _composer.selection.extent);
      final docBox =
          _docLayoutKey.currentContext.findRenderObject() as RenderBox;
      final overlayBoundingBox = Rect.fromPoints(
        docBox.localToGlobal(docBoundingBox.topLeft,
            ancestor: context.findRenderObject()),
        docBox.localToGlobal(docBoundingBox.bottomRight,
            ancestor: context.findRenderObject()),
      );

      _imageSelectionAnchor.value = overlayBoundingBox.center;
    });
  }

  void _hideImageToolbar() {
    // Null out the selection anchor so that when the bar re-appears,
    // it doesn't momentarily "flash" at its old anchor position.
    _imageSelectionAnchor.value = null;

    if (_imageFormatBarOverlayEntry != null) {
      // Remove the image toolbar overlay and null-out the entry.
      // We null out the entry because we can't query whether
      // or not the entry exists in the overlay, so in our
      // case, null implies the entry is not in the overlay,
      // and non-null implies the entry is in the overlay.
      _imageFormatBarOverlayEntry.remove();
      _imageFormatBarOverlayEntry = null;
    }

    // Ensure that focus returns to the editor.
    _editorFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _buildEditor(),
        ),
        if (_isMobile) _buildMountedToolbar(),
      ],
    );
  }

  Widget _buildEditor() {
    return SuperEditor(
      editor: _docEditor,
      composer: _composer,
      focusNode: _editorFocusNode,
      scrollController: _scrollController,
      documentLayoutKey: _docLayoutKey,
      componentBuilders: [
        ...defaultComponentBuilders,
      ],
      gestureMode: _gestureMode,
      inputSource: _inputSource,
      androidToolbarBuilder: (_) => AndroidTextEditingFloatingToolbar(
        onCutPressed: _cut,
        onCopyPressed: _copy,
        onPastePressed: _paste,
        onSelectAllPressed: _selectAll,
      ),
      iOSToolbarBuilder: (_) => IOSTextEditingFloatingToolbar(
        onCutPressed: _cut,
        onCopyPressed: _copy,
        onPastePressed: _paste,
      ),
    );
  }

  Widget _buildMountedToolbar() {
    return MultiListenableBuilder(
      listenables: <Listenable>{
        _doc,
        _composer.selectionNotifier,
      },
      builder: (_) {
        final selection = _composer.selection;

        if (selection == null) {
          return const SizedBox();
        }

        return KeyboardEditingToolbar(
          document: _doc,
          composer: _composer,
          commonOps: _docOps,
        );
      },
    );
  }
}
