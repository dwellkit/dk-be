README
======

This is where the API docs will lie from here on out unless we decide to change
to somewhere else, but here goes:
our url for now is here: `https://dwellingkit-api.herokuapp.com`

USERS
-----

####Create a User
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


####User Sign-In
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

PROPERTIES
----------
###Get users properties
`STATUS 200 OK`
from
`GET [domain]/user/info`

returns user email and all properties associated with account

####Get a specific property
`STATUS 200 OK`
from
`GET [domain]/properties/[:id]`


####Add a Property
`STATUS 200 OK`
from
`POST [domain]/properties/add`

NOTE: If was unable to locate property will return
`STATUS 304 NOT MODIFIED`

data:
```
{
    "property": {
        "address": "2210 12th street nw washington dc 20009"
    }
}
```

sample [BODY] response:
```
{
    "created_at": "2015-03-15T21:30:58.087Z",
    "updated_at": "2015-03-15T21:30:58.087Z",
    "property": {
        "image": {
            "thumb": "/images/thumb/missing.png",
            "medium": "/images/medium/missing.png",
            "large": "/images/large/missing.png"
        },
        "id": 2,
        "lotsize": 1124,
        "sqft": 0,
        "yearbuilt": 1890,
        "total_rooms": null,
        "bedrooms": 3,
        "bathrooms": 2.5,
        "actual_rooms": 0,
        "address": {
            "street_address": "2210 12th St, Washington, DC 20009"
        },
        "rooms": [
            {
                "id": 7,
                "name": "Bedroom 1",
                "sqft": null,
                "dimensions": null,
                "flooring_type": null,
                "paint_color": null,
                "items": []
            },
            {
                "id": 8,
                "name": "Bedroom 2",
                "sqft": null,
                "dimensions": null,
                "flooring_type": null,
                "paint_color": null,
                "items": []
            },
            {
                "id": 9,
                "name": "Bedroom 3",
                "sqft": null,
                "dimensions": null,
                "flooring_type": null,
                "paint_color": null,
                "items": []
            },
            {
                "id": 10,
                "name": "Bathroom 1",
                "sqft": null,
                "dimensions": null,
                "flooring_type": null,
                "paint_color": null,
                "items": []
            },
            {
                "id": 11,
                "name": "Bathroom 2",
                "sqft": null,
                "dimensions": null,
                "flooring_type": null,
                "paint_color": null,
                "items": []
            },
            {
                "id": 12,
                "name": "Bathroom 3",
                "sqft": null,
                "dimensions": null,
                "flooring_type": null,
                "paint_color": null,
                "items": []
            }
        ],
        "items": []
    }
}
```

####Edit or Verify a Property
`STATUS 200 OK`
from
`PATCH [domain]/properties/[:id]`

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

####Reimport a property
Note: This overwrites users existing property information
will do this better later so user can choose if he wants
to import
`STATUS 200 OK`
from
`PATCH [domain]/properties/[:id]/reimport`

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

####Add a profile pic to property
`STATUS 201 CREATED`
from
`POST [domain]/properties/[:id]/pic`

Just need to send an image file under 2mb.
Server will reformat the picture in these sizes
```
:large => "800x800",
:medium => "300x300>",
:thumb => "100x100>" 
```

if you ever want to get a picture and get this:
`/images/:size/missing.png`
picture was never added or an internal error occured

ROOMS
-----
NOTE: requires a property id

####Add a Room
`STATUS 201 CREATED`
from
`POST [domain]/properties/[:id]/rooms`

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

####Edit a room
`STATUS 200 OK`
from
`PATCH [domain]/properties/[:id]/rooms/[:rid]`

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

####Delete a room
`STATUS 200 OK`
from
`DELETE [domain]/properties/[:id]/rooms/[:rid]`

sample [BODY] response:
```
{
    "message": "35 - Guest Bedroom Removed"
}
```

ITEMS
-----

####Get property items
`STATUS 200 OK`
from
`GET [domain]/properties/[:id]/items`

####Get room items
`STATUS 200 OK`
from
`GET [domain]/properties/[:id]/rooms/[:rid]/items`

####Add item to room
`STATUS 201 CREATED`
from
`POST [domain]/properties/[:id]/rooms/[:rid]/items`

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


####Add item to property
`STATUS 201 CREATED`
from
`POST [domain]/properties/[:id]/items`

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

#### Delete Item
`STATUS 200 WHAT OKKKKAYYYYYY`
from
`DELETE [domain]/items/[:iid]`

sample [BODY] response:
```
{
    "message": "Item 3 LG Refridgerator deleted" 
}
```

CONTACTS
--------

####Create Contact
* creating a contact individually, not assigned to anything other than property

`STATUS 201 CREATED`
from `POST [domain]/contacts`

