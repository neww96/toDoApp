import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _taskList = [];
  final List<String> _savedList = [];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose(){
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('To-do List'),
          actions: <Widget>[
            IconButton(onPressed: (){
              savedPage();
            } , icon: const FaIcon(FontAwesomeIcons.list))
          ],
        ),
        body: Column(
          children: <Widget>[
            TextField(
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                hintText: 'Input task',
                contentPadding: EdgeInsets.all(15.0),
              ),
              controller: _textEditingController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: (){
                      _addTask(_textEditingController.text);
                    }, child: const Text('Add Task'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                      onPressed: (){
                        savedPage();
                      }, child: const Text('View Done')
                  ),
                ),
              ],
            ),
            Expanded(child: ListView.separated(
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    leading: const FaIcon(FontAwesomeIcons.tasks),
                    title: Text(_taskList[index]),
                    trailing: IconButton(onPressed: (){
                      setState(() {
                        _taskList.removeAt(index);
                      });
                    }, icon: const FaIcon(FontAwesomeIcons.trash)),
                    onTap: (){
                      setState(() {
                        if(_savedList.contains(_taskList[index])){
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Task already added')
                              ));
                        }
                        else{
                          _savedList.add(_taskList.elementAt(index));
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Added to the List')
                          ));
                        }
                      });
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(height: 2, color: Colors.black),
                itemCount: _taskList.length))
          ],
        )
    );
  }
  //notify state to add task to list
  void _addTask(String task){
    setState(() {
      _taskList.add(task);
    });
    _textEditingController.clear();
  }
  void savedPage(){
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context){
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved list'),
            ),
            body: ListView.separated(
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Text(_savedList[index]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(height: 2, color: Colors.black),
                itemCount: _savedList.length),
          );
        }));
  }
}