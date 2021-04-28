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
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
      </ul>
    </li>
    <li><a href="#rest-endpoints">ReST Endpoints</a></li>

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
