# README (or don't no need to be rude about it)
## Cloning and Running

When cloning this project down to your machine, the repository should automate most of the stuff it requires and will tell you what you need to do otherwise (e.g., Ruby Versioning, Rails Versioning, etc...), however, you _will_ need to run the command `bundle install` after the cloning is completed in-order to get the required gems for functionality. After this is done, you will be required to run the following command as well:

`rails db:{create,migrate,seed}`

After that is completed, the app should be up and functional, simply run `rails s` and fire up your API platform of choice.

## Database Structure
![Screen Shot 2022-06-03 at 9 10 36 AM](https://user-images.githubusercontent.com/77761679/171881814-bee6e7ad-ddb8-489a-a8ba-ec3d482bcf6a.png)

This API employs both one to many, and many to many relationships.
A customer can have many different subscriptions, each unique to them. Each subscription can have multiple teas included within it, and each tea can belong in multiple subscription. If given more time, this would allow for the creation of dynamic subscriptions that can change in value with the respective amount of teas and frequency.

## Endpoints

The TeaSubscription API only contains 4 endpoints, which are the following:

### POST /api/v1/customers
The `POST /api/v1/customer` endpoint is used for creating a customer within the database which is required for the functionality of the rest of the app. The endpoint requires a request body who's structure is that of the following:

```json
{
  "first_name": "Hubert",
  "last_name": "Roberts",
  "email": "hubertroberts@test.com",
  "address": "399 S. Layoni"
}
```

The API will tell you if a necessary field is missing, or if the email provided has already been taken - otherwise, you will receive a successful response with a serialized set of a data regarding the new user.

### POST /api/v1/subscriptions
The `POST /api/v1/subscriptions` endpoint is used for creating a new subscription for a given user - currently, the API is limited to a single tea which is through it's `title` attribute within the database (only 3 types of tea exist by default when setting up the application, being `"Matcha"`, `"Yerba Mate"`, and `"Green Tea"`). The frequency of a subscription is represented with `0`, `1`, `2`, which translate to `weekly`, `biweekly`, and `monthly` due to an enum within the `subscription` model. The endpoint requires a request body who's structure is that of the following:

```json
{
  "email": "hubertroberts@gmail.com",
  "tea": "Matcha",
  "frequency": 0
}
```


### PATCH /api/v1/subscriptions 
The `PATCH /api/v1/subscriptions` endpoint is currently limited purely to activating or deactivating a given subscription. Possible functionality would include adding/removing teas, and changing frequency. Status' are represented in binary, with `0` representing `active`, and `1` representing `inactive`, respectively. The endpoint requires a request body who's structure is that of the following:

```json
{
  "subscription_id": "1",
  "status": 0
}
```

### GET /api/v1/subscriptions
The `GET /api/v1/subscriptions` endpoint is the most simple of the endpoints. It just requires an email that exists within the database, which will then give you a serialized set of all the users subscriptions. The endpoint requires a request body who's structure is that of the following:

```json
{
  "email": "hubertroberts@gmail.com"
}
```

### DELETE /api/v1/subscriptions
The 'DELETE /api/v1/subscriptions' endpoint is used to delete a specific subscription of a given account. There are most-definitely significantly more secure ways I could've approached this endpoint (much more, the entire creation of this application), but it was outside of the scope required for technical project completion. The endpoint requires a request body who's structure is that of the following:

```json
{
  "email": "hubertroberts@gmail.com",
  "subscription_id": "1"
}
```
The email is required to send the user a serialized JSON of all their now currently existing subscriptions.

## Misc 

Because this was a short take-home project for the program I'm attending, there's a lot of functionality that doesn't exist that seemingly should, or things that don't seem as rounded out in structure because there wasn't enough time to implement it. Several things that I would do if given more time to improve this application and make it more rounded it out would be:

* Automatically creating an API key attached to each customer and creating those checks (e.g., a required field within the body of a request) to restrict who can make requests to the application 
* Restrict user CRUD functionality solely to their own subscriptions 
* Make subscription cost based off of the types of tea, quantity, and frequency, instead of having it statically set
* Create tea 'bundles' to more effectively show why the database was structured the way it was 
* Find teas based off of more unique, salted names, or purely by ID instead of by plain names in both request bodies and the controller
