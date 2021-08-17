import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  AppState state;
  bool buttonActivated = false;
  TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  List<String> attachments = [];
  bool isHTML = false;

  final _recipientController = TextEditingController(
    text: 'charles.bogacki@gmail.com',
  );

  final _subjectController = TextEditingController();

  final _bodyController = TextEditingController();

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    state = StateWidget.of(context).state;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    Constants.logoPath,
                    width: 100,
                  ),
                  Text(
                    'xFlop!',
                    style: theme.textTheme.headline4.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Contact',
              style: theme.textTheme.headline4.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //_emailTextfield(theme),
            //_recipientTextfield(theme),
            _subjectTextfield(theme),
            _bodyTextfield(theme),

            // CheckboxListTile(
            //   contentPadding:
            //       EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
            //   title: Text('HTML'),
            //   onChanged: (value) {
            //     if (value != null) {
            //       setState(() {
            //         isHTML = value;
            //       });
            //     }
            //   },
            //   value: isHTML,
            // ),

            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  for (var i = 0; i < attachments.length; i++)
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            attachments[i],
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () => {_removeAttachment(i)},
                        )
                      ],
                    ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.attach_file),
                      onPressed: _openImagePicker,
                    ),
                  ),
                  _sendButton(theme),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _emailTextfield(ThemeData theme) => Padding(
        padding:
            const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
        child: TextField(
          controller: emailController,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.accentColor, width: 2.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0)),
              labelText: 'Adresse e-mail',
              labelStyle: theme.textTheme.bodyText1,
              hintText: 'Entrez un e-mail'),
          style: theme.textTheme.bodyText1,
          onChanged: (value) {
            //   if (userController.text != "") {
            //     setState(() {
            //       userNoEmpty = true;
            //     });
            //   } else {
            //     setState(() {
            //       userNoEmpty = false;
            //     });
            //   }
          },
        ),
      );

  Widget _recipientTextfield(ThemeData theme) => Padding(
        padding:
            const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
        child: TextField(
          controller: _recipientController,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.accentColor, width: 2.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0)),
              labelText: 'Destinataire',
              labelStyle: theme.textTheme.bodyText1,
              hintText: 'Entrez un destinataire'),
          style: theme.textTheme.bodyText1,
          onChanged: (value) {
            //   if (userController.text != "") {
            //     setState(() {
            //       userNoEmpty = true;
            //     });
            //   } else {
            //     setState(() {
            //       userNoEmpty = false;
            //     });
            //   }
          },
        ),
      );

  Widget _subjectTextfield(ThemeData theme) => Padding(
        padding:
            const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
        child: TextField(
          controller: _subjectController,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.accentColor, width: 2.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0)),
              labelText: 'Sujet',
              labelStyle: theme.textTheme.bodyText1,
              hintText: 'Entrez un sujet'),
          style: theme.textTheme.bodyText1,
          // onChanged: (value) {
          //   if (userController.text != "") {
          //     setState(() {
          //       userNoEmpty = true;
          //     });
          //   } else {
          //     setState(() {
          //       userNoEmpty = false;
          //     });
          //   }
          // },
        ),
      );

  Widget _bodyTextfield(ThemeData theme) => Padding(
        padding:
            const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 30),
        child: TextField(
          controller: _bodyController,
          // maxLines: null,
          // expands: true,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.accentColor, width: 2.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0)),
              labelText: 'Message',
              labelStyle: theme.textTheme.bodyText1,
              hintText: 'Entrez un message'),
          style: theme.textTheme.bodyText1,
          // onChanged: (value) {
          //     if (userController.text != "") {
          //       setState(() {
          //         userNoEmpty = true;
          //       });
          //     } else {
          //       setState(() {
          //         userNoEmpty = false;
          //       });
          //     }
          // },
        ),
      );
  Widget _sendButton(ThemeData theme) => Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: theme.accentColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            padding: EdgeInsets.all(10),
          ),
          onPressed: send,
          child: Text(
            'Envoyer',
            style: theme.textTheme.button,
          ),
        ),
      );

  void _openImagePicker() async {
    final picker = ImagePicker();
    PickedFile pick = await picker.getImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        attachments.add(pick.path);
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }
}
