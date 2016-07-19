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
curl http://localhost:9292/api/v1/accounts/{uid} \
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
| POST    | /api/v1/accounts/{uid}/{course_id}/folders/  | create new folder(slide or subtitle) for the course |
| POST    | /api/v1/accounts/{uid}/{course_id}/folders/{folder_id}/files/  | create new file for folder |

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
**POST /api/v1/accounts/:uid/:course_id/folders/**

```shell
$ curl http://localhost:9292/api/v1/accounts/1/1/folders/ \
 	-X POST \
	-H 'content-type: application/json' \
	-H 'authorization: bearer {auth_token}' \
	-d '{
    "folder_url": "XXXXXXXXOOOOOOOO",
		"folder_type": "subtitle"
	}'
```

```
[
  {
    "type": "folder",
    "id": 1,
    "attributes": {
      "folder_type": "subtitle",
      "course_id": 1,
      "chapter_order": 1,
      "name": "物聯網概論課程簡介",
      "folder_url": "XXXXXXXXOOOOOOOO"
    }
  },
  {
    "type": "folder",
    "id": 2,
    "attributes": {
      "folder_type": "subtitle",
      "course_id": 1,
      "chapter_order": 2,
      "name": "第 1週: 物聯網基礎架構與應用簡介",
      "folder_url": "XXXXXXXXOOOOOOOO"
    }
  },
  {
    "type": "folder",
    "id": 3,
    "attributes": {
      "folder_type": "subtitle",
      "course_id": 1,
      "chapter_order": 3,
      "name": "第 2週: 感知層/網路層/應用層技術  ",
      "folder_url": "XXXXXXXXOOOOOOOO"
    }
  }
]
```

**POST /api/v1/accounts/:uid/:course_id/folders/:folder_id/files/**

```shell
$ curl http://localhost:9292/api/v1/accounts/1/1/folders/3/files/ \
 	-X POST \
	-H 'content-type: application/json' \
	-H 'authorization: bearer {auth_token}' \
	-d '{
    "filename": "1.txt",
		"document": "XXXXXXXXOOOOOOOO"
	}'
```

```
{
  "type": "files",
  "id": "978e09d4-5eb4-4b1c-a4a1-37cd6fbd6aa0",
  "data": {
    "folder_id": 3,
    "filename": "1.txt",
    "checksum": null,
    "document_base64": "MTExMTExMTExMTEx",
    "document": "111111111111"
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
