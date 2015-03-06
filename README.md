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

required fields: `email`, `password`, `password_confirmation`
optional fields: `address`, `city`, `zip`, `state`

data:
```
  "email": "testuser@gmail.com",
  "password": "securepassword",
  "password_confirmation": "securepassword"
```

sample [BODY] response:
```
{
    "status": "success",
    "data": {
        "id": 10,
        "email": "testuser@gmail.com",
        "provider": "email",
        "uid": "testuser@gmail.com",
        "name": null,
        "nickname": null,
        "image": null,
        "created_at": "2015-03-06T18:33:27.654Z",
        "updated_at": "2015-03-06T18:33:27.816Z",
        "address": null,
        "zip": null,
        "city": null,
        "state": null,
        "zpid": null
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
    "status": "success",
    "data": {
        "id": 10,
        "email": "test22233user@gmail.com",
        "provider": "email",
        "uid": "test22233user@gmail.com",
        "name": null,
        "nickname": null,
        "image": null,
        "created_at": "2015-03-06T18:33:27.654Z",
        "updated_at": "2015-03-06T18:33:27.816Z",
        "address": null,
        "zip": null,
        "city": null,
        "state": null,
        "zpid": null
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

DEVISE USER AUTH DOCS
=====================
The following routes are available for use by your client.

| path | method | purpose |
|:-----|:-------|:--------|
| /    | POST   | Email registration. Accepts **`email`**, **`password`**, and **`password_confirmation`** params. A verification email will be sent to the email address provided. Accepted params can be customized using the [`devise_parameter_sanitizer`](https://github.com/plataformatec/devise#strong-parameters) system. |
| / | DELETE | Account deletion. This route will destroy users identified by their **`uid`** and **`auth_token`** headers. |
| / | PUT | Account updates. This route will update an existing user's account settings. The default accepted params are **`password`** and **`password_confirmation`**, but this can be customized using the [`devise_parameter_sanitizer`](https://github.com/plataformatec/devise#strong-parameters) system. |
| /sign_in | POST | Email authentication. Accepts **`email`** and **`password`** as params. This route will return a JSON representation of the `User` model on successful login. |
| /sign_out | DELETE | Use this route to end the user's current session. This route will invalidate the user's authentication token. |
| /:provider | GET | Set this route as the destination for client authentication. Ideally this will happen in an external window or popup. [Read more](#omniauth-authentication). |
| /:provider/callback | GET/POST | Destination for the oauth2 provider's callback uri. `postMessage` events containing the authenticated user's data will be sent back to the main client window from this page. [Read more](#omniauth-authentication). |
| /validate_token | GET | Use this route to validate tokens on return visits to the client. Accepts **`uid`** and **`auth_token`** as params. These values should correspond to the columns in your `User` table of the same names. |
| /password | POST | Use this route to send a password reset confirmation email to users that registered by email. Accepts **`email`** and **`redirect_url`** as params. The user matching the `email` param will be sent instructions on how to reset their password. `redirect_url` is the url to which the user will be redirected after visiting the link contained in the email. |
| /password | PUT | Use this route to change users' passwords. Accepts **`password`** and **`password_confirmation`** as params. This route is only valid for users that registered by email (OAuth2 users will receive an error). |
| /password/edit | GET | Verify user by password reset token. This route is the destination URL for password reset confirmation. This route must contain **`reset_password_token`** and **`redirect_url`** params. These values will be set automatically by the confirmation email that is generated by the password reset request. |

