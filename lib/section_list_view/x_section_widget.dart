// Copyright 2019 Xiaoheng Liu. All rights reserved.
// Use of this source code is governed by a the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:sticky_header_footer/sticky_header_footer.dart';
import './x_section_list_view.dart';

typedef XSectionIndexWidgetBuilder = Widget Function(BuildContext, int section);
typedef XSectionItemWidgetBuilder = Widget Function(BuildContext, XIndexPath);

class XSectionWidget extends StatelessWidget {
  final int _sectionIndex;
  final int _numberOfItems;
  final XSectionIndexWidgetBuilder _header;
  final XSectionItemWidgetBuilder _builder;
  final XSectionIndexWidgetBuilder _footer;
  final XSectionItemWidgetBuilder _seperatorBuilder;

  XSectionWidget({
    Key key,
    int sectionIndex: 0,
    int numberOfItems: 0,
    @required XSectionItemWidgetBuilder builder,
    XSectionIndexWidgetBuilder header,
    XSectionIndexWidgetBuilder footer,
    XSectionItemWidgetBuilder seperatorBuilder,
  })  : assert(builder != null),
        this._sectionIndex = sectionIndex,
        this._numberOfItems = numberOfItems,
        this._header = header,
        this._builder = builder,
        this._footer = footer,
        this._seperatorBuilder = seperatorBuilder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var section = _sectionIndex;
    return XSticky(
      key: ValueKey("$section"),
      header: LayoutBuilder(
        builder: (context, _) {
          return _header != null
              ? (_header(context, section) ?? Container())
              : Container();
        },
      ),
      content: LayoutBuilder(
        builder: (context, _) {
          List<Widget> items = [];
          var numbersOfItems = _numberOfItems;

          for (var i = 0; i < numbersOfItems; ++i) {
            var indexPath = XIndexPath(section: section, item: i);
            var item = _builder(context, indexPath);

            if (item == null) {
              throw FlutterError("Section Item `Must not be null`");
            }

            items.add(item);
            if ((_seperatorBuilder != null)) {
              var seperator = _seperatorBuilder(context, indexPath) ??
                  Divider(height: 1, color: Colors.black);

              items.add(seperator);
            }
          }

          return Column(
            children: items,
          );
        },
      ),
      footer: LayoutBuilder(
        builder: (context, _) {
          return _footer != null
              ? (_footer(context, section) ?? Container())
              : Container();
        },
      ),
    );
  }
}
