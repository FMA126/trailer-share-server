# Trailer Share Server API

An API to store trailers and revervation state and let users book reservations across the
internet. It allows hosts and renters to register as users of the API and book trailers with other registered users.

The API does not currently validate reservation states.

## Trailer Share Client Repo

![font end]('https://github.com/FMA126/trailer-share-client')

## API URL

```js
  production: 'https://trailer-share.herokuapp.com/',
```

## API End Points

| Verb   | URI Pattern               | Controller#Action |
|--------|---------------------------|-------------------|
| POST   | `/sign-up`                | `users#signup`    |
| POST   | `/sign-in`                | `users#signin`    |
| DELETE | `/sign-out`               | `users#signout`   |
| PATCH  | `/change-password`        | `users#changepw`  |
| GET    | `/trailers`               | `trailer#index`   |
| POST   | `/trailers`               | `trailer#create`  |
| GET    | `/trailers/:id`           | `trailers#show`   |
| PATCH  | `/trailers/:id`           | `trailers#update`    |

All data returned from API actions is formatted as JSON.

## User Actions

_Note_: Sending JSON data via curl scripts will require specifying the content-
type, however jQuery.ajax defaults to JSON.

*Summary:*

<table>
<tr>
  <th colspan="4">Request</th>
  <th colspan="2">Response</th>
</tr>
<tr>
  <th>Verb</th>
  <th>URI</th>
  <th>body</th>
  <th>Headers</th>
  <th>Status</th>
  <th>body</th>
</tr>
<tr>
<td>POST</td>
<td>`/sign-up`</td>
<td><strong>credentials</strong></td>
<td>empty</td>
<td>201, Created</td>
<td><strong>user</strong></td>
</tr>
<tr>
  <td colspan="4"></td>
  <td>400 Bad Request</td>
  <td><em>empty</em></td>
</tr>
<tr>
<td>POST</td>
<td>`/sign-in`</td>
<td><strong>credentials</strong></td>
<td>empty</td>
<td>200 OK</td>
<td><strong>user w/token</strong></td>
</tr>
<tr>
  <td colspan="4"></td>
  <td>401 Unauthorized</td>
  <td><em>empty</em></td>
</tr>
<tr>
<td>DELETE</td>
<td>`/sign-out`</td>
<td>empty</td>
<td><strong>token</strong></td>
<td>201 Created</td>
<td>empty</td>
</tr>
<tr>
  <td colspan="4"></td>
  <td>401 Unauthorized</td>
  <td><em>empty</em></td>
</tr>
<tr>
<td>PATCH</td>
<td>`/change-password`</td>
<td><strong>passwords</strong></td>
<td><strong>token</strong></td>
<td>204 No Content</td>
<td><strong>user w/token</strong></td>
</tr>
<tr>
  <td colspan="4"></td>
  <td>400 Bad Request</td>
  <td><em>empty</em></td>
</tr>
</table>

### signup

The `create` action expects a *POST* of `credentials` identifying a new user to
create, e.g. using `getFormFields`:

```html
<form>
  <input name="credentials[email]" type="text" value="an@example.email">
  <input name="credentials[password]" type="password" value="an example password">
  <input name="credentials[password_confirmation]" type="password" value="an example password">
</form>
```

or using `JSON`:

```json
{
  "credentials": {
    "email": "an@example.email",
    "password": "an example password",
    "password_confirmation": "an example password"
  }
}
```

The `password_confirmation` field is optional.

If the request is successful, the response will have an HTTP Status of 201,
Created, and the body will be JSON containing the `id` and `email` of the new
user, e.g.:

```json
{
  "user": {
    "id": 1,
    "email": "an@example.email"
  }
}
```

If the request is unsuccessful, the response will have an HTTP Status of 400 Bad
Request, and the response body will be empty.

### signin

The `signin` action expects a *POST* with `credentials` identifying a previously
registered user, e.g.:

