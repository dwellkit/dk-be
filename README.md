README
======

This is where the API docs will lie from here on out unless we decide to change
to somewhere else, but here goes:
our url for now is here: `https://dwellingkit-api.herokuapp.com`


NEEDS
    delete property image @ `properties#delete_image`

USERS
-----
####Create a User
`POST [domain]/users`
- user
    - email | string
    - password | string
    - password_confirmation | string

####User sign in
`POST [domain]/users/sign_in`
- user
    - email | string 
    - password | string

PROPERTIES
----------
####Create a property
`POST [domain]/properties`
- property
    - address | string

#####Get a property
`GET [domain]/properties/[:id]`

####Edit a property
`PATCH [domain]/properties/[:id]`
- property
    - sqft | integer
    - lotsize | integer
    - total_rooms | integer
    - bedrooms | integer
    - bathrooms | float

####Reimport a property
`PATCH [domain]/properties/[:id]`
- property
    - address | string

####Add image to property
`POST [domain]/properties/[:id]/images`
(ian)

####Delete a property image
`DELETE [domain]/properties/[:id]/images/[:image_id]`

####Add profile pic to property
`POST [domain]/properties[:id]/profile`
- property
    - profile | file

ROOMS
-----
####Add a room
`POST [domain]/properties/[:id]/rooms`
- room
    - name | string
    - sqft | integer
    - dimensions | string
    - flooring_type | string
    - wall_type | string
    - paint_color | string

####Edit a room
`PATCH [domain]/properties/[:id]/rooms/[:rid]`
- room
    - name | string
    - sqft | integer
    - dimensions | string
    - flooring_type | string
    - wall_type | string
    - paint_color | string

####Delete a room
`DELETE [domain]/properties/[:id]/rooms/[:rid]`

CONTACTS
--------
####Create a contact
`POST [domain]/properties/[:id]/contacts`

####Edit a contact
`PATCH [domain]/properties/[:id]/contacts/[:cid]`

####Delete a contact
`DELETE [domain]/properties/[:id]/contacts/[:cid]`

INSURANCE
---------
####team needs to talk about this one
is insurance tied to items, or is it tied to properties?

EVENTS
------
####Create an event
`POST [domain]/properties/[:id]/events`
- event
    - name | string
    - notes | string
    - event_date | date
    - event_frequency | integer (this is in seconds (604800 = one week))

####Delete an event
`DELETE [domain]/properties/[:id]/events/[:eid]`

####Get all events
`GET [domain]/properties/[:id]/events`

WARRANTIES
----------
####Create a warranty
`POST [domain]/properties/[:id]/rooms/[:rid]/items/[:iid]/warranties/`
- warranty
    - name | string
    - warranty_number | string
    - description | string
    - expiration_date | date
    - url | string
    - notes | string
####Update a warranty
`PATCH [domain]/properties/[:id]/rooms/[:rid]/items[:iid]/warranties/[:wid]`
- warranty
    - name | string
    - warranty_number | string
    - description | string
    - expiration_date | date
    - url | string
    - notes | string
####Delete a warranty
`DELETE [domain]/properties/[:id]/rooms/[:rid]/items/[:iid]/warranties/[:wid]`


ITEMS
-----

####Get a properites item
`GET [domain]/properties/items`



OLD ROUTES BELOW
----------------
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
    "contact": {
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

####Delete Contact
`STATUS 200 OK`
from `DELETE [domain]/contacts/[:cid]`

####Update Contact
`STATUS 200 OK`
from `PATCH [domain]/contacts/[:cid]`

sample data
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

####Show single contact
`STATUS 200 OK`
from `GET [domain]/contacts/[:cid]`

####Get contacts for a property
`STATUS 200 OK`
from `GET [domain]/properties/[:id]/contacts`


WARRANTIES
----------
####Get all warranties
`STATUS 200 OK`
from `GET [domain]/properties/[:id]/warranties`

####Delete Warranty
`STATUS 200 OK`
from `DELETE [domain]/warranties/[:wid]`

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
`( 604,800 seconds = 1 week )`
`( 2,628,000 seconds = 1 month)`

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

####Delete Event
`STATUS 200 OK`
from `DELETE [domain]/events/[:eid]`