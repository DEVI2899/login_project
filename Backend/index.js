const express = require('express');
const bodyParser = require('body-parser');
const userRoutes = require('./userRoutes');
const cors = require('cors');



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