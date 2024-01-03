import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:untitled1/another_todo_made_by_self/database_todo.dart';
import 'package:untitled1/another_todo_made_by_self/todo_model.dart';
import 'package:uuid/uuid.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});
  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {


  //database access code
  final databse=DataBaseService();


  void deleteTodo(String id){
    databse.deleteTodo(id);
    setState(() { });
  }

  final titlecontroller=TextEditingController();
  final subtitlecontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {


    showBottomSheet(String functiontile,Function()? onpressed){
      showModalBottomSheet(
          context: context,
          builder:(_) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 10,
                right: 10,bottom: MediaQuery.of(context).viewInsets.bottom+120
              ),
              child: Column(
                children: [
                  TextField(
                    controller: titlecontroller,
                    decoration: InputDecoration(hintText: 'Enter title'),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: subtitlecontroller,
                    decoration: InputDecoration(hintText: 'Enter title'),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: onpressed, child: Text(functiontile))
                ],
              ),
            ),
          )
      );
    }
    void editTodo(TodoModel model){
      titlecontroller.text=model.title;
      subtitlecontroller.text=model.subtitle;
      showBottomSheet('Edit Todo',()async{
        var todo=TodoModel(
            id: model.id,
            title:titlecontroller.text ,
            subtitle: subtitlecontroller.text
        );
        databse.edittodo(todo);
        setState(() {
          titlecontroller.clear();
          subtitlecontroller.clear();
        });
        Navigator.of(context).pop();
      });

    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Todo Page'),
        actions: [
          IconButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => todopage(),));
          },
          icon: Icon(Icons.add,size: 25,))
        ],
      ),
      body: FutureBuilder<List<TodoModel>>(
        future: databse.getTodo(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasData){
            if(snapshot.data!.isEmpty){
              return const Center(
                child: Text('No Data Found'),
              );
            }
            return ListView.separated(
                separatorBuilder: (context, index) => Card(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                    child: Card(
                      elevation: 2.0,
                      color: Colors.grey.shade100,
                      child: ListTile(
                        trailing: IconButton(icon: Icon(Icons.delete),
                        onPressed: (){
                          deleteTodo(snapshot.data![index].id);
                        },
                        ),
                        title: Text(snapshot.data![index].title),
                        subtitle: Text(snapshot.data![index].subtitle),
                        onTap: (){
                          editTodo(snapshot.data![index]);
                        },
                      ),
                    ),
                  )
            );
          }
          return Center(
            child: Text('No Data Found'),
          );
        },
      ),
    );
  }
}

//add todo page
class todopage extends StatefulWidget {
   todopage({super.key});

  @override
  State<todopage> createState() => _todopageState();
}

class _todopageState extends State<todopage> {

  final titlecontroller=TextEditingController();
  final subtitlecontroller=TextEditingController();
   //database access code
   final databse=DataBaseService();

  @override
  Widget build(BuildContext context) {
    //add data to database

          void addtodo(){
            var todo=TodoModel(
                id: Uuid().v4(),
                title: titlecontroller.text,
                subtitle: subtitlecontroller.text
            );
            databse.insertTodo(todo);
            setState(() { });
            subtitlecontroller.clear();
            titlecontroller.clear();
            Navigator.of(context).pop();
          }

    //ui of add to do
    return Scaffold(
      appBar: AppBar(
        title: Text('Add To Do'),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 20,),
          onPressed: () {
            Navigator.pop(context);
          },),
      ),
      body: Container(
        padding: EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10
        ),
        child: Column(
          children: [
            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(hintText: 'Enter title'),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: subtitlecontroller,
              decoration: InputDecoration(hintText: 'Enter title'),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              addtodo();
            }, child: Text('Add Todo'))
          ],
        ),
      ),
    );
  }
}



