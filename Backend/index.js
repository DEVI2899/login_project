const express = require('express');
const bodyParser = require('body-parser');
const userRoutes = require('./userRoutes');
const cors = require('cors');
const jwt = require('jsonwebtoken');


const app = express();
const port = process.env.PORT || 3000;


app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(cors());
app.use('/api', userRoutes);


app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});

app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.post('/api/checkToken', (req, res)=> {
           const sample = {
                                id:01,
                                username: "priya",
                                email: "priya@example.com",
                                password: "priya@12"
                               }
                               jwt.sign({sample :sample}, 'secretKey', (err,token)=>{
                               res.json({
                                 token
                               })
                               })
                           });