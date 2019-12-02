// Copyright 2019 Xiaoheng Liu. All rights reserved.
// Use of this source code is governed by a the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import './x_section_widget.dart';

typedef XSectionItemsCount = int Function(int section);

class XSectionListView extends StatelessWidget {
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final ScrollController scrollController;

  final int numbersOfSection;
  final XSectionItemsCount numberOfRowsInSection;
  final XSectionIndexWidgetBuilder sectionHeaderBuilder;
  final XSectionItemWidgetBuilder itemBuilder;
  final XSectionIndexWidgetBuilder sectionFooterBuilder;

  final XSectionItemWidgetBuilder seperatorBuilder;

  XSectionListView({
    Key key,
    this.numbersOfSection: 1,
    @required this.numberOfRowsInSection,
    @required this.itemBuilder,
    this.sectionHeaderBuilder,
    this.sectionFooterBuilder,
    this.shrinkWrap: false,
    this.physics: const AlwaysScrollableScrollPhysics(),
    this.scrollController,
    this.seperatorBuilder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }

  Widget _buildListView() {
    var sections = numbersOfSection;

    var listView = ListView.builder(
      controller: scrollController,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: sections,
      itemBuilder: (context, section) {
        return XSectionWidget(
          sectionIndex: section,
          numberOfItems: numberOfRowsInSection(section),
          header: sectionHeaderBuilder,
          builder: itemBuilder,
          footer: sectionFooterBuilder,
          seperatorBuilder: seperatorBuilder,
        );
      },
    );

    return listView;
  }
}

// IndexPath
class XIndexPath {
  final int section;
  final int item;
  XIndexPath({
    this.section = 0,
    this.item = 0,
  });

  @override
  String toString() {
    return '[$section: $item]';
  }

  @override
  int get hashCode => super.hashCode;

  @override
  bool operator ==(other) {
    if (other.runtimeType != XIndexPath) {
      return false;
    }
    XIndexPath otherIndexPath = other;
    return section == otherIndexPath.section && item == otherIndexPath.item;
  }
}
