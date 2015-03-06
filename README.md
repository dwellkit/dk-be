README
======

This is where the API docs will lie from here on out unless we decide to change
to somewhere else, but here goes:
our url for now is here: `https://dwellingkit-api.herokuapp.com`

CREATE USER
-----------
`STATUS 201 CREATED`
from
`POST [domain]/auth`

data:
```
  "email": "testuser@gmail.com",
  "password": "securepassword",
  "password_confirmation": "securepassword",
  "confirm_success_url": "true"
```

sample [BODY] response:
```
{
    "status": "success",
    "data": {
        "id": 7,
        "email": "testuser@gmail.com",
        "provider": "email",
        "uid": "testuser@gmail.com",
        "name": null,
        "nickname": null,
        "image": null,
        "created_at": "2015-03-06T15:27:01.587Z",
        "updated_at": "2015-03-06T15:27:01.746Z"
    }
}
```


USER SIGN-IN
-----------
`STATUS 200 OK`
from
`POST [domain]/auth/sign_in`

data:
```
  "email": "testuser@gmail.com",
  "password": "securepassword"
```

sample [BODY] response:
```
{
    "data": {
        "id": 7,
        "email": "testuser@gmail.com",
        "provider": "email",
        "uid": "testuser@gmail.com",
        "name": null,
        "nickname": null,
        "image": null
    }
}
```

sample [HEADER] response:
```
Access-Token → a5xZ-eUezlklNVvbMRUKuQ
Cache-Control → max-age=0, private, must-revalidate
Client → oLZ0uK7F9wpLmsqQmsPoFg
Connection → Keep-Alive
Content-Length → 133
Content-Type → application/json; charset=utf-8
Date → Fri, 06 Mar 2015 15:30:37 GMT
Etag → W/"6c2908a77399e9a3bc8ca34faf14f060"
Expiry → 1426861836
Server → WEBrick/1.3.1 (Ruby/2.1.5/2014-11-13)
Token-Type → Bearer
Uid → testuser@gmail.com
X-Content-Type-Options → nosniff
X-Frame-Options → SAMEORIGIN
X-Request-Id → 92231545-41a7-4f77-a558-0cb75f96955b
X-Runtime → 0.244565
X-Xss-Protection → 1; mode=block
```