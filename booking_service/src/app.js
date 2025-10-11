import express from "express";
import sequelize from "./config/mysql.js";
import connectMongo from "./config/mongo.js";

const app = express();
app.use(express.json());

app.get("/", (req, res) => res.send("EVCS Backend is running 🚗⚡"));

await sequelize.sync();
connectMongo();

app.listen(5000, () => console.log("🚀 Server started on port 5000"));
