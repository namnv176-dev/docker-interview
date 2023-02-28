require("dotenv").config();

//Load HTTP module
const http = require("http");
const hostname = "0.0.0.0";
const port = 3000;

//Create HTTP server and listen on port 3000 for requests
const server = http.createServer((req, res) => {
  //Set the response HTTP header with HTTP status and Content type
  console.log(req.url);
  if (req.url === "/favicon.ico") {
    res.writeHead(200, { "Content-Type": "image/x-icon" });
    res.end();
    console.log("favicon requested");
    return;
  } else {
    res.statusCode = 200;
    res.setHeader("Content-Type", "application/json");
    var queryString = decodeURI(req.url);
    var queryPattern = /^\/\?city=[a-zA-z\s]*$/;
    // queryPattern.test(queryString)
    if (queryString !== "/") {
      if (queryPattern.test(queryString)) {
        var apiKey = process.env.API_KEYS;
        const urlParams = new URLSearchParams(req.url.split("?")[1]);
        const cityQuery = encodeURI(urlParams.get('city').trim().toUpperCase())
        const options = {
          hostname: "api.openweathermap.org",
          path: `/data/2.5/weather?q=${cityQuery}&appid=${apiKey}`,
          method: "GET",
          headers: {
            "Content-Type": "application/json",
          },
        };
        const reqToWeatherAPI = http.request(options, (response) => {
          console.log(`STATUS: ${response.statusCode}`);
          console.log(`HEADERS: ${JSON.stringify(response.headers)}`);
          response.setEncoding("utf8");
          response.on("data", (chunk) => {
            res.end(chunk);
          });
          response.on("end", () => {
            res.end("No more data in response.");
          });
        });
        reqToWeatherAPI.end();
      } else res.end("Invalid url. Example: http://localhost?city=ha noi\n");
    } else {
      res.end(
        "Search the weather with city name by type city={your city} to url!\n",
      );
    }
  }
});
//listen for request on port 3000, and as a callback function have the port listened on logged
server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
