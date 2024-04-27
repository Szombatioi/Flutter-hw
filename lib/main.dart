import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars Characters',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
        primaryColor: Colors.white,
      ),
      home: const Scaffold(
        body: HomePage('Main Page'),
      ),
    );
  }
}

class HomePage extends StatelessWidget{
  final String description;
  const HomePage(this.description);

  // @override
  // Widget build(BuildContext context){
  //   return Center(
  //     child: Image.asset(
  //       'assets/lightsabers.png',
  //       fit: BoxFit.cover,
  //       width: MediaQuery.of(context).size.width * 0.15,
  //     ),
  //   );

  static const Color bgTopColor = Color(0xFF1D6D38);
  static const Color bgBotColor = Color(0xFF282828);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [bgTopColor, bgBotColor],
            stops: [0.0, 0.25],
          ),
        ),
        padding: const EdgeInsets.all(80.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: Image.asset(
                'assets/lightsabers.png',
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width * 0.25,
              ),
            ),
            const SizedBox(height: 20), // Add spacing between image and text
            const Text(
              'Characters',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: ListView.separated(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: const Text(
                        'Example',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {},
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.info_outline),
                            color: Colors.white,
                          ),
                          IconButton(
                            onPressed: (){},
                            icon: const Icon(Icons.arrow_right),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.white,),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
  }