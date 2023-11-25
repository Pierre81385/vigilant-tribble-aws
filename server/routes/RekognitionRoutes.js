const dotenv = require("dotenv");
const router = require("express").Router();
const AWS = require("aws-sdk");
const rekognition = new AWS.Rekognition({
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_KEY,
});

dotenv.config();

router.route("/face_analysis").post(async (req, res) => {
  var rawData = req.body["image"];
  var imgBuffer = Buffer.from(rawData, "base64");
  var imageData = imgBuffer;

  var params = {
    Image: {
      Bytes: imageData,
    },
    Attributes: ["ALL"],
  };
  rekognition.detectFaces(params, function (err, data) {
    if (err) res.status(400).json({ error: err }); // an error occurred
    else res.status(200).json({ data: data });
  });
});

router.route("/compare").post(async (req, res) => {
  var rawSource = req.body["source"];
  var sourceImgBuffer = Buffer.from(rawSource, "base64");
  var imageDataSource = sourceImgBuffer;
  var rawTarget = req.body["target"];
  var targetImgBuffer = Buffer.from(rawTarget, "base64");
  var imageDataTarget = targetImgBuffer;

  var params = {
    SourceImage: {
      Bytes: imageDataSource,
    },
    TargetImage: {
      Bytes: imageDataTarget,
    },
  };
  rekognition.compareFaces(params, function (err, data) {
    if (err) res.status(400).json({ error: err }); // an error occurred
    else res.status(200).json({ data: data });
  });
});

router.route("/celebrity_analysis").post(async (req, res) => {
  var rawData = req.body["image"];
  var imgBuffer = Buffer.from(rawData, "base64");
  var imageData = imgBuffer;

  var params = {
    Image: {
      Bytes: imageData,
    },
  };
  rekognition.recognizeCelebrities(params, function (err, data) {
    if (err) res.status(400).json({ error: err }); // an error occurred
    else res.status(200).json({ data: data });
  });
});

module.exports = router;
