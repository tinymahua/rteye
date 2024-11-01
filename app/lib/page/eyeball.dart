import 'dart:io';

import 'package:app/widget/rt_item.dart';
import 'package:flutter/material.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class EyeballPage extends StatefulWidget {
  const EyeballPage({super.key});

  @override
  State<EyeballPage> createState() => _EyeballPageState();
}

class _EyeballPageState extends State<EyeballPage>
    with TrayListener, WindowListener {
  bool isIgnoreMouseEvents = false;

  @override
  void initState() {
    trayManager.addListener(this);
    windowManager.addListener(this);
    windowManager.setAlwaysOnTop(true);
    windowManager.setResizable(false);

    init();
    super.initState();
  }

  @override
  void dispose() {
    trayManager.removeListener(this);
    windowManager.removeListener(this);
    super.dispose();
  }

  Future<void> init() async {
    await trayManager.setIcon(
      Platform.isWindows
          ? 'images/tray_icon_original.ico'
          : 'images/tray_icon_original.png',
    );
    Menu menu = Menu(
      items: [
        MenuItem(
          key: 'show_window',
          label: 'Show Window',
        ),
        MenuItem(
          key: 'set_ignore_mouse_events',
          label: 'setIgnoreMouseEvents(false)',
        ),
        MenuItem.separator(),
        MenuItem(
          key: 'exit_app',
          label: 'Exit App',
        ),
      ],
    );
    await trayManager.setContextMenu(menu);
    // await windowManager.setSize(Size(50, 100));
    await windowManager.setAlignment(Alignment.centerRight, animate: true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (isIgnoreMouseEvents) {
          windowManager.setOpacity(1.0);
        }
      },
      onExit: (_) {
        if (isIgnoreMouseEvents) {
          windowManager.setOpacity(0.5);
        }
      },
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanStart: (details) {
              windowManager.startDragging();
            },
            onPanEnd: (details){
              // windowManager.setA
            },
            child: SizedBox(
              width: 50,
              // height: 100,
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Center(
                  child: Container(
                    child: Column(
                      children: [
                        RtItem(itemIcon: Icon(
                                Icons.arrow_upward,
                                size: 12,
                              ), labelText: "Upload Speed", infoText:  "999K",),
                        RtItem(itemIcon: Icon(
                          Icons.arrow_downward,
                          size: 12,
                        ), labelText: "Download Speed", infoText:  "15K",),
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.blue),
                  ),
                ),
              ),
            ),
          ),
        ],
    );
  }
}
