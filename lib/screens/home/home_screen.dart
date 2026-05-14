import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/explorer_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedMenu = 0;

  final ExplorerController explorerController = Get.put(ExplorerController());

  final List<String> terminalLogs = [
    "Flutter SDK initialized",
    "GitHub connected",
    "Ready to build APK",
    "AI Assistant online",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1e1e1e),
        title: const Text(
          "ARVIND STUDIO",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Running app...")),
              );
            },
            icon: const Icon(Icons.play_arrow, color: Colors.greenAccent),
            tooltip: "Run",
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Building APK...")),
              );
            },
            icon: const Icon(Icons.android, color: Colors.lightGreenAccent),
            tooltip: "Build APK",
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Uploading to GitHub...")),
              );
            },
            icon: const Icon(Icons.cloud_upload, color: Colors.lightBlueAccent),
            tooltip: "Push to GitHub",
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // ── SIDEBAR ──────────────────────────────────────────
                Container(
                  width: 70,
                  color: const Color(0xff252526),
                  child: Column(
                    children: [
                      sidebarIcon(Icons.folder, 0, "Explorer"),
                      sidebarIcon(Icons.search, 1, "Search"),
                      sidebarIcon(Icons.code, 2, "Editor"),
                      sidebarIcon(Icons.smart_toy, 3, "AI Assistant"),
                      sidebarIcon(Icons.settings, 4, "Settings"),
                    ],
                  ),
                ),

                // ── EXPLORER / SIDE PANEL ────────────────────────────
                Container(
                  width: 220,
                  color: const Color(0xff2d2d30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Panel header
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Text(
                          _panelTitle(),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),

                      // Explorer file list
                      if (selectedMenu == 0)
                        Expanded(
                          child: Obx(() {
                            return ListView.builder(
                              itemCount: explorerController.files.length,
                              itemBuilder: (context, index) {
                                final file = explorerController.files[index];
                                return ListTile(
                                  dense: true,
                                  leading: Icon(
                                    file.isFolder
                                        ? Icons.folder
                                        : Icons.insert_drive_file,
                                    color: file.isFolder
                                        ? Colors.amber
                                        : Colors.lightBlueAccent,
                                    size: 20,
                                  ),
                                  title: Text(
                                    file.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  onTap: () {
                                    if (file.isFolder) {
                                      explorerController.loadFiles(file.path);
                                    } else {
                                      explorerController.openFile(
                                          file.path, file.name);
                                    }
                                  },
                                );
                              },
                            );
                          }),
                        ),

                      // AI Assistant panel
                      if (selectedMenu == 3)
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "AI ASSISTANT",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Ask me anything about your code...",
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Settings panel
                      if (selectedMenu == 4)
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "SETTINGS",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Theme, Font, Git Config...",
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Placeholder for other panels
                      if (selectedMenu != 0 &&
                          selectedMenu != 3 &&
                          selectedMenu != 4)
                        const Expanded(
                          child: Center(
                            child: Text(
                              "Coming soon...",
                              style: TextStyle(color: Colors.white38),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // ── EDITOR AREA ──────────────────────────────────────
                Expanded(
                  child: Container(
                    color: const Color(0xff1e1e1e),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tab bar
                        Container(
                          height: 45,
                          color: const Color(0xff2d2d30),
                          child: Row(
                            children: [
                              Obx(() {
                                final name =
                                    explorerController.openedFileName.value;
                                if (name.isEmpty) {
                                  return editorTab("Welcome");
                                }
                                return editorTab(name);
                              }),
                            ],
                          ),
                        ),

                        // Code area
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: SingleChildScrollView(
                              child: Obx(() {
                                final content =
                                    explorerController.openedFile.value;
                                return Text(
                                  content.isEmpty
                                      ? '''// Welcome to Arvind Studio
// Tap a file in the Explorer to open it.

void main() {
  runApp(ArvindStudio());
}'''
                                      : content,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'monospace',
                                    height: 1.6,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),

                        // Status bar
                        Container(
                          height: 28,
                          color: Colors.blue,
                          alignment: Alignment.centerLeft,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          child: Obx(() {
                            final file =
                                explorerController.openedFileName.value;
                            return Text(
                              file.isEmpty
                                  ? "Flutter • Dart • GitHub Connected"
                                  : "Flutter • Dart • $file",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── TERMINAL ────────────────────────────────────────────────
          Container(
            height: 180,
            color: Colors.black,
            child: Column(
              children: [
                Container(
                  height: 35,
                  color: const Color(0xff252526),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: const Text(
                    "TERMINAL",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: terminalLogs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: Text(
                          "> ${terminalLogs[index]}",
                          style: const TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 13,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── HELPERS ────────────────────────────────────────────────────────

  String _panelTitle() {
    switch (selectedMenu) {
      case 0:
        return "EXPLORER";
      case 1:
        return "SEARCH";
      case 2:
        return "SOURCE CONTROL";
      case 3:
        return "AI ASSISTANT";
      case 4:
        return "SETTINGS";
      default:
        return "EXPLORER";
    }
  }

  Widget sidebarIcon(IconData icon, int index, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () {
          setState(() {
            selectedMenu = index;
          });
        },
        child: Container(
          height: 65,
          width: double.infinity,
          color: selectedMenu == index ? Colors.white10 : Colors.transparent,
          child: Icon(
            icon,
            color: selectedMenu == index ? Colors.white : Colors.white54,
          ),
        ),
      ),
    );
  }

  Widget editorTab(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
      ),
    );
  }
}
