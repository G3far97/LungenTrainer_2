const express = require('express');
const app = express();
const port = process.env.PORT || 3000; // Render assigns a port via process.env.PORT

// Serve your MATLAB web app's static files
app.use(express.static('path_to_your_ctf_file_directory'));

// Start the server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
