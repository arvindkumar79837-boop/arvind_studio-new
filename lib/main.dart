import 'package:flutter/material.dart';

void main() {
  runApp(const ArvindStudio());
}

class ArvindStudio extends StatelessWidget {
  const ArvindStudio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ARVIND STUDIO',
      theme: ThemeData.dark(),
      home: const IDEHomePage(),
    );
  }
}

class IDEHomePage extends StatefulWidget {
  const IDEHomePage({super.key});

  @override
  State<IDEHomePage> createState() => _IDEHomePageState();
}

class _IDEHomePageState extends State<IDEHomePage> {

  int selectedIndex = 0;

  final List<String> files = [
    "main.dart",
    "home.dart",
    "settings.dart",
    "pubspec.yaml",
    "README.md",
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xff1e1e1e),

      appBar: AppBar(
        backgroundColor: const Color(0xff252526),
        title: const Text(
          "ARVIND STUDIO",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Row(

        children: [

          // SIDEBAR
          Container(
            width: 70,
            color: const Color(0xff252526),

            child: Column(

              children: [

                sideIcon(Icons.folder, 0),
                sideIcon(Icons.search, 1),
                sideIcon(Icons.code, 2),
                sideIcon(Icons.smart_toy, 3),
                sideIcon(Icons.settings, 4),

              ],
            ),
          ),

          // FILE EXPLORER
          Container(
            width: 220,
            color: const Color(0xff2d2d30),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "EXPLORER",
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(

                    itemCount: files.length,

                    itemBuilder: (context, index) {

                      return ListTile(

                        leading: const Icon(
                          Icons.insert_drive_file,
                          color: Colors.lightBlueAccent,
                          size: 20,
                        ),

                        title: Text(
                          files[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),

                        onTap: () {},

                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // EDITOR AREA
          Expanded(

            child: Container(

              color: const Color(0xff1e1e1e),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Container(
                    height: 45,
                    color: const Color(0xff2d2d30),

                    child: Row(

                      children: [

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),

                          alignment: Alignment.center,

                          child: const Text(
                            "main.dart",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  const Expanded(

                    child: Padding(
                      padding: EdgeInsets.all(16),

                      child: SingleChildScrollView(

                        child: Text(

                          '''
void main() {

  runApp(
    MyApp(),
  );

}
                          ''',

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    height: 28,
                    color: Colors.blue,

                    alignment: Alignment.centerLeft,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),

                    child: const Text(
                      "Flutter • Dart • Mobile IDE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sideIcon(IconData icon, int index) {

    return InkWell(

      onTap: () {

        setState(() {
          selectedIndex = index;
        });

      },

      child: Container(

        height: 65,

        color: selectedIndex == index
            ? Colors.white10
            : Colors.transparent,

        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
