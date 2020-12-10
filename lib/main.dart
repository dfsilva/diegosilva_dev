import 'package:dev_diegosilva/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dev DiegoSilva',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {


  List<String> commands = [];
  TextEditingController _commandController;
  FocusNode _commandFocus;

  @override
  void initState() {
    super.initState();
    _commandController = TextEditingController();
    _commandFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _commandFocus.dispose();
  }

  _inputLine() => Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(width: 5),
          Text("diegosilva>", style: SiteTheme.textTheme),
          SizedBox(width: 10),
          Expanded(
              child: TextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.go,
            controller: _commandController,
            focusNode: _commandFocus,
            cursorColor: Colors.green,
            cursorWidth: 5,
            autofocus: true,
            decoration: InputDecoration(border: InputBorder.none, disabledBorder: InputBorder.none),
            style: GoogleFonts.vt323(color: Colors.green),
            onSubmitted: (str) => _process(str),
          ))
        ],
      );

  void _processClear() {
    _commandController.text = "";
    setState(() {
      commands = [];
    });
    _commandFocus.requestFocus();
  }

  void _processDefault(cmd) {
    _commandController.text = "";
    setState(() {
      commands = commands..add(cmd);
    });
    _commandFocus.requestFocus();
  }

  void _process(cmd) {
    final smd = cmd.toLowerCase();
    if (smd == "clean" || smd == "clear") {
      _processClear();
    } else {
      _processDefault(smd);
    }
  }

  Widget _processCommand(String cmd) {
    final smd = cmd.toLowerCase();

    if(smd == "help" || smd.isEmpty){
      return _printHelp();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [Text("Command not found...", style: SiteTheme.textTheme)],
      ),
    );
  }

  Widget _printCommand(String cmd) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [Text(cmd, style: SiteTheme.textTheme)],
      ),
    );
  }

  Widget _processPresentation() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [Text("####################################", style: SiteTheme.textTheme)],
          ),
          Row(
            children: [Text("### Diego Ferreira da Silva      ###", style: SiteTheme.textTheme)],
          ),
          Row(
            children: [Text("### diegosiuniube@gmail.com      ###", style: SiteTheme.textTheme)],
          ),
          Row(
            children: [Text("### https://github.com/dfsilva   ###", style: SiteTheme.textTheme)],
          ),
          Row(
            children: [Text("####################################", style: SiteTheme.textTheme)],
          ),
        ],
      ),
    );
  }

  Widget _printHelp() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [Text("####################################", style: SiteTheme.textTheme)],
          ),
          Row(
            children: [Text("Clear,Clean -> Clean the console", style: SiteTheme.textTheme)],
          ),
          Row(
            children: [Text("####################################", style: SiteTheme.textTheme)],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _processPresentation(),
          ...(commands.map((e) => [_printCommand(e), _processCommand(e)]).expand((e) => e)),
          _inputLine()
        ],
      ),
    ));
  }
}
