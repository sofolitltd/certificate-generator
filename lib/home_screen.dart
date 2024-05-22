// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// import 'pdf_generator/certificate_generator.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   bool _isLoading = false;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final List<String> _names = [];
//   String? _currentFileName;
//
//   final FocusNode _nameFocusNode = FocusNode();
//
//   @override
//   void dispose() {
//     _nameFocusNode.dispose();
//     super.dispose();
//   }
//
//   Future<void> _generateCertificates() async {
//     if (_names.isEmpty) return;
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     for (var i = 0; i < _names.length; i++) {
//       final fileName = _names[i];
//       setState(() {
//         _currentFileName = fileName;
//       });
//
//       final generatedCertificate =
//           await compute(_generateCertificate, fileName);
//     }
//
//     setState(() {
//       _isLoading = false;
//       _currentFileName = null;
//     });
//   }
//
//   static Future<String> _generateCertificate(String fileName) async {
//     // Simulate certificate generation
//     await Future.delayed(const Duration(milliseconds: 500));
//
//     await PdfGenerator.createCertificate(fileName);
//
//     // Return the generated certificate
//     return 'Certificate_$fileName.pdf';
//   }
//
//   void _addName(String name) {
//     setState(() {
//       _names.add(_capitalizeEachWord(name));
//       _nameController.clear();
//       _nameFocusNode.requestFocus(); // Request focus after adding a name
//     });
//   }
//
//   String _capitalizeEachWord(String input) {
//     if (input.isEmpty) return input;
//     return input.trim().split(' ').map((word) {
//       if (word.isEmpty) return word;
//       return word[0].toUpperCase() + word.substring(1).toLowerCase();
//     }).join(' ');
//   }
//
//   void _deleteName(int index) {
//     setState(() {
//       _names.removeAt(index);
//     });
//   }
//
//   void _clearAllNames() {
//     setState(() {
//       _names.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Certificate Generator'),
//       ),
//       body: Center(
//         child: Container(
//           constraints: const BoxConstraints(maxWidth: 720),
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   ElevatedButton(
//                     onPressed: _isLoading ? null : _generateCertificates,
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         _isLoading
//                             ? const CircularProgressIndicator()
//                             : const SizedBox.shrink(),
//                         _isLoading
//                             ? const Text(
//                                 'Generating Certificate...',
//                                 style: TextStyle(
//                                   color: Colors.transparent,
//                                 ),
//                               )
//                             : const Text('Generate Certificate for All'),
//                       ],
//                     ),
//                   ),
//                   if (_isLoading && _currentFileName != null)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Text(
//                         'Generating $_currentFileName...',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//
//               //
//               ElevatedButton(
//                 onPressed: _clearAllNames,
//                 child: const Text('Delete All Name'),
//               ),
//
//               const SizedBox(height: 24),
//
//               //
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       //
//                       Expanded(
//                         child: TextFormField(
//                           autofocus: true,
//                           focusNode: _nameFocusNode,
//                           controller: _nameController,
//                           decoration: InputDecoration(
//                               labelText: 'Enter Name',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               )),
//                           validator: (value) {
//                             if (value!.trim().isEmpty) {
//                               return 'Please enter a name';
//                             }
//                             return null;
//                           },
//                           onFieldSubmitted: (value) {
//                             if (_formKey.currentState!.validate()) {
//                               _addName(value);
//                             }
//                           },
//                         ),
//                       ),
//
//                       const SizedBox(width: 16),
//                       //
//                       GestureDetector(
//                         onTap: () {
//                           if (_formKey.currentState!.validate()) {
//                             _addName(_nameController.text.trim());
//                           }
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.grey),
//                             color: Colors.amber,
//                           ),
//                           padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
//                           child: const Text('Add Name'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               //
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _names.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     final sortedNames = _names.toList()
//                       ..sort(); // Sort the names alphabetically
//                     final name = sortedNames[index];
//                     return Card(
//                       child: ListTile(
//                         title: Text(name),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             _deleteName(index);
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'pdf_generator/certificate_generator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final List<String> _names = [];
  String? _currentFileName;
  final FocusNode _nameFocusNode = FocusNode();

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _generateCertificates() async {
    if (_names.isEmpty || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    for (var i = 0; i < _names.length; i++) {
      final fileName = _names[i];
      setState(() {
        _currentFileName = fileName;
      });

      await _generateCertificateInBackground(fileName);
    }

    setState(() {
      _isLoading = false;
      _currentFileName = null;
    });
  }

  static Future<void> _generateCertificateInBackground(String fileName) async {
    return await compute(_generateCertificate, fileName);
  }

  static Future<void> _generateCertificate(String fileName) async {
    // Simulate certificate generation
    await Future.delayed(const Duration(milliseconds: 500));
    await PdfGenerator.createCertificate(fileName);
  }

  void _addName(String name) {
    setState(() {
      _names.add(_capitalizeEachWord(name));
      _nameController.clear();
      _nameFocusNode.requestFocus(); // Request focus after adding a name
    });
  }

  String _capitalizeEachWord(String input) {
    if (input.isEmpty) return input;
    return input.trim().split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  void _deleteName(int index) {
    setState(() {
      _names.removeAt(index);
    });
  }

  void _clearAllNames() {
    setState(() {
      _names.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Certificate Generator',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 720),
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              //
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                onPressed:
                                    _isLoading ? null : _generateCertificates,
                                child: _isLoading
                                    ? const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          //
                                          SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator(),
                                          ),

                                          SizedBox(width: 8),
                                          //
                                          Text('Generate Certificates...'),
                                        ],
                                      )
                                    : const Text(
                                        'Generate Certificate for All'),
                              ),
                              if (_isLoading && _currentFileName != null)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Generating $_currentFileName...',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          //
                          // if (_names.isNotEmpty)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(72, 40),
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 12, 8)),
                              onPressed: _clearAllNames,
                              icon: const Icon(Icons.refresh),
                              label: Text('Reset (${_names.length})'),
                            ),
                          ),
                        ],
                      ),

                      //

                      const SizedBox(height: 24),

                      //
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
                        child: Form(
                          key: _formKey,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  autofocus: true,
                                  focusNode: _nameFocusNode,
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Enter Full Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                  ),
                                  textCapitalization: TextCapitalization.words,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return 'Please enter a name';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    if (_formKey.currentState!.validate()) {
                                      _addName(value);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _addName(_nameController.text.trim());
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.deepPurple.shade300,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: const Text(
                                    'Add Name',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //
              if (_names.isNotEmpty)
                Expanded(
                  child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      padding: const EdgeInsets.all(16),
                      itemCount: _names.length,
                      itemBuilder: (BuildContext context, int index) {
                        final sortedNames = _names.toList()
                          ..sort(); // Sort the names alphabetically
                        final name = sortedNames[index];
                        return Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          child: ListTile(
                            title: Text(name),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteName(index);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

              //
            ],
          ),
        ),
      ),
    );
  }
}
