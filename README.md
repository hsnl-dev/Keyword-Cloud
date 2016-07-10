# Keywords Cloud API

## Routes
### Authenticate Routes

#### Overview

| Method |            URL                |        What to do        |
| :----: | :------------------------:    | :----------------------: |
|  POST  | /api/v1/accounts/authenticate | login and get auth token |

#### Example

**POST /api/v1/accounts/authenticate**
```shell
$ curl http://localhost:9292/api/v1/accounts/authenticate \
	-X POST \
	-H 'content-type: application/json' \
	-d '{
          "account": "a1234@mail.com",
          "password": "a1234"
        }'
```

```
{
  "uid":1,
  "auth_token": "eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIiwiZXhwIjoxNDY4MDYwNjI5fQ..B8PisW3mwnS51goa.Lz87.v_ydEDJ9ypa2kiiUbe"
}
```

### Account Routes
#### Overview

| Method | URL                     | What to do                               | success |
| ------ | ----------------------- | ---------------------------------------- | ------- |
| GET    | /api/v1/accounts/{uid}  | get all information about a certain user | 200     |

#### Example

**GET /api/v1/accounts/{uid}**

```shell
curl http://localhost:9292/api/v1/users/{uid} \
	-H 'content-type: application/json' \
	-H 'authorization: bearer {auth_token}'
```

```
{
  "data": [
    {
      "cid": 1,
      "name": "健康與人生"
    },
    {
      "cid": 2,
      "name": "作業系統 Operating Systems"
    },
    {
      "cid": 3,
      "name": "美容美髮"
    }
  ]
}
```

### File Routes
#### Overview

| Method  | URL                                           | What to do                                     |
| ------  | ----------------------------------------------| ---------------------------------------------- |
| POST    | /api/v1/accounts/{uid}/{course_id}/concepts/  | create new file(course concept) for the course |

#### Example

**POST /api/v1/accounts/:uid/:course_id/concepts/**

```shell
$ curl http://localhost:9292/api/v1/accounts/1/1/concepts/ \
 	-X POST \
	-H 'content-type: application/json' \
	-H 'authorization: bearer {auth_token}' \
	-d '{
    "document": "XXXXXXXXOOOOOOOO"
	}'
```

```
{
  "type": "concepts",
  "id": 1,
  "data": {
    "checksum": null,
    "document_base64": "abcdefghijklmopqustu",
    "document": "XXXXXXXXOOOOOOOO"
  }
}
```

## Install

Install this API by cloning the *relevant branch* and installing required gems:
```
$ bundle install
```

## Execute

Run this API by using:

```
$ rackup
```
