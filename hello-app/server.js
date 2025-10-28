const express = require('express');
const os = require('os');
const app = express();

const port = process.env.PORT || 8080;

app.get('/', (req, res) => {
    console.log(`serving request: ${req.url}`);
    const hostname = os.hostname();
    res.send(`Hello, world!\nversion: 1.0.0\nHostname: ${hostname}\n`);
});

app.listen(port, () => {
    console.log(`Server listening on port ${port}`);
});

