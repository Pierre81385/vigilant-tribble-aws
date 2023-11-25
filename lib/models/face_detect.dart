class FaceDetails {
  late List<FaceDetail> faceDetails;
  late String orientationCorrection;

  FaceDetails({required this.faceDetails, required this.orientationCorrection});

  FaceDetails.fromJson(Map<String, dynamic> json) {
    if (json['FaceDetails'] != null) {
      faceDetails = <FaceDetail>[];
      json['FaceDetails'].forEach((v) {
        faceDetails.add(FaceDetail.fromJson(v));
      });
    }
    orientationCorrection = json['OrientationCorrection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (faceDetails.isNotEmpty) {
      data['FaceDetails'] = faceDetails.map((v) => v.toJson()).toList();
    }
    data['OrientationCorrection'] = orientationCorrection;
    return data;
  }
}

class FaceDetail {
  AgeRange ageRange;
  Beard beard;
  BoundingBox boundingBox;
  double confidence;
  List<Emotion> emotions;
  EyeDirection eyeDirection;
  Eyeglasses eyeglasses;
  EyesOpen eyesOpen;
  FaceOccluded faceOccluded;
  Gender gender;
  List<Landmark> landmarks;
  MouthOpen mouthOpen;
  Mustache mustache;
  Pose pose;
  Quality quality;
  Smile smile;
  Sunglasses sunglasses;

  FaceDetail({
    required this.ageRange,
    required this.beard,
    required this.boundingBox,
    required this.confidence,
    required this.emotions,
    required this.eyeDirection,
    required this.eyeglasses,
    required this.eyesOpen,
    required this.faceOccluded,
    required this.gender,
    required this.landmarks,
    required this.mouthOpen,
    required this.mustache,
    required this.pose,
    required this.quality,
    required this.smile,
    required this.sunglasses,
  });

  FaceDetail.fromJson(Map<String, dynamic> json)
      : ageRange = AgeRange.fromJson(json['AgeRange']),
        beard = Beard.fromJson(json['Beard']),
        boundingBox = BoundingBox.fromJson(json['BoundingBox']),
        confidence = json['Confidence'].toDouble(),
        emotions =
            (json['Emotions'] as List).map((e) => Emotion.fromJson(e)).toList(),
        eyeDirection = EyeDirection.fromJson(json['EyeDirection']),
        eyeglasses = Eyeglasses.fromJson(json['Eyeglasses']),
        eyesOpen = EyesOpen.fromJson(json['EyesOpen']),
        faceOccluded = FaceOccluded.fromJson(json['FaceOccluded']),
        gender = Gender.fromJson(json['Gender']),
        landmarks = (json['Landmarks'] as List)
            .map((e) => Landmark.fromJson(e))
            .toList(),
        mouthOpen = MouthOpen.fromJson(json['MouthOpen']),
        mustache = Mustache.fromJson(json['Mustache']),
        pose = Pose.fromJson(json['Pose']),
        quality = Quality.fromJson(json['Quality']),
        smile = Smile.fromJson(json['Smile']),
        sunglasses = Sunglasses.fromJson(json['Sunglasses']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AgeRange'] = ageRange.toJson();
    data['Beard'] = beard.toJson();
    data['BoundingBox'] = boundingBox.toJson();
    data['Confidence'] = confidence;
    data['Emotions'] = emotions.map((e) => e.toJson()).toList();
    data['EyeDirection'] = eyeDirection.toJson();
    data['Eyeglasses'] = eyeglasses.toJson();
    data['EyesOpen'] = eyesOpen.toJson();
    data['FaceOccluded'] = faceOccluded.toJson();
    data['Gender'] = gender.toJson();
    data['Landmarks'] = landmarks.map((e) => e.toJson()).toList();
    data['MouthOpen'] = mouthOpen.toJson();
    data['Mustache'] = mustache.toJson();
    data['Pose'] = pose.toJson();
    data['Quality'] = quality.toJson();
    data['Smile'] = smile.toJson();
    data['Sunglasses'] = sunglasses.toJson();
    return data;
  }
}

class AgeRange {
  double high;
  double low;

  AgeRange({required this.high, required this.low});

  AgeRange.fromJson(Map<String, dynamic> json)
      : high = json['High'].toDouble(),
        low = json['Low'].toDouble();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['High'] = high;
    data['Low'] = low;
    return data;
  }
}

class Beard {
  double confidence;
  bool value;

  Beard({required this.confidence, required this.value});

  Beard.fromJson(Map<String, dynamic> json)
      : confidence = json['Confidence'].toDouble(),
        value = json['Value'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Confidence'] = confidence;
    data['Value'] = value;
    return data;
  }
}

class BoundingBox {
  double height;
  double left;
  double top;
  double width;

  BoundingBox({
    required this.height,
    required this.left,
    required this.top,
    required this.width,
  });

  BoundingBox.fromJson(Map<String, dynamic> json)
      : height = json['Height'].toDouble(),
        left = json['Left'].toDouble(),
        top = json['Top'].toDouble(),
        width = json['Width'].toDouble();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Height'] = height;
    data['Left'] = left;
    data['Top'] = top;
    data['Width'] = width;
    return data;
  }
}

class Emotion {
  double confidence;
  String type;

  Emotion({required this.confidence, required this.type});

  Emotion.fromJson(Map<String, dynamic> json)
      : confidence = json['Confidence'].toDouble(),
        type = json['Type'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Confidence'] = confidence;
    data['Type'] = type;
    return data;
  }
}

class EyeDirection {
  double confidence;
  double pitch;
  double yaw;

  EyeDirection(
      {required this.confidence, required this.pitch, required this.yaw});

  EyeDirection.fromJson(Map<String, dynamic> json)
      : confidence = json['Confidence'].toDouble(),
        pitch = json['Pitch'].toDouble(),
        yaw = json['Yaw'].toDouble();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Confidence'] = confidence;
    data['Pitch'] = pitch;
    data['Yaw'] = yaw;
    return data;
  }
}

class Eyeglasses {
  double confidence;
  bool value;

  Eyeglasses({required this.confidence, required this.value});

  Eyeglasses.fromJson(Map<String, dynamic> json)
      : confidence = json['Confidence'].toDouble(),
        value = json['Value'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Confidence'] = confidence;
    data['Value'] = value;
    return data;
  }
}

class EyesOpen {
  double confidence;
  bool value;

  EyesOpen({required this.confidence, required this.value});

  EyesOpen.fromJson(Map<String, dynamic> json)
      : confidence = json['Confidence'].toDouble(),
        value = json['Value'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Confidence'] = confidence;
    data['Value'] = value;
    return data;
  }
}

class FaceOccluded {
  double confidence;
  bool value;

  FaceOccluded({required this.confidence, required this.value});

  FaceOccluded.fromJson(Map<String, dynamic> json)
      : confidence = json['Confidence'].toDouble(),
        value = json['Value'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Confidence'] = confidence;
    data['Value'] = value;
    return data;
  }
}

class Gender {
  double confidence;
  String value;

  Gender({required this.confidence, required this.value});

  Gender.fromJson(Map<String, dynamic> json)
      : confidence = json['Confidence'].toDouble(),
        value = json['Value'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Confidence'] = confidence;
    data['Value'] = value;
    return data;
  }
}

class Landmark {
  String type;
  double x;
  double y;

  Landmark({required this.type, required this.x, required this.y});

  Landmark.fromJson(Map<String, dynamic> json)
      : type = json['Type'],
        x = json['X'].toDouble(),
        y = json['Y'].toDouble();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Type'] = type;
    data['X'] = x;
    data['Y'] = y;
    return data;
  }
}

class MouthOpen {
  double confidence;
  bool value;

  MouthOpen({required this.confidence, required this.value});

  MouthOpen.fromJson(Map<String, dynamic> json)
      : confidence = json['Confidence'].toDouble(),
        value = json['Value'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Confidence'] = confidence;
    data['Value'] = value;
    return data;
  }
}

class Mustache {
  double confidence;
  bool value;

  Mustache({required this.confidence, required this.value});

  Mustache.fromJson(Map<String, dynamic> json)
      : confidence = json['Confidence'].toDouble(),
        value = json['Value'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Confidence'] = confidence;
    data['Value'] = value;
    return data;
  }
}

class Pose {
  double pitch;
  double roll;
  double yaw;

  Pose({required this.pitch, required this.roll, required this.yaw});

  Pose.fromJson(Map<String, dynamic> json)
      : pitch = json['Pitch'].toDouble(),
        roll = json['Roll'].toDouble(),
        yaw = json['Yaw'].toDouble();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Pitch'] = pitch;
    data['Roll'] = roll;
    data['Yaw'] = yaw;
    return data;
  }
}

class Quality {
  double brightness;
  double sharpness;

  Quality({required this.brightness, required this.sharpness});

  Quality.fromJson(Map<String, dynamic> json)
      : brightness = json['Brightness'].toDouble(),
        sharpness = json['Sharpness'].toDouble();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Brightness'] = brightness;
    data['Sharpness'] = sharpness;
    return data;
  }
}

class Smile {
  double confidence;
  bool value;

  Smile({required this.confidence, required this.value});

  Smile.fromJson(Map<String, dynamic> json)
      : confidence = json['Confidence'].toDouble(),
        value = json['Value'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Confidence'] = confidence;
    data['Value'] = value;
    return data;
  }
}

class Sunglasses {
  double confidence;
  bool value;

  Sunglasses({required this.confidence, required this.value});

  Sunglasses.fromJson(Map<String, dynamic> json)
      : confidence = json['Confidence'].toDouble(),
        value = json['Value'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Confidence'] = confidence;
    data['Value'] = value;
    return data;
  }
}
