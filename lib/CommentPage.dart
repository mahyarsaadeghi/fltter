import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/Product%20Page.dart';

class CommentPage extends StatefulWidget {
  final thumb_url;
  final videoIndex;

  const CommentPage({this.thumb_url, this.videoIndex});

  @override
  _CommentPage createState() => _CommentPage();
}

Widget imageLoaded = CircularProgressIndicator();
List<String> commentList = [];

class _CommentPage extends State<CommentPage> {
  final commentController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    commentController.dispose();
  }

  void loadImage(String url) {
    Image image = Image.network(url);

    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((info, call) {
      if (mounted) {
        setState(() {
          imageLoaded = image;
        });
      }
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    commentList =
        videoList[widget.videoIndex]['Comments'].toString().split(',');
    commentController.clear();
    loadImage(widget.thumb_url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comment Page")),
      body: Container(
        height: MediaQuery.of(context).size.height,
        // margin: const EdgeInsets.only(bottom: 80),
        child: Column(
          children: [
            imageLoaded,
            Expanded(
              child: ListView.builder(
                  itemCount: commentList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(top: 8),
                      child:  Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('brad_pitt.jpg'),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 4),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'User Name',
                                      ),
                                    ),
                                  ]),
                                  Container(
                                    margin: EdgeInsets.all(4),
                                    child: Text(
                                      commentList[index],
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    );
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 8.0),
                      hintText: 'Enter your comment here:',
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      send_comment(commentController.text);
                    },
                    icon: Icon(Icons.send))
              ],
            ),
          ],
        ),
      ),
    );
  }

  void send_comment(String comment) {
    setState(() {
      print(commentList.length.toString() +
          '****************************************' +
          comment);
      if (comment != "") {
        commentList.insert(0, comment);
      }
      print(commentList.length.toString() +
          '****************************************' +
          commentList[0]);
      commentController.clear();
    });
  }
}
