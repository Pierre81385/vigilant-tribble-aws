const dotenv = require("dotenv");
const router = require("express").Router();
const AWS = require("aws-sdk");
const multer = require("multer");
const { v4: uuidv4 } = require("uuid");
const s3 = new AWS.S3({
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_KEY,
});

dotenv.config();

router.route("/buckets").get((req, res) => {
  const BUCKET = process.env.AWS_BUCKET_NAME;

  s3.listBuckets(function (err, data) {
    if (err) res.status(400).json({ error: err }); // an error occurred
    else res.status(200).json({ data: data }); // successful response
  });
});

router.route("/bucket_contents").get((req, res) => {
  const BUCKET = process.env.AWS_BUCKET_NAME;

  var params = {
    Bucket: BUCKET,
    MaxKeys: 2,
  };

  s3.listObjects(params, function (err, data) {
    if (err) res.status(400).json({ error: err }); // an error occurred
    else res.status(200).json({ data: data }); // successful response
  });
});

router.route("/bucket_create").post((req, res) => {
  var params = {
    Bucket: req.body["name"],
  };

  s3.createBucket(params, function (err, data) {
    if (err) res.status(400).json({ error: err }); // an error occurred
    else res.status(200).json({ data: data }); // successful response
  });
});

const storage = multer.memoryStorage({
  destination: function (req, file, callback) {
    callback(null, "");
  },
});

// image is the key!
const upload = multer({ storage }).single("image");

router.route("/image-upload").post(upload, async (req, res) => {
  const BUCKET = process.env.AWS_BUCKET_NAME;
  var rawData = req.body["image"];
  var imgBuffer = await Buffer.from(rawData, "base64");
  var imageData = imgBuffer;

  var params = {
    Bucket: BUCKET,
    Key: `${uuidv4()}.base64`,
    Body: imageData,
  };
  await s3.upload(params, function (err, data) {
    if (err) res.status(400).json({ error: err }); // an error occurred
    else res.status(200).json({ message: data }); //
  });
});

module.exports = router;
