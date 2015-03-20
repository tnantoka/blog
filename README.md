[![Circle CI](https://circleci.com/gh/tnantoka/blog.svg?style=svg)](https://circleci.com/gh/tnantoka/blog)

[![Coverage Status](https://coveralls.io/repos/tnantoka/blog/badge.png?branch=master)](https://coveralls.io/r/tnantoka/blog?branch=master)

[![Code Climate](https://codeclimate.com/github/tnantoka/blog/badges/gpa.svg)](https://codeclimate.com/github/tnantoka/blog)

```
$ rails c
> User.new(email: 'test', password: 'pass', password_confirmation: 'pass').save(validate: false)
```

```
# .env
BLOG_DATABASE_USERNAME=""
BLOG_DATABASE_PASSWORD=""
BLOG_DATABASE_SOCKET="/path/to/mysql.sock"
SECRET_KEY_BASE=""
DEVISE_SECRET_KEY=""
GITHUB_KEY=""
GITHUB_SECRET=""
```

```
# .env
DEPLOY_BRANCH=""
DEPLOY_TO=""
DEPLOY_HOST=""
DEPLOY_USER=""
$ cap production deploy
```

