import 'package:flutter/material.dart';

class QuizGame extends StatefulWidget {
  const QuizGame({super.key}); // Named key parameter

  @override
  _QuizGameState createState() => _QuizGameState();
}

class _QuizGameState extends State<QuizGame> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What should you do during an earthquake?',
      'options': ['Stay indoors', 'Run outside', 'Stay calm and find cover', 'Panic'],
      'answer': 'Stay calm and find cover',
    },
    {
      'question': 'What is the safest way to protect yourself from floods?',
      'options': ['Climb to higher ground', 'Hide in your basement', 'Drive away', 'Ignore warnings'],
      'answer': 'Climb to higher ground',
    },
    {
      'question': 'What should you do in case of a tornado?',
      'options': ['Stay outside and watch it', 'Take shelter in a basement or interior room', 'Run to a hilltop', 'Drive away quickly'],
      'answer': 'Take shelter in a basement or interior room',
    },
    {
      'question': 'What is a common sign of an impending tsunami?',
      'options': ['Strong winds', 'Sudden withdrawal of water from the shore', 'Dark clouds', 'Heavy rain'],
      'answer': 'Sudden withdrawal of water from the shore',
    },
    {
      'question': 'Which of these is not a disaster preparedness item?',
      'options': ['First aid kit', 'Flashlight', 'Candy', 'Water'],
      'answer': 'Candy',
    },
    {
      'question': 'What should you do if caught in a wildfire?',
      'options': ['Run towards the fire', 'Stay low to the ground and cover your mouth', 'Ignore it', 'Look for high ground'],
      'answer': 'Stay low to the ground and cover your mouth',
    },
    {
      'question': 'What is the primary cause of landslides?',
      'options': ['Earthquakes', 'Heavy rain', 'Snow', 'None of the above'],
      'answer': 'Heavy rain',
    },
    {
      'question': 'What type of information should be included in an emergency plan?',
      'options': ['Contact numbers', 'Meeting places', 'Escape routes', 'All of the above'],
      'answer': 'All of the above',
    },
    {
      'question': 'How often should you check your emergency supplies?',
      'options': ['Every month', 'Once a year', 'Only when disasters occur', 'Never'],
      'answer': 'Every month',
    },
    {
      'question': 'What is a good way to stay informed during a disaster?',
      'options': ['Social media', 'Local news stations', 'Ignoring warnings', 'All of the above'],
      'answer': 'Local news stations',
    },
    {
      'question': 'During a flood, what is the safest way to evacuate?',
      'options': ['Walking through water', 'Using a boat', 'Driving through flooded roads', 'Staying put'],
      'answer': 'Using a boat',
    },
    {
      'question': 'What should you do if you receive a tsunami warning?',
      'options': ['Ignore it', 'Evacuate to higher ground immediately', 'Stay on the beach', 'Call a friend'],
      'answer': 'Evacuate to higher ground immediately',
    },
    {
      'question': 'What are aftershocks?',
      'options': ['Small earthquakes following a larger one', 'Thunderstorms', 'Flood warnings', 'None of the above'],
      'answer': 'Small earthquakes following a larger one',
    },
    {
      'question': 'What should you not do during a hurricane?',
      'options': ['Stay indoors', 'Evacuate if told to do so', 'Stay near windows', 'Prepare supplies'],
      'answer': 'Stay near windows',
    },
    {
      'question': 'Which of these is a signal of an impending storm?',
      'options': ['Calm weather', 'Increased humidity', 'Sudden drops in temperature', 'Birds flying away'],
      'answer': 'Increased humidity',
    },
    {
      'question': 'What is the safest way to travel during severe weather?',
      'options': ['By foot', 'By bus', 'By car', 'Avoid traveling if possible'],
      'answer': 'Avoid traveling if possible',
    },
    {
      'question': 'Which emergency kit item is essential for signaling for help?',
      'options': ['A whistle', 'A snack', 'A blanket', 'A pillow'],
      'answer': 'A whistle',
    },
    {
      'question': 'What does the term “shelter in place” mean?',
      'options': ['Evacuate immediately', 'Stay where you are and protect yourself', 'Go outside', 'Move to the basement'],
      'answer': 'Stay where you are and protect yourself',
    },
    {
      'question': 'What is a disaster recovery plan?',
      'options': ['Plan for getting supplies', 'Plan for recovering after a disaster', 'Plan for avoiding disasters', 'None of the above'],
      'answer': 'Plan for recovering after a disaster',
    },
    {
      'question': 'How can you help your community prepare for disasters?',
      'options': ['Ignore warnings', 'Volunteer', 'Spread misinformation', 'Stay indoors'],
      'answer': 'Volunteer',
    },
    {
      'question': 'Why is it important to have an emergency contact list?',
      'options': ['To win prizes', 'To stay connected during disasters', 'To keep your phone charged', 'None of the above'],
      'answer': 'To stay connected during disasters',
    },
  ];

  int _questionIndex = 0;
  int _coins = 0;
  bool _isCorrect = false;
  bool _showAnswer = false;
  bool _showHint = false;

  void _checkAnswer(String selectedOption) {
    setState(() {
      _showAnswer = true;
      _isCorrect = _questions[_questionIndex]['answer'] == selectedOption;
      if (_isCorrect) {
        _coins += 10; // Add 10 coins for a correct answer
      }
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _showAnswer = false;
          if (_questionIndex < _questions.length - 1) {
            _questionIndex++;
          } else {
            _showGameOverDialog();
          }
        });
      });
    });
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over!'),
        content: Text('You earned $_coins coins!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _questionIndex = 0;
                _coins = 0;
              });
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  void _useHint() {
    setState(() {
      _showHint = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showHint = false;
      });
    });
  }

  Widget _buildOptionButton(String option) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            _showAnswer && _questions[_questionIndex]['answer'] == option
                ? Colors.green
                : Colors.blue),
      ),
      onPressed: () => _checkAnswer(option),
      child: Text(option),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disaster Safety Quiz'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.yellow),
                Text('$_coins'),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Question ${_questionIndex + 1} of ${_questions.length}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              _questions[_questionIndex]['question'],
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ..._questions[_questionIndex]['options']
                .map<Widget>((option) => _buildOptionButton(option)),
            if (_showAnswer) ...[
              const SizedBox(height: 20),
              AnimatedOpacity(
                opacity: _showAnswer ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: Text(
                  _isCorrect ? 'Correct!' : 'Incorrect!',
                  style: TextStyle(
                    fontSize: 20,
                    color: _isCorrect ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showHint ? null : _useHint,
              child: const Text('Use Hint'),
            ),
            if (_showHint)
              const Text('Hint: Think about what you would do in this situation!'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: QuizGame(),
  ));
}
