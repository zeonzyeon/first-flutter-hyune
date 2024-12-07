import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MemoListScreen(),
    );
  }
}

class Memo {
  final String title;
  final String content;
  final String category;

  Memo({required this.title, required this.content, required this.category});
}

class MemoListScreen extends StatefulWidget {
  @override
  _MemoListScreenState createState() => _MemoListScreenState();
}

class _MemoListScreenState extends State<MemoListScreen> {
  List<Memo> memos = [];
  String selectedCategory = "전체";

  void _addMemo(Memo memo) {
    setState(() {
      memos.add(memo);
    });
  }

  void _deleteMemo(int index) {
    setState(() {
      memos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = ["전체", "개인", "업무", "기타"];
    List<Memo> filteredMemos = selectedCategory == "전체"
        ? memos
        : memos.where((memo) => memo.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("메모 목록"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
          ),
          Expanded(
            /* 구현 1 */
            /* 메모가 없는 경우, 메모가 없습니다 출력 */
            /* 메모가 있는 경우, 각 메모를 출력 */
            child: filteredMemos.isEmpty
                ? Center(
                    child: Text(
                      "메모가 없습니다.",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredMemos.length,
                    itemBuilder: (context, index) {
                      Memo memo = filteredMemos[index];
                      return Card(
                        child: ListTile(
                          title: Text(memo.title),
                          subtitle: Text(memo.content),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteMemo(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          /* 구현 2 */
          /* floatingActionButton 클릭시 메모 입력 페이지로 전환 */
          /* 메모를 입력받아 메모를 추가 */
          /* 입력된 메모가 없다면 현상 유지 */
          final Memo? newMemo = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MemoAddScreen()),
          );
          if (newMemo != null) {
            _addMemo(newMemo);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MemoAddScreen extends StatefulWidget {
  @override
  _MemoAddScreenState createState() => _MemoAddScreenState();
}

class _MemoAddScreenState extends State<MemoAddScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String selectedCategory = "개인";

  @override
  Widget build(BuildContext context) {
    List<String> categories = ["개인", "업무", "기타"];

    return Scaffold(
      appBar: AppBar(
        title: Text("메모 추가"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /* 구현 3 */
            /* 입력 창 구현 */
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "제목"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: "내용"),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                /* 구현 4 */
                /* 입력 데이터를 반환 */
                String title = _titleController.text.trim();
                String content = _contentController.text.trim();
                if (title.isNotEmpty && content.isNotEmpty) {
                  Navigator.pop(
                    context,
                    Memo(
                      title: title,
                      content: content,
                      category: selectedCategory,
                    ),
                  );
                }
              },
              child: Text("저장"),
            ),
          ],
        ),
      ),
    );
  }
}
