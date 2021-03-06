import 'package:flutter/material.dart';
import 'package:draw/draw.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../CommentsView.dart';

class TextPost extends StatefulWidget {
  TextPost(this.post, {this.score});

  final Submission post;
  final int score;

  @override
  _TextPostState createState() => _TextPostState(post, score);
}

class _TextPostState extends State<TextPost> {
  _TextPostState(this.post, this.score);
  Submission post;
  int score;

  @override
  void initState() {
    score = post.score;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(post.title),
              subtitle: Text("${post.author} - ${post.subreddit.displayName}"),
              trailing: Text(score.toString()),
            ),
            Builder(builder: (ctx) {
              if (post.selftext == null || post.selftext == "") {
                return Container(width: 0.0, height: 0.0);
              } else {
                return Container(
                  height: 200.0,
                  padding: EdgeInsets.all(18.0),
                  child: Markdown(data: post.selftext),
                );
              }
            }),
            InkWell(
              onTap: () => Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (c) => CommentsView(post))),
              child: Container(
                height: 45.0,
                child: Row(
                  // Upvote
                  children: <Widget>[
                    Padding(
                      child: InkWell(
                        radius: 20.0,
                        child: Icon(Icons.arrow_upward, size: 18.0),
                        onTap: () async {
                          await post.upvote();
                          setState(() {
                            score = score + 1;
                          });
                        },
                      ),
                      padding: EdgeInsets.all(10.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}