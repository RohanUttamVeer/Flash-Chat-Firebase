import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextEditingController = TextEditingController();
  String? messageText;

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getUserDetail();
  }

  void getUserDetail() async {
    try {
      final createdUser = _auth.currentUser;
      if (createdUser != null) {
        loggedInUser = createdUser;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreambuilderClass(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextEditingController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextEditingController.clear();
                      _firestore.collection('messages').add({
                        'sender': loggedInUser.email,
                        'text': messageText,
                        'time': FieldValue.serverTimestamp() //add this
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StreambuilderClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('messages')
            .orderBy('time', descending: false) //add this
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          final messages = snapshot.data!.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message['text'];
            final messageSender = message['sender'];
            final messageTime = message['time'] as Timestamp; //add this
            final currentUser = loggedInUser.email;

            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
              time: messageTime, //add this
            );

            messageBubbles.add(messageBubble);
          }

          return Expanded(
            child: ListView(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: messageBubbles),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;
  final bool isMe;
  final Timestamp time; // add this

  MessageBubble(
      {required this.text,
      required this.sender,
      required this.isMe,
      required this.time}); //add the variable  in this constructor
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            ' $sender',
            // ${DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000)}', // add this only if you want to show the time along with the email. If you dont want this then don't add this DateTime thing
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(30.0) : Radius.circular(0),
              topRight: isMe ? Radius.circular(0) : Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flash_chat/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// final _firestore = FirebaseFirestore.instance;
// late User loggedInUser;

// class ChatScreen extends StatefulWidget {
//   static const String id = 'chat_screen';

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final messageTextController = TextEditingController();
//   final _auth = FirebaseAuth.instance;
//   String? messageText;

//   @override
//   void initState() {
//     super.initState();
//     getCurrentUser();
//   }

//   void getCurrentUser() async {
//     try {
//       final user = _auth.currentUser;
//       if (user != null) {
//         loggedInUser = user;
//         print(loggedInUser.email);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: null,
//         actions: <Widget>[
//           IconButton(
//               icon: Icon(Icons.close),
//               onPressed: () {
//                 _auth.signOut();
//                 Navigator.pop(context);
//               }),
//         ],
//         title: Text('Chat ⚡'),
//         backgroundColor: Colors.lightBlueAccent,
//       ),
//       body: SafeArea(
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               MessageStream(),
//               Container(
//                 decoration: kMessageContainerDecoration,
//                 child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: messageTextController,
//                           onChanged: (value) {
//                             messageText = value;
//                           },
//                           decoration: kMessageTextFieldDecoration,
//                         ),
//                       ),
//                       // ignore: deprecated_member_use
//                       FlatButton(
//                         onPressed: () {
//                           messageTextController.clear();

//                           _firestore
//                             ..collection('messages').add({
//                               'sender': loggedInUser.email,
//                               'text': messageText,
//                             });
//                           _firestore
//                               .collection('messages')
//                               .orderBy('sender', descending: true);
//                         },
//                         child: Text(
//                           'Send',
//                           style: kSendButtonTextStyle,
//                         ),
//                       )
//                     ]),
//               )
//             ]),
//       ),
//     );
//   }
// }

// class MessageStream extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore.collection('messages').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return Center(
//             child: CircularProgressIndicator(
//               backgroundColor: Colors.lightBlueAccent,
//             ),
//           );
//         }
//         final messages = snapshot.data!.docs.reversed;

//         List<MessageBubble> messageWidgets = [];
//         for (var message in messages) {
//           final messageText = message['text'] ?? '';
//           final messageSender = message['sender'] ?? 0;

//           final currentUser = loggedInUser.email;

//           final messageWidget = MessageBubble(
//             sender: messageSender,
//             text: messageText,
//             isME: currentUser == messageSender,
//           );
//           messageWidgets.add(messageWidget);
//         }
//         return Expanded(
//           child: ListView(
//             reverse: true,
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//             children: messageWidgets,
//           ),
//         );
//       },
//     );
//   }
// }

// class MessageBubble extends StatelessWidget {
//   MessageBubble({required this.sender, required this.text, required this.isME});
//   final String sender;
//   final String text;
//   final bool isME;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(10),
//       child: Column(
//         crossAxisAlignment:
//             isME ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: [
//           Text(
//             sender,
//             style: TextStyle(
//               fontSize: 12.0,
//               color: Colors.black54,
//             ),
//           ),
//           Material(
//             borderRadius: BorderRadius.only(
//               topLeft: isME ? Radius.circular(30.0) : Radius.circular(0),
//               topRight: isME ? Radius.circular(0) : Radius.circular(30.0),
//               bottomLeft: Radius.circular(30.0),
//               bottomRight: Radius.circular(30.0),
//             ),
//             elevation: 5.0,
//             color: isME ? Colors.lightBlueAccent : Colors.white,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               child: Text(
//                 text,
//                 style: TextStyle(
//                   color: isME ? Colors.white : Colors.black54,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 13.0,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }