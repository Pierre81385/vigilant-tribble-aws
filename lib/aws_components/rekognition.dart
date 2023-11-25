import 'package:aws_tester/aws_components/rekognition_compare.dart';
import 'package:flutter/material.dart';
import '../helpers/constants.dart';
import '../helpers/image_picker.dart';
import '../models/api_model.dart';
import '../models/face_detect.dart';

class RekognitionComponent extends StatefulWidget {
  const RekognitionComponent({super.key});

  @override
  State<RekognitionComponent> createState() => _RekognitionComponentState();
}

class _RekognitionComponentState extends State<RekognitionComponent> {
  final api =
      ApiService(baseUrl: '${ApiConstants.baseUrl}${ApiConstants.port}');
  Map<String, dynamic> _response = {};
  bool _error = false;
  String _errorMessage = "";
  String _image = "";

  Future<void> getFaceAnalysis(file) async {
    Map<String, dynamic> image = {'image': file};
    try {
      final resp =
          await api.postRekognition("rekognition/face_analysis", image);
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
                  _image = value!;
                },
              ),
              OutlinedButton(
                  onPressed: () {
                    getFaceAnalysis(_image);
                  },
                  child: Text("Facial Analysis")),
              OutlinedButton(
                  onPressed: () {
                    getCelebrityAnalysis(_image);
                  },
                  child: Text("Celebrity Analysis")),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            RekognitionComparisonComponent()));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Facial Comparision'),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  )),
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
