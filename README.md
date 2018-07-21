# github_operations

This repository is intended to perform operations for github's specific repository.

## requirements

- Ruby: 2.5.1
- dotenv: 2.2.1
- octkit: 4.8.0

## hot to use

### 1. setting

First, you should make file `.env` for some environment value.

```
$ cp dot.env .env
```

Next, fill values in the corresponding place like the following.
Note that you need to get `github access token` (with authority to have full control of private repositories) before that .

```
GITHUB_ACCESS_TOKEN=390ergivdfbik9verjg9v9fdikvifdjbf (your github access token)
OWNER_NAME=kuboshizuma (your github name)
REPO_NAME=kuboshizuma/github_operations (target repository name)
```

### 2. execute script

#### add users from csv

To add users from csv, you need to prepare csv file for users' github id.
The csv file should be like the following, which needs to include "github' column.

```
name,github
test,github_id
test1,github_id_1
test2,github_id_2
test3,github_id_3
test4,github_id_4
```

After placing the csv file to `data/users.csv`, do as follows.

```
$ ruby add_users_from_csv.rb users.csv
```

#### remove users except admin permission users

To remove those who don't have admin privileges from the repository, do as follows.

```
$ ruby remove_users_from_repo.rb
```
