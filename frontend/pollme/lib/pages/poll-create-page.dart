import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pollme/model/poll-option.dart';
import 'package:pollme/service/poll-service.dart';

import '../model/poll.dart';

class PollCreatePage extends StatefulWidget {
  final Poll? poll;

  const PollCreatePage({super.key, this.poll});

  @override
  State<StatefulWidget> createState() => _PollCreatePageState();
}

class _PollCreatePageState extends State<PollCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pollNameController = TextEditingController();
  final TextEditingController _questionNameController = TextEditingController();
  List<PollOption> _options = [];
  List<TextEditingController> _controllers = [];
  bool isLoading = false;

  void _createPoll(Poll poll, List<PollOption> pollOptions) async {
    // setState(() {
    //   isLoading = true;
    // });
    try {
      await createPoll(poll, pollOptions);
      print('AWAITING');
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop(true);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.poll != null) {
      _pollNameController.text = widget.poll!.pollName;
      _questionNameController.text = widget.poll!.questionName;
      _fetchPollOptions();
    }
  }

  void _fetchPollOptions() async {
    try {
      List<PollOption> options = await findPollOptions(widget.poll!.id!);
      setState(() {
        // _options = options.map((e) => e.name).toList();
        _options = options;
        _controllers = _options
            .map((option) => TextEditingController(text: option.name))
            .toList();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: null,
              icon: Icon(Icons.poll, color: Colors.black, size: 34)),
          Text('Poll Me',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black))
        ],
      )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? const CircularProgressIndicator()
              : Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _pollNameController,
                        decoration: InputDecoration(labelText: 'Poll Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a poll name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _questionNameController,
                        decoration: InputDecoration(labelText: 'Question Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a question name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Text('Poll Options:'),
                      ..._options.asMap().entries.map((entry) {
                        int index = entry.key;
                        return Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _controllers[index],
                                decoration: InputDecoration(
                                  labelText: 'Option ${index + 1}',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an option';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  entry.value.name = value;
                                  _options[index] = entry.value;
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _options.removeAt(index);
                                  _controllers[index].dispose();
                                  _controllers.removeAt(index);
                                });
                              },
                            ),
                          ],
                        );
                      }).toList(),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100.0, 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.black87),
                        icon: Icon(Icons.add),
                        label: Text('Add Poll Option'),
                        onPressed: () {
                          setState(() {
                            // _options.add('');
                            _options.add(
                                PollOption(pollId: widget.poll?.id, name: ''));
                            _controllers.add(TextEditingController());
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final poll = Poll(
                              id: widget.poll?.id,
                              pollName: _pollNameController.text,
                              questionName: _questionNameController.text,
                            );
                            // Here you can save the poll and its options
                            // to a backend, local database, etc.
                            //TODO Map options to poll option before sending to backend
                            print(
                                'Poll Created: ${poll.pollName} - ${poll.questionName}');
                            // List<PollOption> pollOptions = _options
                            //     .map((e) => PollOption(name: e))
                            //     .toList();
                            _createPoll(poll, _options);
                          }
                        },
                        child: Text('Save'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100.0, 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pollNameController.dispose();
    _questionNameController.dispose();
    super.dispose();
  }
}
