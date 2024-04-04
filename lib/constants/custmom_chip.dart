library chip_list;

import 'package:flutter/material.dart';

import '../Views/ward_model.dart';
import 'my_colors.dart';

typedef OnToggle = void Function(int index);


class ChipList extends StatefulWidget {
  const ChipList({
    Key? key,
    required this.listOfChipNames,
    required this.listOfChipIndicesCurrentlySeclected,
    this.activeTextColorList = const [Colors.white],
    this.inactiveTextColorList = const [Colors.white],
    this.activeBgColorList = const [Colors.green],
    this.inactiveBgColorList = const [myWhite],
    this.style,
    this.inactiveBorderColorList = const [Colors.white],
    this.activeBorderColorList = const [Colors.white],
    this.borderRadiiList = const [15],
    this.supportsMultiSelect = false,
    this.extraOnToggle,
    this.shouldWrap = false,
    this.scrollPhysics,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.wrapAlignment = WrapAlignment.start,
    this.wrapCrossAlignment = WrapCrossAlignment.start,
    this.axis = Axis.horizontal,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.spacing = 0.0,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    required this.callback,
    this.currentSelected
  }) : super(key: key);


  final OnToggle? extraOnToggle;
  final List<WardModel> listOfChipNames;
  final bool supportsMultiSelect;
  final List<Color> inactiveBgColorList;
  final List<Color> activeBgColorList;
  final List<Color> activeTextColorList;
  final List<Color> inactiveTextColorList;
  final List<int> listOfChipIndicesCurrentlySeclected;
  final TextStyle? style;
  final bool shouldWrap;
  final ScrollPhysics? scrollPhysics;
  final MainAxisAlignment mainAxisAlignment;
  final WrapAlignment wrapAlignment;
  final WrapCrossAlignment wrapCrossAlignment;
  final Axis axis;
  final WrapAlignment runAlignment;
  final double runSpacing;
  final double spacing;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final List<double> borderRadiiList;
  final List<Color> inactiveBorderColorList;
  final List<Color> activeBorderColorList;
  final double widgetSpacing = 4.0;
  final ValueSetter<WardModel?> callback;
  final WardModel? currentSelected;



  @override
  _ChipListState createState() => _ChipListState();
}

class _ChipListState extends State<ChipList> {
  bool _checkChipSelectionStatus(int _index) {
    if(widget.currentSelected==widget.listOfChipNames[_index]){
      return true;
    }

    return false;
  }



  Color _textColorizer(int _index) {
    // if [supportsMultiSelect] is true
    if(widget.currentSelected==widget.listOfChipNames[_index]){
      return myWhite;
    }else{
      return Colors.black;
    }
  }

  Color _tileColorizer(int _index) {
    if(widget.currentSelected==widget.listOfChipNames[_index]){
      return cl3E4FA3;
    }else{
      return myWhite;
    }

  }