```html
<form>
  <input name="credentials[email]" type="text" value="an@example.email">
  <input name="credentials[password]" type="password" value="an example password">
</form>
```

or:

```json
{
  "credentials": {
    "email": "an@example.email",
    "password": "an example password"
  }
}
```

If the request is successful, the response will have an HTTP Status of 200 OK,
and the body will be JSON containing the user's `id`, `email`, and the `token`
used to authenticate other requests, e.g.:

```json
{
  "user": {
    "id": 1,
    "email": "an@example.email",
    "token": "an example authentication token"
  }
}
```

If the request is unsuccessful, the response will have an HTTP Status of 401
Unauthorized, and the response body will be empty.

### signout

The `signout` action expects a *DELETE* request and must include the user's
token but no data is necessary to be sent.

If the request is successful the response will have an HTTP status of 204 No
Content.

If the request is unsuccessful, the response will have a status of 401
Unauthorized.

### changepw

The `changepw` action expects a PATCH of `passwords` specifying the `old` and
`new`, eg.:

```html
<form>
  <input name="passwords[old]" type="password">
  <input name="passwords[new]" type="password">
</form>
```

or:

```json
{
  "passwords": {
    "old": "example password",
    "new": "new example password"
  }
}
```

If the request is successful the response will have an HTTP status of 204 No
Content.

If the request is unsuccessful the reponse will have an HTTP status of 400 Bad
Request.

---

The `sign-out` and `change-password` requests must include a valid HTTP header
`Authorization: Token token=<token>` or they will be rejected with a status of
401 Unauthorized.

# Trailer Actions

All trailer action requests must include a valid HTTP header `Authorization:
Token token=<token>` or they will be rejected with a status of 401 Unauthorized.

All of the trailer actions, except for `watch`, follow the *RESTful* style.

Trailers are associated with users. Actions, other than
update, will only retrieve a trailer if the user associated with the
`Authorization` header is one of those two users. If this requirement is unmet,
the response will be 404 Not Found, except for the index action which will
return an empty trailers array.

*Summary:*

<table>
<tr>
  <th colspan="3">Request</th>
  <th colspan="2">Response</th>
</tr>
<tr>
  <th>Verb</th>
  <th>URI</th>
  <th>body</th>
  <th>Status</th>
  <th>body</th>
</tr>
<tr>
<td>GET</td>
<td>`/trailers[?over=<true|false>]`</td>
<td>n/a</td>
<td>200, OK</td>
<td><strong>trailers found</strong></td>
</tr>
<tr>
  <td colspan="3">
  The optional `over` query parameter restricts the response to trailers with a
   matching `over` property.
  </td>
  <td>200, OK</td>
  <td><em>empty trailers</em></td>
</tr>
<tr>
  <td colspan="3">
  The default is to retrieve all trailers associated with the user..
  </td>
  <td>401 Unauthorized</td>
  <td><em>empty</em></td>
</tr>
<tr>
<td>POST</td>
<td>`/trailers`</td>
<td>'{}'</td>
<td>201, Created</td>
<td><strong>trailer created</strong></td>
</tr>
<tr>
  <td colspan="3">
  </td>
  <td>401 Unauthorized</td>
  <td><em>empty</em></td>
</tr>
<tr>
  <td colspan="3">
  </td>
  <td>400 Bad Request</td>
  <td><strong>errors</strong></td>
</tr>
<tr>
<td>GET</td>
<td>`/trailers/:id`</td>
<td>n/a</td>
<td>200, OK</td>
<td><strong>trailer found</strong</td>
</tr>
<tr>
  <td colspan="3">
  </td>
  <td>401 Unauthorized</td>
  <td><em>empty</em></td>
</tr>
<tr>
  <td colspan="3">
  </td>
  <td>404 Not Found</td>
  <td><em>empty</em></td>
</tr>
<tr>
<td>PATCH</td>
<td>`/trailers/:id`</td>
<td><strong>trailer delta</strong></td>
<td>200, OK</td>
<td><strong>trailer updated</strong></td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>400 Bad Request</td>
  <td><strong>errors</strong></td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>404 Not Found</td>
  <td><em>empty</em></td>
