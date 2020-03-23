import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(BookSharingApp());

class BookSharingApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BookSharing',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'BookSharingApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = '';
  String _id = '';
  String _password = '';

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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ChangeForm(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: <Widget>[
          Text(
            "ID",
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 30.0,
                fontWeight: FontWeight.w500),
          ),
          new TextField(
            enabled: true,
            // 入力数
            maxLength: 10,
            maxLengthEnforced: false,
            style: TextStyle(color: Colors.red),
            obscureText: false,
            maxLines: 1,
            decoration: const InputDecoration(
              hintText: 'IDを入力してください',
              labelText: 'ID',
            ),
          ),
          Text(
            "PASSWORD",
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 30.0,
                fontWeight: FontWeight.w500),
          ),
          new TextField(
            enabled: true,
            // 入力数
            maxLength: 10,
            maxLengthEnforced: false,
            style: TextStyle(color: Colors.red),
            obscureText: true,
            maxLines: 1,
            decoration: const InputDecoration(
              hintText: 'パスワードを入力してください',
              labelText: 'パスワード',
            ),
          ),
          RaisedButton(
            onPressed: _login,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }

  void _login() {
    // TODO::ログイン機能を実装
//    Firestore.instance.collection('acount').document();
  }
}

class ChangeForm extends StatefulWidget {
  @override
  _ChangeFormState createState() => _ChangeFormState();
}

class _ChangeFormState extends State<ChangeForm> {
  final _formKey = GlobalKey<FormState>();

  String _id = '';
  String _password = '';

  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: <Widget>[
                new TextFormField(
                  enabled: true,
                  maxLength: 20,
                  maxLengthEnforced: false,
                  obscureText: false,
                  autovalidate: false,
                  decoration: const InputDecoration(
                    hintText: 'IDを入力してください',
                    labelText: 'ID *',
                  ),
                  validator: (String value) {
                    return value.isEmpty ? '必須入力です' : null;
                  },
                  onSaved: (String value) {
                    this._id = value;
                  },
                ),
                new TextFormField(
                  maxLength: 100,
                  autovalidate: true,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'パスワードを入力してください。',
                    labelText: 'パスワード *',
                  ),
                  onSaved: (String value) {
                    this._password = value;
                  },
                ),
                RaisedButton(
                  onPressed: _submission,
                  child: Text('保存'),
                )
              ],
            )));
  }

  void _submission() {
//    if (this._formKey.currentState.validate()) {
//      this._formKey.currentState.save();
//      Scaffold
//          .of(context)
//          .showSnackBar(SnackBar(content: Text('Processing Data')));
//      print(this._id);
//      print(this._password);
//    }
    // TODO::ログイン機能
    getData(this._id);

    if (this._formKey.currentState.validate()) {
      this._formKey.currentState.save();
    }
  }

  Future getData(String documentId) async {
    DocumentSnapshot documentSnapshot =
        await Firestore.instance.collection('acount').document(this._id).get();
    Map record = documentSnapshot.data;
    if (record['id'] == this._id) {
      return true;
    } else {
      return false;
    }
  }
}

//class NextPage extends StatefulWidget {
//  FirebaseUser userData;
//
//  NextPage({Key key, this.userData}) : super(key: key);
//
//  @override
//  _NextPageState createState() => _NextPageState(userData);
//}
//
//class _NextPageState extends State<NextPage> {
//  FirebaseUser userData;
//  String name = "";
//  String email;
//  String photoUrl;
//  final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//  _NextPageState(FirebaseUser userData) {
//    this.userData = userData;
//    this.name = userData.displayName;
//    this.email = userData.email;
//    this.photoUrl = userData.photoUrl;
//  }
//
//  Future<void> _handleSignOut() async {
//    await FirebaseAuth.instance.signOut();
//    try {
//      await _googleSignIn.signOut();
//    } catch (e) {
//      print(e);
//    }
//    Navigator.pop(context);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("ユーザ情報表示"),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Image.network(this.photoUrl),
//            Text(
//              this.name,
//              style: TextStyle(
//                fontSize: 24,
//              ),
//            ),
//            Text(
//              this.email,
//              style: TextStyle(
//                  fontSize: 24
//              ),
//            ),
//            RaisedButton(
//              child: Text('Sign Out Google'),
//              onPressed: () {
//                _handleSignOut().catchError((e) => print(e));
//              },
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
