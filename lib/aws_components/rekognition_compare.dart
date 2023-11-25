import 'package:flutter/material.dart';
import '../helpers/constants.dart';
import '../helpers/image_picker.dart';
import '../models/api_model.dart';
import '../models/face_detect.dart';

class RekognitionComparisonComponent extends StatefulWidget {
  const RekognitionComparisonComponent({super.key});

  @override
  State<RekognitionComparisonComponent> createState() =>
      _RekognitionComparisonComponentState();
}

class _RekognitionComparisonComponentState
    extends State<RekognitionComparisonComponent> {
  final api =
      ApiService(baseUrl: '${ApiConstants.baseUrl}${ApiConstants.port}');
  Map<String, dynamic> _response = {};
  bool _error = false;
  String _errorMessage = "";
  String _source = "";
  String _target = "";

  Future<void> getFaceAnalysis(source, target) async {
    Map<String, dynamic> sourceImage = {'image': source};
    Map<String, dynamic> targetImage = {'image': source};
    Map<String, dynamic> compare = {'source': source, 'target': target};

    try {
      final resp = await api.postRekognition("rekognition/compare", compare);
      setState(() {
        _response = resp['data'];
      });
    } on Exception catch (e) {
      setState(() {
        _error = true;
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> getCelebrityAnalysis(file) async {
    Map<String, dynamic> image = {'image': file};
    try {
      final resp =
          await api.postRekognition("rekognition/celebrity_analysis", image);
      setState(() {
        _response = resp['data'];
      });
    } on Exception catch (e) {
      setState(() {
        _error = true;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ImagePickerComponent(
                onSelect: (value) {
                  _source = value!;
                },
              ),
              ImagePickerComponent(
                onSelect: (value) {
                  _target = value!;
                },
              ),
              OutlinedButton(
                  onPressed: () {
                    getFaceAnalysis(_source, _target);
                  },
                  child: Text("Compare")),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Back')),
              Expanded(
                child: ListView(children: [
                  _error == false
                      ? Text(_response.toString())
                      : Text(_errorMessage),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
