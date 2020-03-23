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

  bool _id_ok = false;
  bool _pw_ok = false;

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
                  onPressed: _signIn,
                  child: Text('Sign In'),
                ),
                RaisedButton(
                  onPressed: _signUp,
                  child: Text('Sign Up'),
                ),
              ],
            )));
  }

  void _signIn() {
//    if (this._formKey.currentState.validate()) {
//      this._formKey.currentState.save();
//      Scaffold
//          .of(context)
//          .showSnackBar(SnackBar(content: Text('Processing Data')));
//      print(this._id);
//      print(this._password);
//    }

    // TODO::ログイン機能
    if (this._formKey.currentState.validate()) {
      this._formKey.currentState.save();
      String saveId = this._id;
      String savePw = this._password;
      Map data = new Map<String, dynamic>.from({
        "id": saveId,
        "pw": savePw,
      });
      // firestoreから取得
      Future test = getData('acount', saveId);
      test.then((context) => checkAcount(context, saveId, savePw));

      if (_id_ok && _pw_ok) {
        // TODO::login成功していたら別画面に遷移
        print('Login Success!!');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchBook()),
        );
      }
    }
  }

  void _signUp() {
    // TODO::Firestoreにアカウント登録する
    // firestoreに登録
//      Firestore.instance.collection('acount').document(saveId).setData(data);
    // firestoreから削除
//      Firestore.instance.collection('acount').document(saveId).delete();
  }

  Future getData(String collection, String documentId) async {
    DocumentSnapshot docSnapshot = await Firestore.instance
        .collection(collection)
        .document(documentId)
        .get();
    return docSnapshot.data;
  }

  void checkAcount(Map doc, String id, String password) {
    _id_ok = false;
    _pw_ok = false;
    doc.forEach((key, value) => {
          if (key == 'id')
            {
              if (value == id) {_id_ok = true}
            }
          else if (key == 'pw')
            {
              if (value == password) {_pw_ok = true}
            }
        });
  }
}

class SearchBook extends StatefulWidget {
  @override
  _SearchBookState createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}