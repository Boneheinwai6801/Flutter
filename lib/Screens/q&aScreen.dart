// ignore_for_file: avoid_unnecessary_containers, file_names, prefer_final_fields, avoid_print

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  TextEditingController _textEditingController = TextEditingController();
  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<ChatMessage, DateTime>(
              elements: _messages,
              groupBy: (ChatMessage element) => element.timestamp,
              order: GroupedListOrder.ASC,
              useStickyGroupSeparators: true,
              groupSeparatorBuilder: (DateTime value) => _buildGroupSeparator(value),
              itemBuilder: (context, ChatMessage element) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Align(
                    alignment: element.isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: element.isSentByUser ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        element.text,
                        style: TextStyle(
                          color: element.isSentByUser ? Colors.white : Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildGroupSeparator(DateTime value) {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    DateTime today = DateTime(now.year, now.month, now.day);

    String formattedDate = DateFormat.yMd().format(value); // Change the date format here

    if (value.isAtSameMomentAs(today)) {
      return _buildCenteredSeparator("Today");
    } else if (value.isAtSameMomentAs(yesterday)) {
      return _buildCenteredSeparator("Yesterday");
    } else {
      return _buildCenteredSeparator(formattedDate);
    }
  }

  Widget _buildCenteredSeparator(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      // color: Colors.grey[300],
      child: const Text(
        '',
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.grey[600],
                      onPressed: () {
                        _addMessage(isSentByUser: false);
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                          hintText: 'Type your message...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      color: Colors.blue,
                      onPressed: () {
                        _addMessage(isSentByUser: true);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addMessage({required bool isSentByUser}) {
    String message = _textEditingController.text;
    if (message.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          text: message,
          isSentByUser: isSentByUser,
          timestamp: DateTime.now(),
        ));
        _textEditingController.clear();
      });
    }
  }
}

class ChatMessage {
  final String text;
  final bool isSentByUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isSentByUser,
    required this.timestamp,
  });
}