  Color _borderColorizer(int _index) {
// if [supportsMultiSelect] is true
    if(widget.currentSelected==widget.listOfChipNames[_index]){
      return knmGolden2;
    }else{
      return myWhite;
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.inactiveBorderColorList.length != 1 &&
        widget.inactiveBorderColorList.length !=
            widget.listOfChipNames.length) {
      throw Exception(
          'Length of inactiveBorderColorList must match the length of listOfChipNames, if overriden.');
    }

    if (widget.activeBorderColorList.length != 1 &&
        widget.activeBorderColorList.length != widget.listOfChipNames.length) {
      throw Exception(
          'Length of activeBorderColorList must match the length of listOfChipNames, if overriden.');
    }

    if (widget.borderRadiiList.length != 1 &&
        widget.borderRadiiList.length != widget.listOfChipNames.length) {
      throw Exception(
          'Length of borderRadiiList must match the length of listOfChipNames, if overriden.');
    }

    if (widget.activeBgColorList.length != 1 &&
        widget.activeBgColorList.length != widget.listOfChipNames.length) {
      throw Exception(
          'Length of activeBgColorList must match the length of listOfChipNames, if overriden.');
    }

    if (widget.inactiveBgColorList.length != 1 &&
        widget.inactiveBgColorList.length != widget.listOfChipNames.length) {
      throw Exception(
          'Length of inactiveBgColorList must match the length of listOfChipNames, if overriden.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.shouldWrap
        ? Wrap(
      children: List.generate(

        widget.listOfChipNames.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 0),
              child: ChoiceChip(
                // labelPadding:
                // const EdgeInsets.fromLTRB(16.5,5,16.5,5),
                //     :widget.listOfChipNames[index].booth.length==2
                //     ?const EdgeInsets.fromLTRB(12,5,12,5)
                //     :
                // const EdgeInsets.fromLTRB(7.5,5,7.5,5) ,
                // elevation: 5,
                visualDensity:  VisualDensity(horizontal: 0, vertical: -2),
                label:
                // widget.listOfChipNames[index].booth=="GENERAL"||widget.listOfChipNames[index].mandalam.length>=4?
                Container(
                  width: MediaQuery.of(context).size.width*0.30,
                  height: 40,
                  child: Center(
                    child: Text(

                      widget.listOfChipNames[index].wardName,
                      style: widget.style != null
                          ? widget.style!.copyWith(
                        fontSize :MediaQuery.of(context).size.width*0.031,
                        // widget.listOfChipNames[index].booth.length==2?10:widget.listOfChipNames[index].booth.length==1?14:widget.listOfChipNames[index].booth.length==3?10:12,
                        color: _textColorizer(index),
                      )
                          : const TextStyle().copyWith(
                        color: _textColorizer(index),
                      ),
                    ),
                  ),
                ),
                //     :Container( width: 25,
                //     height: 40,
                //
                //   child: Center(
                //     child: Text(
                //
                //       widget.listOfChipNames[index].mandalam,
                //       style: widget.style != null
                //           ? widget.style!.copyWith(
                //         fontSize :9.5,
                //         // widget.listOfChipNames[index].booth.length==2?10:widget.listOfChipNames[index].booth.length==1?14:widget.listOfChipNames[index].booth.length==3?10:12,
                //         color: _textColorizer(index),
                //       )
                //           : const TextStyle().copyWith(
                //         color: _textColorizer(index),
                //       ),
                //     ),
                //   ),
                // ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(
                    color: widget.currentSelected==widget.listOfChipNames[index]?Colors.white:Colors.white,
                    width: 0.8
                  ),
                ),
                backgroundColor: widget.inactiveBgColorList.length == 1
                    ? widget.inactiveBgColorList.first
                    : widget.inactiveBgColorList[index],
                selected: _checkChipSelectionStatus(index),
                selectedColor: _tileColorizer(index),
                onSelected: (val) {
                  if(widget.currentSelected==widget.listOfChipNames[index]){
                    widget.callback(null);

                  }else{
                    widget.callback(widget.listOfChipNames[index]);

                  }

                  // update other chips depending on value of [supportsMultiSelect]

                  if (widget.extraOnToggle != null) {
                    widget.extraOnToggle!(index);

                    // prevents further execution,
                    // thus ensuring setState is not called.
                    return;
                  }

                  // update UI
                  setState(() {});
                },
              ),
            ),
      ),
      alignment: widget.wrapAlignment,
      crossAxisAlignment: widget.wrapCrossAlignment,
      direction: widget.axis,
      runAlignment: widget.runAlignment,
      runSpacing: widget.runSpacing,
      spacing: widget.spacing,
      textDirection: widget.textDirection,
      verticalDirection: widget.verticalDirection,
    )
        : SingleChildScrollView(
      scrollDirection: widget.axis,
      physics: widget.scrollPhysics ?? const ScrollPhysics(),
      child: widget.axis == Axis.horizontal
          ? Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        children: List.generate(
          widget.listOfChipNames.length,
              (index) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.widgetSpacing,
            ),
            child: ChoiceChip(
              label: Text(
                widget.listOfChipNames[index].wardName,
                style: widget.style != null
                    ? widget.style!.copyWith(
                  color: _textColorizer(index),
                )
                    : const TextStyle().copyWith(
                  color: _textColorizer(index),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    widget.borderRadiiList.length == 1
                        ? widget.borderRadiiList.first
                        : widget.borderRadiiList[index]),
                side: BorderSide(
                  color: _borderColorizer(index),
                ),
              ),
              backgroundColor:
              widget.inactiveBgColorList.length == 1
                  ? widget.inactiveBgColorList.first
                  : widget.inactiveBgColorList[index],
              selected: _checkChipSelectionStatus(index),
              selectedColor: _tileColorizer(index),
              onSelected: (val) {
                // update other chips depending on value of [supportsMultiSelect]

                if (widget.extraOnToggle != null) {
                  widget.extraOnToggle!(index);

                  // prevents further execution,
                  // thus ensuring setState is not called.
                  return;
                }

                // update UI
                setState(() {});
              },
            ),
          ),
        ),
      )
          : Column(
        mainAxisAlignment: widget.mainAxisAlignment,
        children: List.generate(
          widget.listOfChipNames.length,
              (index) => Padding(
            padding: EdgeInsets.symmetric(
              vertical: widget.widgetSpacing,
            ),
            child: ChoiceChip(
              label: Text(
                widget.listOfChipNames[index].wardName,
                style: widget.style != null
                    ? widget.style!.copyWith(
                  color: _textColorizer(index),
                )
                    : const TextStyle().copyWith(
                  color: _textColorizer(index),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    widget.borderRadiiList.length == 1
                        ? widget.borderRadiiList.first
                        : widget.borderRadiiList[index]),
                side: BorderSide(
                  color: _borderColorizer(index),
                ),
              ),
              backgroundColor:
              widget.inactiveBgColorList.length == 1
                  ? widget.inactiveBgColorList.first
                  : widget.inactiveBgColorList[index],
              selected: _checkChipSelectionStatus(index),
              selectedColor: _tileColorizer(index),
              onSelected: (val) {
                // update other chips depending on value of [supportsMultiSelect]

                if (widget.extraOnToggle != null) {
                  widget.extraOnToggle!(index);

                  // prevents further execution,
                  // thus ensuring setState is not called.
                  return;
                }

                // update UI
                setState(() {});
              },
            ),
          ),
        ),
      ),
    );
  }
}
