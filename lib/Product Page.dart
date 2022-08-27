import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/VideoScreen.dart';

import 'CommentPage.dart';

//The videos are for public test use only, taken from the following url:
//https://gist.github.com/jsturgis/3b19447b304616f18657

var videoList = [
  {
    'url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'name': 'For Bigger Joyrides',
    'thumb_url':
        'https://d6u22qyv3ngwz.cloudfront.net/ad/7TK8/google-chromecast-bigger-joyrides-small-6.jpg',
    'Comments': List.filled(100, 'Random pick a Facebook comment as a competition or contest winner in the following simple steps:Login with your Facebook account which is the administrator of the Facebook page.Enter the Facebook URL and press the "Get comments" button to load all comments from the post.Start raffle by pressing the "Start" button and pick a random winner for your contest.Create a unique URL to share by using the social media buttons or copy link button (optional).')
  },
  {
    'url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'name': 'For Bigger Joyrides',
    'thumb_url':
        'https://d6u22qyv3ngwz.cloudfront.net/ad/7TK8/google-chromecast-bigger-joyrides-small-6.jpg',
    'Comments': List.filled(100, 'Very Well It was Amazing Please upload more')
  },
  {
    'url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'name': 'For Bigger Joyrides',
    'thumb_url':
        'https://d6u22qyv3ngwz.cloudfront.net/ad/7TK8/google-chromecast-bigger-joyrides-small-6.jpg',
    'Comments': List.filled(100, 'Very Well It was Amazing Please upload more')
  },
  {
    'url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'name': 'For Bigger Joyrides',
    'thumb_url':
        'https://d6u22qyv3ngwz.cloudfront.net/ad/7TK8/google-chromecast-bigger-joyrides-small-6.jpg',
    'Comments': List.filled(100, 'Very Well It was Amazing Please upload more')
  },
  {
    'url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'name': 'For Bigger Joyrides',
    'thumb_url':
        'https://d6u22qyv3ngwz.cloudfront.net/ad/7TK8/google-chromecast-bigger-joyrides-small-6.jpg',
    'Comments': List.filled(100, 'Very Well It was Amazing Please upload more')
  },
  {
    'url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'name': 'For Bigger Joyrides',
    'thumb_url':
        'https://d6u22qyv3ngwz.cloudfront.net/ad/7TK8/google-chromecast-bigger-joyrides-small-6.jpg',
    'Comments': List.filled(100, 'Very Well It was Amazing Please upload more')
  },
  {
    'url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'name': 'For Bigger Joyrides',
    'thumb_url':
        'https://d6u22qyv3ngwz.cloudfront.net/ad/7TK8/google-chromecast-bigger-joyrides-small-6.jpg',
    'Comments': List.filled(100, 'Very Well It was Amazing Please upload more')
  },
  {
    'url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'name': 'For Bigger Joyrides',
    'thumb_url':
        'https://d6u22qyv3ngwz.cloudfront.net/ad/7TK8/google-chromecast-bigger-joyrides-small-6.jpg',
    'Comments': List.filled(100, 'Very Well It was Amazing Please upload more')
  },
  {
    'url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'name': 'For Bigger Joyrides',
    'thumb_url':
        'https://d6u22qyv3ngwz.cloudfront.net/ad/7TK8/google-chromecast-bigger-joyrides-small-6.jpg',
    'Comments': List.filled(100, 'Very Well It was Amazing Please upload more')
  },
  {
    'url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'name': 'For Bigger Joyrides',
    'thumb_url':
        'https://d6u22qyv3ngwz.cloudfront.net/ad/7TK8/google-chromecast-bigger-joyrides-small-6.jpg',
    'Comments': List.filled(100, 'Very Well It was Amazing Please upload more')
  },
  {
    'url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'name': 'For Bigger Joyrides',
    'thumb_url':
        'https://d6u22qyv3ngwz.cloudfront.net/ad/7TK8/google-chromecast-bigger-joyrides-small-6.jpg',
    'Comments': List.filled(100, 'Very Well It was Amazing Please upload more')
  },
];

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductPage();
}

List<bool> readMore = List.filled(videoList.length, false, growable: true);

List<bool> download = List.filled(videoList.length, false, growable: true);
List<bool> liked = List.filled(videoList.length, false, growable: true);
Icon like_icon = const Icon(Icons.favorite_border);
var generalWidget;

class _ProductPage extends State<ProductPage> {
  void favoritePressed(int index) {
    setState(() {
      liked[index] = liked[index] ? false : true;
    });
  }

  Widget loadImage(String url, int index) {
    Image image = Image.network(url);

    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((info, call) {
      if (mounted) {
        setState(() {
          download[index] = true;
        });
      }
    }));

    return download[index]
        ? Column(
            children: [
              image,
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        favoritePressed(index);
                      },
                      icon: liked[index]
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommentPage(
                                    thumb_url: videoList[index]['thumb_url'],videoIndex: index,)));
                      },
                      icon: const Icon(
                        Icons.comment,
                        color: Colors.blue,
                      ))
                ],
              ),

              Container(
                  margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                  child: !readMore[index]
                      ? Row(
                          children: [
                            Text(
                              videoList[index]['Comments']
                                      .toString()
                                      .split(',')[2]
                                      .substring(1, 30) +
                                  ' ...',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                                child: const Text('Read More'),
                                onPressed: () {
                                  read_more(index);
                                })
                          ],
                        )
                      : Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                videoList[index]['Comments']
                                    .toString()
                                    .split(',')[0]
                                    .toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                videoList[index]['Comments']
                                    .toString()
                                    .split(',')[1]
                                    .toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                  videoList[index]['Comments']
                                      .toString()
                                      .split(',')[2]
                                      .toString(),
                                  style: const TextStyle(color: Colors.grey)),
                              Text(
                                  videoList[index]['Comments']
                                      .toString()
                                      .split(',')[3]
                                      .toString(),
                                  style: const TextStyle(color: Colors.grey)),
                              Text(
                                  videoList[index]['Comments']
                                      .toString()
                                      .split(',')[4]
                                      .toString(),
                                  style: const TextStyle(color: Colors.grey)),
                              TextButton(
                                  child: const Text('Read Less'),
                                  onPressed: () {
                                    read_more(index);
                                  }),
                            ],
                          ),
                        )),
              // const SizedBox(height: 8,)
            ],
          )
        : const SizedBox(
            child: Center(child: CircularProgressIndicator()),
            height: 80,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video List'),
      ),
      body: ListView(
          children: videoList
              .asMap()
              .map((index, e) {
                return MapEntry(
                  index,
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoScreen(
                              videoName: e['name'].toString(),
                              videoUrl: e['url'].toString(),
                            ),
                          ),
                        );
                      },
                      child: loadImage(e['thumb_url'].toString(), index)),
                );
              })
              .values
              .toList()),
    );
  }

  void read_more(int index) {
    setState(() {
      readMore[index] = readMore[index] ? false : true;
    });
  }
}
