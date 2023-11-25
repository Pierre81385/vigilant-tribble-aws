const router = require("express").Router();
const User = require("../models/UsersModel");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const authenticateToken = require("../utils/jwtVerify");

//create new user
router.route("/create").post(async (req, res) => {
  const user = req.body;
  //const nameTaken = await User.findOne({ name: user.name }); removing since it's possible to have two people w/ same name.
  const emailTaken = await User.findOne({ email: user.email });

  if (emailTaken) {
    res
      .status(409)
      .json({ message: "CONFLICT, email address already in use." });
  } else {
    user.password = await bcrypt.hash(req.body.password, 10);
    const newUser = new User({
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      password: user.password,
      type: user.type,
    });
    newUser
      .save()
      .then(() => {
        res.status(200).json({ message: "User added!", user: newUser });
      })
      .catch((error) => res.status(400).json({ message: error }));
  }
});

//login user
router.route("/login").post(async (req, res) => {
  const user = req.body;
  await User.findOne({ email: user.email }).then((u) => {
    if (!u) {
      return res.status(404).json({ message: "User not found" });
    }

    bcrypt.compare(user.password, u.password).then((match) => {
      if (match) {
        const payload = {
          id: u._id,
          name: u.email,
        };
        jwt.sign(
          payload,
          process.env.TOKEN_SECRET,
          { expiresIn: 86400 },
          (error, token) => {
            if (error) {
              return res.status(401).json({ message: error });
            } else {
              return res.status(200).json({
                message: "Login Success!",
                user: u,
                jwt: "Bearer " + token,
              });
            }
          }
        );
      } else {
        return res.status(409).json({
          message: "email or password is incorrect.",
        });
      }
    });
  });
});

//read all
router.route("/").get(authenticateToken, (req, res) => {
  User.find().then((users) => {
    return res.status(200).json({ message: "Found users!", users: users });
  });
});

//read one
router.route("/:id").get(authenticateToken, (req, res) => {
  User.findById(req.params.id).then((user) =>
    res.status(200).json({ message: "Found user!", user: user })
  );
});

//update
router.route("/:id").put(authenticateToken, async (req, res) => {
  const user = req.body;
  //user.password = await bcrypt.hash(req.body.password, 10);
  const newUser = new User({
    _id: user.id,
    firstName: user.firstName,
    lastName: user.lastName,
    email: user.email,
    password: user.password,
    type: user.type,
  });
  console.log(req.body);
  await User.findByIdAndUpdate(
    { _id: newUser.id },
    {
      $set: {
        firstName: newUser.firstName,
        lastName: newUser.lastName,
        email: newUser.email,
        password: newUser.password,
        type: newUser.type,
      },
    },
    {
      new: true,
    }
  )
    .then(() => {
      console.log(res.statusMessage);
      res.status(201).json({ message: "User updated!", user: newUser });
    })
    .catch((err) => {
      console.log(err.message);
      res.status(400).json({ error: err });
    });
  //}
});

//delete
router.route("/:id").delete(authenticateToken, (req, res) => {
  const { id } = req.params;
  User.findByIdAndDelete(id)
    .then(() => {
      res.status(200).json({ message: "User deleted!" });
    })
    .catch((err) => {
      res.status(400).json({ message: err });
    });
});

module.exports = router;
