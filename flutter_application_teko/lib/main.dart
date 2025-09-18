import 'package:flutter/material.dart';
import 'package:flutter_application_teko/Student.dart';
import 'package:flutter_application_teko/Worker.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String name = 'Teko';
  int age = 21;
  bool programming = true;
  final TextEditingController idController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidosController = TextEditingController();
  final TextEditingController edadController = TextEditingController();

  List<Worker> trabajadores = [];
  String? errorMsg;

  List<String> lista = ["Vale", "Teko", "Pepino", "Wero"];
  Student student = Student(name: "Teko", enrollment: "I20223TN042");

  TextEditingController _txtNameCtrl = TextEditingController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void agregarTrabajador() {
    setState(() {
      errorMsg = null;
      String id = idController.text.trim();
      String nombre = nombreController.text.trim();
      String apellidos = apellidosController.text.trim();
      String edadStr = edadController.text.trim();

      if (id.isEmpty ||
          nombre.isEmpty ||
          apellidos.isEmpty ||
          edadStr.isEmpty) {
        errorMsg = "No se permiten campos vacíos.";
        return;
      }
      if (trabajadores.any((w) => w.id == id)) {
        errorMsg = "No se permiten IDs repetidos.";
        return;
      }
      int? edad = int.tryParse(edadStr);
      if (edad == null || edad < 18) {
        errorMsg = "Solo se pueden registrar mayores de edad.";
        return;
      }
      trabajadores.add(
        Worker(id: id, nombre: nombre, apellidos: apellidos, edad: edad),
      );
      idController.clear();
      nombreController.clear();
      apellidosController.clear();
      edadController.clear();
    });
  }

  void eliminarUltimoTrabajador() {
    setState(() {
      if (trabajadores.isNotEmpty) {
        trabajadores.removeLast();
      }
    });
  }

  void _addStudent() {
    final name = _txtNameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please set all data")));
      return;
    }
    setState(() {
      lista.add(name);
    });
    _txtNameCtrl.clear();
  }

  Widget getStudents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        const Text("Student List: "),
        const SizedBox(height: 10),
        ...lista.map((n) => Text("-$n ")).toList(),
      ],
    );
  }

  Widget getTrabajadores() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        const Text("Trabajadores:"),
        const SizedBox(height: 10),
        ...trabajadores.map(
          (w) => Text("- ${w.id}: ${w.nombre} ${w.apellidos}, Edad: ${w.edad}"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Agregar Trabajador',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: apellidosController,
                decoration: const InputDecoration(labelText: 'Apellidos'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: edadController,
                decoration: const InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: agregarTrabajador,
                    child: const Text('Agregar'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: eliminarUltimoTrabajador,
                    child: const Text('Eliminar último'),
                  ),
                ],
              ),
              if (errorMsg != null) ...[
                const SizedBox(height: 10),
                Text(errorMsg!, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 20),
              getTrabajadores(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
