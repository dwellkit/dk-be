README
======

This is where the API docs will lie from here on out unless we decide to change
to somewhere else, but here goes:
our url for now is here: `https://dwellingkit-api.herokuapp.com`

CREATE USER
-----------
`STATUS 201 CREATED`
from
`POST [domain]/users`



data:
```
{
    "user": {
        "email": "test@test.com",
        "password": "atleast8chars",
        "password_confirmation": "atleast8chars"
    }
}
```

sample [BODY] response:
```
{
    "user": {
        "email": "test@test.com",
        "authentication_token": "gaCEXmumUaZXif9GkQg6"
    }
}
```


USER SIGN-IN
-----------
`STATUS 200 OK`
from
`POST [domain]/users/sign_in`

data:
```
{
    "user": {
        "email": "test@test.com",
        "password": "atleast8chars"
    }
}
```

sample [BODY] response:
```
{
    "user": {
        "email": "test@test.com",
        "authentication_token": "gaCEXmumUaZXif9GkQg6"
    }
}
```

ADD PROPERTY
------------
`STATUS 200 OK`
from
`POST [domain]/property/add`

NOTE: If was unable to locate property will return
`STATUS 304 NOT MODIFIED`

data:
```
{
    "property": {
        "address": "2 Main Street",
        "city": "Portland",
        "state": "OR"
    }
}
```

sample [BODY] response:
```
{
    "property": {
        "id": 10,
        "created_at": "2015-03-10T21:12:36.270Z",
        "rooms": [],
        "sqft": 4299,
        "lotsize": 68389,
        "total_rooms": null,
        "bedrooms": 3,
        "bathrooms": 2,
        "street_address": "2 Main Street",
        "city": "Portland",
        "state": "OR",
        "zipcode": "23814",
        "updated_at": "2015-03-10T21:12:47.395Z"
    }
}
```
