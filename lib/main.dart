import 'package:flutter/material.dart';
import 'package:untitled/Home.dart';
import 'package:untitled/Platform.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:latlong2/latlong.dart';
import 'google.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:location/location.dart';
import 'package:dio/dio.dart';

void test() async {
  print("Hola mundo");
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //test();
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: TabBarDemo(),
      //const MyHomePage(title: 'SATURMEX'),
    );
  }
}

void myLog() async {
  Location location = new Location();
  location.enableBackgroundMode(enable: true);

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _locationData = await location.getLocation();
  //return _locationData;
  print("____________________");
  print('$_locationData.altitude, $_locationData.longitude');
  print("OK");
}

class HomeScreen extends StatelessWidget {
  String AppTitle = "SATURMEX";
  String TextExample = "Hola Mundo Flutter";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Image.network(
                    'https://cdn-icons-png.flaticon.com/256/475/475438.png'),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.blueAccent,
                  child: TextButton(
                      onPressed: () => {myLog()},
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans',
                            fontSize: 24),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coords = encodePolyline([
      [21.130482, -86.914533],
      [21.173986, -86.826891],
      [21.173844, -86.826647],
      [21.171423, -86.826495],
      [21.170339, -86.826519],
      [21.169615, -86.826472],
      [21.168995, -86.826278],
      [21.164194, -86.825963],
      [21.163669, -86.826192],
      [21.163340, -86.826144],
      [21.163057, -86.825845],
      [21.157506, -86.825500],
      [21.156996, -86.825573],
      [21.156298, -86.825324],
      [21.150700, -86.824892],
      [21.150130, -86.824951],
      [21.145473, -86.824508],
      [21.143319, -86.824403],
    ]);
    print(coords);
    dynamic polyline = decodePolyline(
        r'o`~_CxnnqO}nGwbP\o@bN_@vEDnCIzBe@`]_AfBl@`AIv@{@ta@cAdBLjCq@~a@uApBJb\wAlLU')
        .unpackPolyline();
    //print(polyline);

    Location location;
    LocationData _locationData;
    dynamic response;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async => {
          location = new Location(),
          //location.enableBackgroundMode(enable: true),
          _locationData = await location.getLocation(),
          //return _locationData;
          print("____________________"),
          print('$_locationData.altitude, $_locationData.longitude'),
          print("OK"),
          /*response = await Dio().request(
            'http://172.16.51.23:5000/savepoint',
            data: {
              'Latitud': _locationData.altitude,
              'Longitud': _locationData.longitude,
              'name': '81'
            },
            options: Options(method: 'POST'),
          ),*/
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(21.166304, -86.8677313),
          zoom: 12.2,
          maxZoom: 18.4,
        ),
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: null,
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'io.faustinoloeza',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(21.166304, -86.8677313),
                width: 40,
                height: 40,
                builder: (context) => FlutterLogo(),
              ),
            ],
          ),
          PolylineLayer(
            polylineCulling: false,
            polylines: [
              Polyline(
                strokeWidth: 4.5,
                isDotted: true,
                points: polyline,
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.verified_user)),
                Tab(icon: Icon(Icons.map)),
                Tab(icon: Icon(Icons.phone)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              HomeScreen(),
              FirstScreen(),
              FirstScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    PlatformInfo platformInfo = new PlatformInfo();
    String platform = platformInfo.getCurrentPlatformType();
    print(platform);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Forgot Password',
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  )),
              Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
