import 'package:flutter/material.dart';

void main() {
  runApp(const CheckPiApp());
}

class CheckPiApp extends StatelessWidget {
  const CheckPiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Check Pi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CheckPiPage(),
    );
  }
}

class CheckPiPage extends StatefulWidget {
  const CheckPiPage({Key? key}) : super(key: key);

  @override
  _CheckPiPageState createState() => _CheckPiPageState();
}

class _CheckPiPageState extends State<CheckPiPage> {
  final String pi = "14159265358979323846264338327950288419716939937510582097494459230781640628620899862803482534211706798214808651328230664709384460955058223172535940812848111745028410270193852110555964462294895493038196442881097566593344612847564823378678316527120190914564856692346034861045432664821339360726024914127372458700660631558817488152092096282925409171536436789259036001133053054882046652138414695194151160943305727036575959195309218611738193261179310511854807446237996274956735188575272489122793818301194912983367336244065664308602139494639522473719070217986094370277053921717629317675238467481846766940513200056812714526356082778577134275778960917363717872146844090122495343014654958537105079227968925892354201995611212902196086403441815981362977477130996051870721134999999837297804995105973173281609631859502445945534690830264252230825334468503526193118817101000313783875288658753320838142061717766914730359825349042875546873115956286388235378759375195778185778053217122680661300192787661119590921642019893";
  int currentIndex = 0;
  final List<TextEditingController> _controllers = List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  String message = "";

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1 && i < _controllers.length - 1) {
          FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
        }
      });
    }
  }

  void _checkInput() {
    String input = _controllers.map((controller) => controller.text).join();
    if (input == pi.substring(currentIndex, currentIndex + 5)) {
      setState(() {
        message = "Correct!";
        currentIndex += 5;
        for (var controller in _controllers) {
          controller.clear();
        }
        FocusScope.of(context).requestFocus(_focusNodes[0]);
      });
    } else {
      setState(() {
        message = "Try again!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Pi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter the next 5 digits of Pi:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkInput,
              child: const Text('Check'),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: TextStyle(fontSize: 24, color: message == "Correct!" ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
