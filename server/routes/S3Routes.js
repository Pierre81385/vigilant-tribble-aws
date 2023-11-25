const dotenv = require("dotenv");
const router = require("express").Router();
const AWS = require("aws-sdk");
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

module.exports = router;
