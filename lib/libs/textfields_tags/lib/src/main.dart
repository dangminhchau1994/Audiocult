import 'package:flutter/material.dart';
import 'models.dart';

typedef Validator = String? Function(String tag);

enum LetterCase { none, small, capital }

class TextFieldTags extends StatefulWidget {
  ///[tagsStyler] must not be [null]
  final TagsStyler tagsStyler;

  ///[textFieldStyler] must not be [null]
  final TextFieldStyler textFieldStyler;

  ///[onTag] must not be [null] and should be implemented
  final void Function(String tag) onTag;

  ///[onDelete] must not be [null]
  final void Function(String tag) onDelete;

  ///[validator] allows you to validate the tag that has been entered
  final Validator? validator;

  ///[initialTags] are optional initial tags you can enter
  final List<String>? initialTags;

  ///Padding for the scrollable
  final EdgeInsets scrollableTagsPadding;

  ///Margin for the scrollable
  final EdgeInsets? scrollableTagsMargin;

  ///[tagsDistanceFromBorder] sets the distance of the tags from the border
  final double tagsDistanceFromBorderEnd;

  ///Enter optional String separators to split tags. Default is [","," "]
  final List<String>? textSeparators;

  ///Enter your own text editing Controller for more custom usage
  final TextEditingController? textEditingController;

  ///Change the letter case of the text entered by user. Default is set to small letter[LetterCase.small]
  final LetterCase letterCase;

  const TextFieldTags({
    Key? key,
    this.tagsDistanceFromBorderEnd = 0.725,
    this.scrollableTagsPadding = const EdgeInsets.symmetric(horizontal: 4.0),
    this.scrollableTagsMargin,
    this.validator,
    this.initialTags = const [],
    this.textSeparators = const [' ', ','],
    this.textEditingController,
    this.letterCase = LetterCase.small,
    required this.tagsStyler,
    required this.textFieldStyler,
    required this.onTag,
    required this.onDelete,
  }) : super(key: key);

  @override
  TextFieldTagsState createState() => TextFieldTagsState();
}

