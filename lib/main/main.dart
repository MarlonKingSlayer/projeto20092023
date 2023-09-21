import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Login Flutter',
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/user_info': (context) => UserInfoPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? accessType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Página de Login')),
      backgroundColor: Colors.grey[800],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 48,
                  ),
                ),
                SizedBox(height: 10),
                Text('Nome', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                TextField(controller: nameController),
                SizedBox(height: 20),
                Text('Email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                TextField(controller: emailController),
                SizedBox(height: 20),
                Text('Tipo de Acesso', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                DropdownButtonFormField<String>(
                  value: accessType,
                  onChanged: (value) {
                    setState(() {
                      accessType = value;
                    });
                  },
                  items: ['Acesso 1', 'Acesso 2'].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text == 'Marlon' &&
                        emailController.text == 'aulaflutter@2023.com' &&
                        (accessType == 'Acesso 1' || accessType == 'Acesso 2')) {
                      Navigator.pushNamed(context, '/user_info');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Credenciais inválidas. Verifique seus dados.'),
                      ));
                    }
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  bool hideData = false;

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Tem certeza de que deseja ocultar/mostrar os dados?'),
          actions: [
            TextButton(
              child: Text('Sim'),
              onPressed: () {
                _toggleDataVisibility();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleDataVisibility() {
    setState(() {
      hideData = !hideData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Informações do Usuário'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Nome: ${hideData ? '***' : 'Marlon'}', style: TextStyle(fontSize: 20)),
                Text('Email: ${hideData ? '***' : 'aulaflutter@2023.com'}', style: TextStyle(fontSize: 20)),
                Text('Tipo de Acesso: ${hideData ? '***' : 'Acesso 1'}', style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _showConfirmationDialog();
                  },
                  child: Text('Ocultar/Mostrar Dados'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