</tr>
</table>

## index

The `index` action is a *GET* that retrieves all the trailers associated with a
user. The response body will contain JSON containing an array of trailers, e.g.:

```json
{
  "trailers": [
    {
      "id": 1,
      "make": "Haulmark",
      "model": "10' Enclosed",
      "year": 2018,
      "trailer_type": "Enclosed",
      "hitch_type": "Class 3",
      "picture": 35,
      "axels": 1,
      "price": 39.98,
      "user": {
        "id": 3,
        "email": "hownow@browncow"
      }
    },
    {
      "id": 1,
      "make": "ProLine",
      "model": "Deluxe",
      "year": 2018,
      "trailer_type": "Flatbed",
      "hitch_type": "Gooseneck",
      "picture": 45,
      "axels": 2,
      "price": 79.98,
      "user": {
        "id": 5,
        "email": "unique@newyork"
      }
    }
  ]
}
```

If there are no trailers associated with the user, the response body will contain
 an empty trailers array, e.g.:

```json
{
  "trailers": []
}
```

### Example of using the optional query parameter

End point to fetch all of a user's trailers

```md
/trailers
```

End point to fetch all of a user's trailers that are over

```md
/trailers?over=true
```

## create

The `create` action expects a *POST* with an empty body (e.g `''` or `'{}'` if
JSON). If the request is successful, the response will have an HTTP Status of
201 Created, and the body will contain JSON of the created trailer with `user`
set to the user calling `create`, e.g.:

```json
{
  "trailer": {
      "id": 1,
      "make": "Haulmark",
      "model": "10' Enclosed",
      "year": 2018,
      "trailer_type": "Enclosed",
      "hitch_type": "Class 3",
      "picture": 35,
      "axels": 1,
      "price": 39.98,
      "user": {
        "id": 3,
        "email": "hownow@browncow"
      }
    }
  }
```

If the request is unsuccessful, the response will have an HTTP Status of 400 Bad
 Request, and the response body will be JSON describing the errors.

## show

The `show` action is a *GET* specifing the `id` of the trailer to retrieve. If the
request is successful the status will be 200, OK, and the response body will
contain JSON for the trailer requested, e.g.:

```json
{
  "trailer": {
      "id": 1,
      "make": "Haulmark",
      "model": "10' Enclosed",
      "year": 2018,
      "trailer_type": "Enclosed",
      "hitch_type": "Class 3",
      "picture": 35,
      "axels": 1,
      "price": 39.98,
      "user": {
        "id": 3,
        "email": "hownow@browncow"
      }
    }
  }
```

## update

### update a trailer's states

This `update` action expects a *PATCH* with changes to to an existing trailer.

You may want to store the cell `index` in an HTML element that is not a form.
To do this, you could utilize data attributes and add the `value` and `over`
properties using javascript.

```html
<div data-cell-index='0'>
</div>
```

The `update` action expects data formatted as such:

```json
{
  "trailer": {
      "id": 1,
      "make": "Haulmark",
      "model": "10' Enclosed",
      "year": 2018,
      "trailer_type": "Enclosed",
      "hitch_type": "Class 3",
      "picture": 35,
      "axels": 1,
      "price": 39.98,
    }
  }
```

If the request is successful, the response will have an HTTP Status of 200 OK,
and the body will be JSON containing the modified trailer, e.g.:

```json
{
  "trailer": {
      "id": 1,
      "make": "Haulmark",
      "model": "10' Enclosed",
      "year": 2018,
      "trailer_type": "Enclosed",
      "hitch_type": "Class 3",
      "picture": 35,
      "axels": 1,
      "price": 39.98,
      "user": {
        "id": 3,
        "email": "hownow@browncow"
      }
    }
  }
```

If the request is unsuccessful, the response will have an HTTP Status of 400 Bad
Request, and the response body will be JSON describing the errors.
