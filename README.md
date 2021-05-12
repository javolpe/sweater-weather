# README

## Sweater Weather by Jake Volpe, Turing School of Software & Design Student

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
    </li>
    <li><a href="#endpoints">Endpoints</a></li>

  </ol>
</details>

### About The Project
This repository is meant to mimick a backend service in a multi-server application architecture.  The frontend server would send JSON requests to the backend and the backend would respond with appropriate responses to fulfill the data.  More on this later.  The backend does not handle actual logging in/out or modifying the sessions cookie to keep track of login info.  The backend DOES handle creating of a user, generating an API key for that user, and verifying data for logged in users.
The backend theefore only has one table that houses user credentials. It does verify that the password/password confirm match on creation, and that email has not already been used.  The user table only has email, password, and api_key data stored for an individual resource.

### Built With
* [Ruby on Rails](https://rubyonrails.org/)
* [PostgreSQL](https://www.postgresql.org/)
* [MapQuest Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/)
* [Open Weather API](https://openweathermap.org/api/one-call-api)
* [Unsplah Image API](https://unsplash.com/developers)
* [Mapquest Directions API](https://developer.mapquest.com/documentation/directions-api/)


### Getting Started
This project was built to mimick what a backend would send to a frontend server and does not have a functioning server to hit but endpoints can be reached via Postman. To hit these endpoints clone down the repo and run your Rails server locally. This is not hosted live hence the localhost domain.  I'm well aware of the joke about the dev student asking you to check out their "cool new site" and sending you localhost, this not that but I do appreciate the humor.  


### Endpoints

The endpoints to hit are as follows:

1) "http://localhost:3000/api/v1/forecast?location=denver,co"

  This is a GET request to get a weather forecast for a city .  Pass in a city, state for a query param and the endpoint will return you weather forecast data for that location.  The first API call for this endpoint is to maquest to get coordinates for that location.  Then a second call is made to the weather service API.  The weather data is then run through a PORO to only return 8 hours of weather data and 5 hours of daily weather data.
*sad path note*
The mapquest coordinate API is a bit of an overachiever and if given jumbled strings for a destination will return valid coordinates ranging from Idaho to Montana to Texas and more.  The sad path of jumbled string is unhandled, in a production app it would be better to utilize another service to verify the location before continuing to gather weather data.  This also impacts the last endpoint.

2) "http://localhost:3000/api/v1/backgrounds?location=denver,co"


  This is a GET request to get an image to be used along with the weather forecast for the city.. Again any city can be passed in for the query param.  You will be returned a random image of the city for display with the weather app.  I have added the term "skyline" to the search but maybe could just a better keyword term for use with a weather app.  This request utilizes Unsplash API and does provide proper crediting of the photographer and site for the front end to display.  We all want credit for our work, we should build empathy wherever we can.

3) "http://localhost:3000/api/v1/users"

  This is POST request to create a new user in the system. It is configured to take params in the body of the request in JSON. The reuqest must contain an email that is not already being used in the system, a password and a password_confirmation that matches.  A succesful request returns the users email as well as an auto-generated API key.  The password matching and validation as well as password encoding is handled by the bcrypt gem. Unsuccesful requests return 400 level status codes with reasons why the user was not able to be created. Actual login functionality is handled by the frontend who controls the session cookie.
  
 4) "http://localhost:3000/api/v1/login"

  This is also a POST request to see if the user should be allowed to be logged in.  Again, the data is sent to the backend formatted in JSON in the body of the request.  A user's email and passowrd is sent to the backend.  If the backend can verify the user exists the frontend is responded to with JSON in the body of the response that contains the user's email and API key.
  
 5) "http://localhost:3000/api/v1/road_trip"
 
 Another POST request to again keep query params formatted as JSON in the body of the request. This request requires an origin, destination and valid API key.  It uses the same map coordinated and weather api from forecast but this time returns the drive time between origin and destination given by mapquest's directions API.  It also utilizes the weather one call API to give a forecast of the weather when you arrive, either in the next hour after you arrive or the day of your arrival as that is the most accurate data we have available. 


