import 'package:dealsapp/screeens/featuredScreen.dart';
import 'package:dealsapp/screeens/popularScreen.dart';
import 'package:dealsapp/screeens/topScreen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(backgroundColor: Colors.red.shade400,onPressed: (){} ,child: Icon(Icons.currency_rupee,color: Colors.white,),),
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text("Deals",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          backgroundColor: Colors.lightBlue,
          bottom: TabBar(
            labelColor: Colors.white,
            labelStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 16 , fontStyle: FontStyle.normal),
            tabs: [
              Tab(text: "Top",),
              Tab(text: "Popular"),
              Tab(text: "Featured"),
            ],
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Center(
            child: ListView(
              
              children: [
       
                 ListTile(
                  leading: Icon(
                    Icons.account_circle_rounded,
                    size: 26,
                    color: Theme.of(context).primaryColor,
                  ),
               
                  title: Text('Manage Account', style: TextStyle(fontSize: 17)),
                  trailing: Icon(Icons.chevron_right, color: Colors.black),
                ),
                 ListTile(
                  leading: Icon(
                    Icons.feedback,
                    size: 26,
                    color: Theme.of(context).primaryColor,
                  ),
            
                  title: Text('Feedback', style: TextStyle(fontSize: 17)),
                  trailing: Icon(Icons.chevron_right, color: Colors.black),
                ),
                
           
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [TopScreen(), PopularScreen(), FeaturedScreen()],
        ),
      ),
    );
  }
}
