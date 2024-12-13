import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shawnexchange_interview_app/utils/participant.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  // Initial leaderboard data (kept as a separate variable for reset)
  final List<Participant> _initialParticipants = [
    Participant(
      name: "Jackson",
      score: 1847,
      username: "@username",
      image: "assets/images/user6.png",
    ),
    Participant(
      name: "Elden",
      score: 2430,
      username: "@eldenscore",
      image: "assets/images/user4.png",
    ),
    Participant(
      name: "Emma Aria",
      score: 1300,
      username: "@emmaaria",
      image: "assets/images/user5.png",
    ),
    Participant(
      name: "Sebastian",
      score: 1124,
      username: "@sebastianc",
      image: "assets/images/user1.png",
    ),
    Participant(
      name: "Jason",
      score: 875,
      username: "@jasondurant",
      image: "assets/images/user3.png",
    ),
    Participant(
      name: "Natalie",
      score: 774,
      username: "@natalier",
      image: "assets/images/user1.png",
    ),
    Participant(
      name: "Serenity",
      score: 723,
      username: "@serenity123",
      image: "assets/images/user3.png",
    ),
    Participant(
      name: "Hannah",
      score: 559,
      username: "@hannahsmith",
      image: "assets/images/user2.png",
    ),
    Participant(
      name: "Ken",
      score: 809,
      username: "@kenjae",
      image: "assets/images/user3.png",
    ),
    Participant(
      name: "Simon",
      score: 310,
      username: "@simonkein",
      image: "assets/images/user1.png",
    ),
  ];

  // Mutable list of participants that can be modified
  late List<Participant> participants;

  late Timer _updateTimer;
  final Random _random = Random();
  int _topParticipantIndex = 0;

  @override
  void initState() {
    super.initState();
    // Create a deep copy of initial participants
    participants = _initialParticipants
        .map((p) => Participant(
              name: p.name,
              score: p.score,
              username: p.username,
              image: p.image,
            ))
        .toList();

    // Start periodic updates every 2 seconds
    _updateTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      _updateLeaderboard();
    });
  }

  void _resetLeaderboard() {
    setState(() {
      // Recreate the participants list with initial values
      participants = _initialParticipants
          .map((p) => Participant(
                name: p.name,
                score: p.score,
                username: p.username,
                image: p.image,
              ))
          .toList();

      // Reset top participant index
      _topParticipantIndex = 0;
    });
  }

  void _updateLeaderboard() {
    setState(() {
      // Randomly update scores
      for (var participant in participants) {
        // Random score change between -500 and +500 for notable scoreboard rearrangements
        int scoreChange = _random.nextInt(1001) - 500;
        participant.score += scoreChange;

        // This ensures the score doesn't go below 0
        participant.score = max(0, participant.score);
      }

      // Sort participants by score in descending order
      participants.sort((a, b) => b.score.compareTo(a.score));

      // Update the top participant index
      _topParticipantIndex = 0;
    });
  }

  @override
  void dispose() {
    // Cancel timer when widget is disposed
    _updateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard',
            style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w600)),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _resetLeaderboard,
            tooltip: 'Reset Leaderboard',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.purple,
              Colors.black,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: _buildTopSection(),
            ),
            Expanded(
              flex: 3,
              child: _buildLeaderboard(),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

//TOP SECTION
  Widget _buildTopSection() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          height: 170,
          width: 170,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
              )
            ],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.black,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                participants[_topParticipantIndex].image.toString(),
                height: 60,
                width: 60,
              ),
              const SizedBox(height: 10),
              Text(
                participants[_topParticipantIndex].name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                participants[_topParticipantIndex].username,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                '${participants[_topParticipantIndex].score}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//Leader board widget

  Widget _buildLeaderboard() {
    return ListView.builder(
      itemCount: participants.length,
      itemBuilder: (context, index) {
        final participant = participants[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: _buildUserImage(index),
            title: Text(
              participant.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            trailing: Text(
              '${participant.score}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: _getScoreColor(index),
              ),
            ),
          ),
        );
      },
    );
  }

  // User image with a rank badge overlay
  Widget _buildUserImage(int index) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(participants[index].image.toString()),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (index < 3) _buildRankBadge(index + 1, size: 20),
        if (index >= 3)
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  //Rank badge with different colors
  Widget _buildRankBadge(int rank, {double size = 24}) {
    Color badgeColor;
    switch (rank) {
      case 1:
        badgeColor = Colors.amber;
        break;
      case 2:
        badgeColor = Colors.grey;
        break;
      case 3:
        badgeColor = Colors.black;
        break;
      default:
        badgeColor = Colors.blue;
    }

    return Container(
      padding: EdgeInsets.all(size / 8),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Text(
        '$rank',
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.6,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Dynamic score color based on ranking
  Color _getScoreColor(int index) {
    switch (index) {
      case 0:
        return Colors.amber.shade700;
      case 1:
        return Colors.grey.shade700;
      case 2:
        return Colors.black;
      default:
        return Colors.black54;
    }
  }
}