class TextFieldTagsState extends State<TextFieldTags> {
  Set<String>? _tagsStringContents;
  TextEditingController? _textEditingController;
  ScrollController? _scrollController;
  late bool _showPrefixIcon;
  late double _deviceWidth;
  late bool _showValidator;
  late String _validatorMessage;
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _showValidator = false;
    _tagsStringContents = Set.from(widget.initialTags!);
    _showPrefixIcon = _tagsStringContents!.isNotEmpty;
    _textEditingController = widget.textEditingController ?? TextEditingController();
    _scrollController = ScrollController();
    _animateTransition();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _deviceWidth = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController!.dispose();
    _scrollController!.dispose();
    _tagsStringContents = null;
    _textEditingController = null;
    _scrollController = null;
  }

  List<Widget> get _getTags {
    List<Widget> _tags = [];
    for (var i = 0; i < _tagsStringContents!.length; i++) {
      final String stringContent = _tagsStringContents!.elementAt(i);
      final String stringContentWithHash = widget.tagsStyler.showHashtag ? '#$stringContent' : stringContent;
      final Container tag = Container(
        padding: widget.tagsStyler.tagPadding,
        decoration: widget.tagsStyler.tagDecoration,
        margin: widget.tagsStyler.tagMargin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: widget.tagsStyler.tagTextPadding,
              child: Text(
                stringContentWithHash,
                style: widget.tagsStyler.tagTextStyle,
              ),
            ),
            Padding(
              padding: widget.tagsStyler.tagCancelIconPadding,
              child: GestureDetector(
                onTap: () {
                  onDeleted(stringContent);
                },
                child: widget.tagsStyler.tagCancelIcon,
              ),
            ),
          ],
        ),
      );
      _tags.add(tag);
    }
    return _tags;
  }

  void _animateTransition() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_scrollController!.hasClients) {
        _scrollController!.animateTo(
          _scrollController!.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      }
    });
  }

  void onDeleted(String stringContent) {
    widget.onDelete(stringContent);
    if (_tagsStringContents!.length <= 1 && _showPrefixIcon) {
      setState(() {
        _tagsStringContents!.remove(stringContent);
        _showPrefixIcon = false;
      });
    } else {
      setState(() {
        _tagsStringContents!.remove(stringContent);
      });
    }
  }

  void clear() {
    _textEditingController?.clear();
    _tagsStringContents?.clear();
    _textEditingController
      ?..text = ''
      ..selection = TextSelection.collapsed(offset: 0);
    _animateTransition();
    _showPrefixIcon = false;
    setState(() {});
  }

  void onSubmit(String value) {
    if (value.isNotEmpty != true) return;
    if (_showValidator == false) {
      final val = widget.letterCase == LetterCase.small
          ? value.trim()
          : widget.letterCase == LetterCase.capital
              ? value.trim()
              : value.trim();
      _textEditingController!.clear();
      if (widget.validator == null || widget.validator!(val) == null) {
        widget.onTag(val);
        if (!_showPrefixIcon) {
          setState(() {
            _tagsStringContents!.add(val);
            _showPrefixIcon = true;
          });
        } else {
          setState(() {
            _tagsStringContents!.add(val);
          });
        }
        _animateTransition();
      } else {
        setState(() {
          _showValidator = true;
          _validatorMessage = widget.validator!(val)!;
        });
      }
    }
    _focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focus,
      keyboardType: widget.textFieldStyler.textInputType,
      readOnly: widget.textFieldStyler.readOnly,
      controller: _textEditingController,
      autocorrect: false,
      cursorColor: widget.textFieldStyler.cursorColor,
      style: widget.textFieldStyler.textStyle,
      decoration: InputDecoration(
        icon: widget.textFieldStyler.icon,
        contentPadding: widget.textFieldStyler.contentPadding,
        isDense: widget.textFieldStyler.isDense,
        helperText: _showValidator ? _validatorMessage : widget.textFieldStyler.helperText,
        helperStyle: _showValidator ? const TextStyle(color: Colors.red) : widget.textFieldStyler.helperStyle,
        hintText: !_showPrefixIcon ? widget.textFieldStyler.hintText : null,
        hintStyle: !_showPrefixIcon ? widget.textFieldStyler.hintStyle : null,
        filled: widget.textFieldStyler.textFieldFilled,
        fillColor: widget.textFieldStyler.textFieldFilledColor,
        enabled: widget.textFieldStyler.textFieldEnabled,
        border: widget.textFieldStyler.textFieldBorder,
        focusedBorder: widget.textFieldStyler.textFieldFocusedBorder,
        disabledBorder: widget.textFieldStyler.textFieldDisabledBorder,
        enabledBorder: widget.textFieldStyler.textFieldEnabledBorder,
        prefixIcon: _showPrefixIcon
            ? ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: _deviceWidth * widget.tagsDistanceFromBorderEnd,
                ),
                child: Container(
                  margin: widget.scrollableTagsMargin,
                  padding: widget.scrollableTagsPadding,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getTags,
                    ),
                  ),
                ),
              )
            : null,
      ),
      onSubmitted: (value) {
        onSubmit(value);
      },
      onChanged: (value) {
        if (_showValidator == false) {
          final containedSeparator = widget.textSeparators!
              .cast<String?>()
              .firstWhere((element) => value.contains(element!) && value.indexOf(element) != 0, orElse: () => null);
          if (containedSeparator != null) {
            final splits = value.split(containedSeparator);
            final int indexer = splits.length > 1 ? splits.length - 2 : splits.length - 1;

            final lastLastTag = widget.letterCase == LetterCase.small
                ? splits.elementAt(indexer).trim()
                : widget.letterCase == LetterCase.capital
                    ? splits.elementAt(indexer).trim()
                    : splits.elementAt(indexer).trim();

            _textEditingController!.clear();

            if (widget.validator == null || widget.validator!(lastLastTag) == null) {
              widget.onTag(lastLastTag);
              if (!_showPrefixIcon) {
                setState(() {
                  _tagsStringContents!.add(lastLastTag);
                  _showPrefixIcon = true;
                });
              } else {
                setState(() {
                  _tagsStringContents!.add(lastLastTag);
                });
              }
              _animateTransition();
            } else {
              setState(() {
                _showValidator = true;
                _validatorMessage = widget.validator!(lastLastTag)!;
              });
            }
          }
        } else {
          setState(() {
            _showValidator = false;
          });
        }
      },
    );
  }
}
