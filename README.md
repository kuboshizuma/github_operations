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

For example, to remove those who don't have admin privileges from the repository, do as follows.

```
$ ruby remove_users_from_repo.rb
```
