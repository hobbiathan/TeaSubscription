# README
## Cloning and Running

When cloning this project down to your machine, the repository should automate most of the stuff it requires and will tell you what you need to do otherwise (e.g., Ruby Versioning, Rails Versioning, etc...), however, you _will_ need to run the command `bundle install` after the cloning is completed in-order to get the required gems for functionality. After this is done, you will be required to run the following command as well:

`rails db:{create,migrate}`

After that is completed, the app should be up and functional.

## Endpoints

The TeaSubscription API only contains 4 endpoints, which are the following:

#### POST /api/v1/customers
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

#### POST /api/v1/subscriptions
The `POST /api/v1/subscriptions` endpoint is used for creating a new subscription for a given user - currently, the API is limited to a single tea which is found user its respective ID within the database (in our case, we only have "Matcha" tea, under `ID 1`). The frequency of a subscription is represented with `0`, `1`, `2`, which translate to `weekly`, `biweekly`, and `monthly` due to an enum within the `subscription` model. The endpoint requires a request body who's structure is that of the following:

```json
{
  "email": "hubertroberts@gmail.com",
  "tea": "1",
  "frequency": 0
}
```


#### PATCH /api/v1/subscriptions 
The `PATCH /api/v1/subscriptions` endpoint is currently limited purely to activating or deactivating a given subscription. Possible functionality would include adding/removing teas, and changing frequency. The endpoint requires a request body who's structure is that of the following:

```json
{
  "subscription_id": "1",
  "status": 0
}
```

#### GET /api/v1/subscriptions
The `GET /api/v1/subscriptions` endpoint is the most simple of the endpoints. It just requires an email that exists within the database, which will then give you a serialized set of all the users subscriptions. The endpoint requires a request body who's structure is that of the following:

```json
{
  "email": "hubertroberts@gmail.com"
}
```

## Misc 
ok 👍🏼
