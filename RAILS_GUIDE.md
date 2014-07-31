# README

This README would normally document whatever steps are necessary to get the
application up and running.

**Please, do this actions step by step and all will be right!**
* System dependencies
```bash
sudo apt-get install git postgresql-9.3 postgresql-server-dev-9.3 curl
```
* Database initialization
```bash
sudo service postgresql start
sudo su postgres
psql
```
```SQL
CREATE USER "smartbike" WITH PASSWORD 'smartbike_pwd';
ALTER USER "smartbike" CREATEDB;
\q
```
```bash
exit
```
* Ruby version. For more info look [here](https://rvm.io/)
```bash
echo progress-bar >> ~/.curlrc
curl -sSL https://get.rvm.io | bash -s stable
rvm install 2.1.1
rvm gemset use 2.1.1@smartbike --create
```
* Configuration
```bash
git clone git@github.com:7bits/bike-station.git
cd bike-station
rvm gemset use 2.1.1@smartbike
bundle
```
* Database creation
```bash
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```
* Run application
```bash
bundle exec rails s
```
* How to run the test suite
```bash
bundle exec rake db:create RAILS_ENV=test
bundle exec rake db:migrate RAILS_ENV=test
rspec spec/
```
* Create new deployment on heroku. Read more  [here](https://devcenter.heroku.com/articles/getting-started-with-rails4)
```bash
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
heroku login
cd bike-station
heroku create
git push heroku master
heroku open
```
* Deploy on exists heroku instance
```bash
git remote add heroku git@heroku.com:APPNAME.git
git push heroku master
```
