import 'package:flutter/material.dart';

class CommonWrapper extends StatelessWidget {
  const CommonWrapper({
    Key? key,
    required this.child,
    this.header,
    this.leftSideNavigationMenu,
    this.rightSideNavigationMenu,
    this.copyright,
    this.minScreenWidth = 1280,
    this.maxScreenWidth = 3440,
    this.minScreenHeight = 720,
    this.expandWidth = false,
    this.expandHeight = true,
    this.contentAlignment = Alignment.topCenter,
  }) : super(key: key);

  final Widget child;
  final SizedBox? header;
  final Widget? leftSideNavigationMenu;
  final Widget? rightSideNavigationMenu;
  final SizedBox? copyright;
  final double minScreenWidth;
  final double maxScreenWidth;
  final double minScreenHeight;
  final bool expandWidth;
  final bool expandHeight;
  final Alignment contentAlignment;

  @override
  Widget build(BuildContext context) {
    final double headerHeight = header?.height ?? 0;
    final double copyrightHeight = copyright?.height ?? 0;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double contentHeight = screenHeight - copyrightHeight;

    final ScrollController verticalScrollController =
        ScrollController(initialScrollOffset: 0);
    final ScrollController horizontalScrollController =
        ScrollController(initialScrollOffset: 0);

    return Scrollbar(
      controller: verticalScrollController,
      interactive: true,
      thumbVisibility: true,
      trackVisibility: true,
      thickness: 8,
      child: SingleChildScrollView(
        controller: verticalScrollController,
        child: Scrollbar(
          controller: horizontalScrollController,
          interactive: true,
          thumbVisibility: true,
          trackVisibility: true,
          thickness: 8,
          child: SingleChildScrollView(
            controller: horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: Stack(
              alignment: contentAlignment,
              children: [
                SizedBox(width: screenWidth),
                if (header != null)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: header!,
                  ),
                Container(
                  constraints: BoxConstraints(
                    minWidth: minScreenWidth,
                    maxWidth: expandWidth
                        ? (screenWidth > minScreenWidth
                            ? screenWidth
                            : minScreenWidth)
                        : screenWidth > maxScreenWidth
                            ? maxScreenWidth
                            : (screenWidth > minScreenWidth
                                ? screenWidth
                                : minScreenWidth),
                    minHeight: contentHeight,
                    maxHeight: expandHeight
                        ? double.infinity
                        : (contentHeight > minScreenHeight
                            ? contentHeight
                            : minScreenHeight),
                  ),
                  padding: EdgeInsets.only(top: headerHeight),
                  margin: EdgeInsets.only(bottom: copyrightHeight),
                  child: () {
                    if (leftSideNavigationMenu == null &&
                        rightSideNavigationMenu == null) {
                      return child;
                    } else {
                      return IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (leftSideNavigationMenu != null)
                              leftSideNavigationMenu!,
                            Expanded(child: child),
                            if (rightSideNavigationMenu != null)
                              rightSideNavigationMenu!,
                          ],
                        ),
                      );
                    }
                  }(),
                ),
                if (copyright != null)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: copyright!,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
