import 'package:dev_diegosilva/theme.dart';
import 'package:flutter/material.dart';

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
            textInputAction: TextInputAction.done,
            controller: _commandController,
            focusNode: _commandFocus,
            cursorColor: Colors.green,
            cursorWidth: 5,
            autofocus: true,
            decoration: InputDecoration(border: InputBorder.none, disabledBorder: InputBorder.none),
            style: SiteTheme.textTheme,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderWidget(),
          ...(commands.map((e) => [PrintCommand(cmd: e), ProcessCommand(cmd: e)]).expand((e) => e)),
          _inputLine()
        ],
      ),
    ));
  }
}

class ProcessCommand extends StatelessWidget {
  const ProcessCommand({
    Key key,
    @required this.cmd,
  }) : super(key: key);

  final String cmd;

  @override
  Widget build(BuildContext context) {
    final smd = cmd.toLowerCase();
    if (smd == "help" || smd.isEmpty) {
      return Help();
    }
    return CommandNotFound();
  }
}

class PrintCommand extends StatelessWidget {
  final String cmd;

  const PrintCommand({
    Key key,
    this.cmd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [Text(cmd, style: SiteTheme.textTheme)],
      ),
    );
  }
}

class CommandNotFound extends StatelessWidget {
  const CommandNotFound({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [Text("Command not found...", style: SiteTheme.textTheme)],
      ),
    );
  }
}

class Help extends StatelessWidget {
  const Help({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [Text("###############################################", style: SiteTheme.textTheme)],
          ),
          Row(
            children: [Text("### Diego Ferreira da Silva                 ###", style: SiteTheme.textTheme)],
          ),
          Row(
            children: [Text("### diegosiuniube@gmail.com                 ###", style: SiteTheme.textTheme)],
          ),
          Row(
            children: [Text("### https://github.com/dfsilva              ###", style: SiteTheme.textTheme)],
          ),
          Row(
            children: [Text("### https://www.linkedin.com/in/dsilva82/   ###", style: SiteTheme.textTheme)],
          ),
          Row(
            children: [Text("###############################################", style: SiteTheme.textTheme)],
          ),
        ],
      ),
    );
  }
}
