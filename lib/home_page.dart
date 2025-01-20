import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> list = ['Task 1', 'Task 2'];

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      list = pref.getStringList('list') ?? [];
    });
  }

  void _saveList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList('list', list);
  }

  void addTask(String task) {
    setState(() {
      list.add(task);
    });
    _saveList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Bucket",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00695C), Color(0xFF4DB6AC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        toolbarHeight: 80,
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFF1F8E9),
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 2),
                child: SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: Color(0xFFEDEDED),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                list[index],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(fontSize: 19
                              ,color: Color(0xFF424242)),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    list.removeAt(index);
                                  });
                                  _saveList();
                                },
                                icon: Icon(Icons.delete, color: Color(0xFF424242))),
                          ],
                        ),
                      ),
                    )),
              );
            }),
      ),
      floatingActionButton: SizedBox(
        height: 75,
        width: 75,
        child: Padding(
            padding: EdgeInsets.all(5),
            child: FloatingActionButton(
              onPressed: () {
                addData(context);
              },
              backgroundColor: Color(0xFF80CBC4),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 33,
              ),
            )),
      ),
    );
  }

  void addData(BuildContext context) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            controller: controller,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(hintText: 'Type here'),
            maxLength: 35,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String enteredData = controller.text;
                addTask(enteredData);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
