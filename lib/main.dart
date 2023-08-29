import 'dart:convert';

import 'package:api_list_of_objects/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main(){
  runApp(DisplayPosts());
}
Future <List<Posts>> fetchPosts() async{
  Uri url=Uri.parse( 'https://jsonplaceholder.typicode.com/posts');
  var response=await http.get(url);

  if(response.statusCode==200) {
    print("success");
    if (response.body.isNotEmpty) {

      print("ok");
      List jsonResponse = jsonDecode(response.body);
      List<Posts> jk=[];
      // return jsonResponse.map((e)=>Posts.fromJson(e)).toList();
      //  for(Map i in jsonResponse){
      //    jk.add(Posts.fromJson(i));
      //    print("List:" + jk[1].title.toString());
      //  }
      for(int i=1;i<jsonResponse.length;i++){
        jk.add(Posts.fromJson(jsonResponse[i]));
      }
      print(jk);
      return jk;
    }
    else {
      throw Exception("error");
    }
  }
  else{
    throw Exception("Network error");
  }
}
class DisplayPosts extends StatefulWidget {
  const DisplayPosts({Key? key}) : super(key: key);

  @override
  State<DisplayPosts> createState() => _DisplayPostsState();
}

class _DisplayPostsState extends State<DisplayPosts> {
  late  Future<List<Posts>> postData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postData=fetchPosts();
    // debugPrint(postData.toString());

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Material(
          child: Center(
            child: FutureBuilder(
              future: postData,
              builder: (context,snapshot){
                if(snapshot.hasData){
                  List<Posts>? posts=snapshot.data;
                  // print(posts);
                  return ListView.builder(
                      itemCount:posts!.length ,
                      itemBuilder:(context,index) {
                        return Container(
                          child: Card(
                            child: Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    title:Text(posts[index].title.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    subtitle: Text(posts[index].body.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    trailing:Text(posts[index].id.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    leading:Text(posts[index].userId.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  );
                }
                else{
                  return Text("There is no data in this APi : ${snapshot.error}");
                }
              },
            ),
          ),),
      ),
    );
  }
}
