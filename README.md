[![Circle CI](https://circleci.com/gh/tnantoka/blog.svg?style=svg)](https://circleci.com/gh/tnantoka/blog)

[![Coverage Status](https://coveralls.io/repos/tnantoka/blog/badge.png?branch=master)](https://coveralls.io/r/tnantoka/blog?branch=master)

[![Code Climate](https://codeclimate.com/github/tnantoka/blog/badges/gpa.svg)](https://codeclimate.com/github/tnantoka/blog)

```
$ rails c
> User.new(email: 'test', password: 'pass', password_confirmation: 'pass').save(validate: false)
```

```
# ENV
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

```
# config/settings.local.yml
site:
  title: 'Title'
copyright:
  label: '&copy; 2014 name'
  url: 'http://example.com/'
footer_links:
  - label_ruby: "t('.feed')"
    url_ruby: 'posts_path(format: :atom)'
  - label: 'Special Thanks'
    url_ruby: 'main_app.thanks_path'
exception_notification:
  prefix: '[Blog] '
  sender: '"notifier" <notifier@example.com>'
  recipients: 
    - 'recipient@example.com'
tweet:
  prefix: 'New post'
  suffix: '@tnantoka'
```