data for contact:
```
{
    "contacts": {
        "name": "Brett Smith",
        "company": "GE",
        "telephone_number": 4075678970,
        "email": "brett@gmail.com",
        "url": "ge.com",
        "notes": "good person",
        "fax_number": 6754443456,
    }
}
```

sample [BODY} response:
```
{
    "contact": {
        "id": 24,
        "name": "Brett Smith",
        "company": "GE",
        "telephone_number": 4075678970,
        "email": "brett@gmail.com",
        "url": "ge.com",
        "notes": "good person",
        "fax_number": 6754443456,
        "created_at": "2015-03-12T01:30:22.127Z",
        "updated_at": "2015-03-12T01:30:22.127Z",
        "reachable_id": null,
        "reachable_type": null
    }
}
```
* reachable_id and reachable_type will return null because they have not been "assigned" yet.  See the warranty create method below that both creates a warranty and a contact for that warrant at the same time.

WARRANTIES
----------
####Get all warranties
`STATUS 200 OK`
from `GET [domain]/properties/[:id]/warranties`

####Create Warranty

* will also prompt the user to enter contact information if they choose to

`STATUS 201 CREATED`
from `POST [domain]/items/[:iid]/warrenties`

data for warranty:
```
{
    "warranty": {
        "name": "Fridge Warranty"
        "description": "GE Fridge Model GX100"
        "warranty_number": "1098891235",
        "expiration_date": 
        "url": "www.ge.com"
        "notes": "Great coverage",
    }
}
```

data for contact:
```
{
    "contacts": {
        "name": "Brett Smith",
        "company": "GE",
        "telephone_number": 4075678970,
        "email": "brett@gmail.com",
        "url": "ge.com",
        "notes": "good person",
        "fax_number": 6754443456,
    }
}
```
* Contacts will be created at the same time as creating a warranty. Contact will become assigned to that warranty upon creation. 

sample [BODY] response:
```
{
    "created_at": "2015-03-12T01:11:53.468Z",
    "updated_at": "2015-03-12T01:11:53.468Z",
    "warranty": {
        "item_name": "Fridge"
        "name": "Fridge Warranty",
        "description": "GE Fridge Model GX100",
        "warranty_number": "1098891235",
        "expiration_date": ,
        "url": "www.ge.com",
        "notes": "Great coverage",
        "item_id": 25
        "contacts": [
            {
                "name": "Brett Smith",
                "company": "GE",
                "telephone_number": 4075678970,
                "email": "brett@gmail.com",
                "url": "ge.com",
                "notes": "good person",
                "fax_number": null,
                "reachable_id": 24,
                "reachable_type": "Warranty"
            }
        ]
    }
}
```

INSURANCE
---------

####Create Insurance
* will also prompt the user to enter contact information if they choose to

`STATUS 201 CREATED`
from `POST [domain]/items/[:iid]/insurances`

data for insurance:
```
{
    "insurance": {
        "company": "Allstate",
        "description": "Top tier for coverage",
        "policy_number": 709231759780912,
        "expiration_date":  ,
        "url": "allstate.com",
        "notes": "Cool stuff",
        "item_name": "Roof"
    }
}
```
data for contact:
```
{
    "contacts": {
        "name": "Brett Smith",
        "company": "GE",
        "telephone_number": 4075678970,
        "email": "brett@gmail.com",
        "url": "ge.com",
        "notes": "good person",
        "fax_number": 6754443456,
    }
}
```
* Contacts will be created at the same time as creating an insurance policy. Contact will become assigned to that insurance policy upon creation.

sample [BODY] response:
```
{
    "created_at": "2015-03-13T15:44:22.919Z",
    "updated_at": "2015-03-13T15:44:22.919Z",
    "insurance": {
        "company": "Allstate",
        "description": "Top tier for coverage",
        "policy_number": 709231759780912,
        "expiration_date":  ,
        "url": "allstate.com",
        "notes": "Cool stuff",
        "item_name": "Roof",
        "contacts": [
            {
                "name": "Brett Smith",
                "company": "GE",
                "telephone_number": 4075678970,
                "email": "brett@gmail.com",
                "url": "ge.com",
                "notes": "good person",
                "fax_number": 6754443456,
                "reachable_id": 10,
                "reachable_type": "Insurance"
            }
        ]
    }
}
```

EVENTS
------

####Get Users Events
`STATUS 201 CREATED`
from `GET [domain]/events`

####Create New Event
`STATUS 201 CREATED`
from `POST [domain]/events`

NOTE: event_frequency is in number of seconds
( 604,800 seconds = 1 week )
( 2,628,000 seconds = 1 month)

data for event:
```
{
    "event": {
        "name": "Clean the Gutters"
        "notes": "The poplar tree dumps this time of year"
        "event_date": "2015-03-19 13:08:55 -0400",
        "event_frequency": 604800
    }
}
```