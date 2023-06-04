import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lang_Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePageContent(),
    SchedulePage(),
    PageScore(),
    ProfilePage(),
  ];

  final List<String> _pageTitles = [
    'Home',
    'Schedule',
    'Score',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_currentIndex]),
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.score),
            label: 'Score',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Page'),
    );
  }
}

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Schedule Page'),
    );
  }
}

class PageScore extends StatefulWidget {
  @override
  _PageScoreState createState() => _PageScoreState();
}

class _PageScoreState extends State<PageScore> {
  String _selectedFilter = 'All Classes';

  List<Map<String, dynamic>> _classScores = [
    {
      'title': 'Math',
      'score': 90,
    },
    {
      'title': 'Science',
      'score': 85,
    },
    {
      'title': 'English',
      'score': 95,
    },
  ];

  List<Map<String, dynamic>> getFilteredClassScores() {
    if (_selectedFilter == 'All Classes') {
      return _classScores;
    } else if (_selectedFilter == 'In Process') {
      return _classScores.where((classScore) => classScore['score'] < 60).toList();
    } else if (_selectedFilter == 'Done') {
      return _classScores.where((classScore) => classScore['score'] >= 60).toList();
    }
    return _classScores;
  }

  Color getColorFromScore(int score) {
    if (score >= 90) {
      return Colors.yellow;
    } else if (score >= 80) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredClassScores = getFilteredClassScores();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              value: _selectedFilter,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Filter',
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
              items: [
                DropdownMenuItem(
                  value: 'All Classes',
                  child: Text('All Classes'),
                ),
                DropdownMenuItem(
                  value: 'In Process',
                  child: Text('In Process'),
                ),
                DropdownMenuItem(
                  value: 'Done',
                  child: Text('Done'),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFilter = newValue!;
                });
              },
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: filteredClassScores.length,
              itemBuilder: (context, index) {
                final classScore = filteredClassScores[index];
                final title = classScore['title'];
                final score = classScore['score'];
                final color = getColorFromScore(score);

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    height: 160, // Doubled the height
                    decoration: BoxDecoration(
                      color: Colors.blue, // Added background color
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: Text(
                        'Score: $score',
                        style: TextStyle(color: color),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Page'),
    );
  }
}
