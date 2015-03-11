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
 >>>>   "street_address": "2 Main Street", <<<<< changed variable name
        "city": "Portland",
        "state": "OR",
        "zipcode": "23814"
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

EDIT/VERIFY PROPERTY
--------------------
`STATUS 200 OK`
from
`PATCH [domain]/property/[:id]`

NOTE: If was unable to edit property will return
`STATUS 304 NOT MODIFIED`

data:
```
{
    "property": {
        "sqft": 100,
        "lotsize": 1000,
        "total_rooms": 9,
        "bedrooms": 4,
        "bathrooms": 3,
        "street_address": "2 Main Street",
        "city": "Portland",
        "state": "OR",
        "zipcode": "23814",
        "updated_at": "2015-03-10T21:12:47.395Z"
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
        "sqft": 100,
        "lotsize": 1000,
        "total_rooms": 9,
        "bedrooms": 4,
        "bathrooms": 3,
        "street_address": "2 Main Street",
        "city": "Portland",
        "state": "OR",
        "zipcode": "23814",
        "updated_at": "2015-03-10T21:12:47.395Z"
    }
}
```

REIMPORT PROPERTY
--------------------
Note: This overwrites users existing property information
will do this better later so user can choose if he wants
to import
`STATUS 200 OK`
from
`PATCH [domain]/property/[:id]/reimport`

NOTE: If was unable to edit property will return
`STATUS 304 NOT MODIFIED`

data:
```
{
    "property": {
        "street_address": "2 Main Street",
        "city": "Portland",
        "state": "OR",
        "zipcode": "23814"
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
        "sqft": 100,
        "lotsize": 1000,
        "total_rooms": 9,
        "bedrooms": 4,
        "bathrooms": 3,
        "street_address": "2 Main Street",
        "city": "Portland",
        "state": "OR",
        "zipcode": "23814",
        "updated_at": "2015-03-10T21:12:47.395Z"
    }
}
```


ADD ROOM
---------
`STATUS 201 CREATED`
from
`POST [domain]/property/[:id]/room`

data:
```
{
    "room": {
        "name": "test room",
        "sqft": null,
        "dimensions": null,
        "flooring_type": null,
        "wall_type": null,
        "paint_color": null
    }
}
```

sample [BODY] response:
```
{
    "room": {
        "id": 34,
        "name": "test room",
        "sqft": null,
        "dimensions": null,
        "flooring_type": null,
        "wall_type": null,
        "paint_color": null,
        "created_at": "2015-03-11T01:57:51.793Z",
        "updated_at": "2015-03-11T01:57:51.793Z",
        "property_id": 15
    }
}
```

EDIT ROOM
----------
`STATUS 200 OK`
from
`PATCH [domain]/property/[:id]/room/[:rid]`

data:
```
{
    "room": {
        "name": "test room",
        "sqft": null,
        "dimensions": null,
        "flooring_type": null,
        "wall_type": null,
        "paint_color": null
    }
}
```

sample [BODY] response:
```
{
    "room": {
        "id": 34,
        "name": "test room",
        "sqft": null,
        "dimensions": null,
        "flooring_type": null,
        "wall_type": null,
        "paint_color": null,
        "created_at": "2015-03-11T01:57:51.793Z",
        "updated_at": "2015-03-11T01:57:51.793Z",
        "property_id": 15
    }
}
```

DELETE ROOM
----------
`STATUS 200 OK`
from
`DELETE [domain]/property/[:id]/room/[:rid]`

sample [BODY] response:
```
{
    "message": "35 - Guest Bedroom Removed"
}
```


ADD ITEM TO ROOM
----------------
`STATUS 201 CREATED`
from
`POST [domain]/property/[:id]/room/[:rid]/item`

data:
```
{
    "item": {
        "category": "Appliances",
        "name": "LG Refridgerator",
        "purchase_date": "03/27/2015,
        "serial_number": "SK89E-X1-094729,
        "price": "1300",
        "condition": "New"
    }
}
```

sample [BODY] response:
```
{
    "item": {
        "id": 3,
        "category": "Appliances",
        "name": "LG Refridgerator",
        "purchase_date": "03/27/2015,
        "serial_number": "SK89E-X1-094729,
        "price": "1300",
        "condition": "New"
        "created_at": "2015-03-11T03:11:51.138Z",
        "updated_at": "2015-03-11T03:11:51.138Z",
        "room_id": 47,
        "property_id": 15
    }
}
```


ADD ITEM TO PROPERTY
--------------------
`STATUS 201 CREATED`
from
`POST [domain]/property/[:id]/item`

data:
```
{
    "item": {
        "category": "Appliances",
        "name": "LG Refridgerator",
        "purchase_date": "03/27/2015,
        "serial_number": "SK89E-X1-094729,
        "price": "1300",
        "condition": "New"
    }
}
```

sample [BODY] response:
```
{
    "item": {
        "id": 3,
        "category": "Appliances",
        "name": "LG Refridgerator",
        "purchase_date": "03/27/2015,
        "serial_number": "SK89E-X1-094729,
        "price": "1300",
        "condition": "New"
        "created_at": "2015-03-11T03:11:51.138Z",
        "updated_at": "2015-03-11T03:11:51.138Z",
        "room_id": null,
        "property_id": 15
    }
}
```

DELETE ITEM
-----------
`STATUS 200 WHAT OKKKKAYYYYYY`
from
`DELETE [domain]/item/[:iid]`

sample [BODY] response:
```
{
    "message": "Item 3 LG Refridgerator deleted" 
}
```

