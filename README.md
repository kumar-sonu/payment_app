# Payment App

## Some useful docker commands
* `docker-compose up --build`
* `docker-compose exec server bash -c "bundle exec rails db:create"`
* `docker-compose exec server bash -c "bundle exec rails db:migrate"`

Check out the complete list of commands in the [Docker documentation](https://docs.docker.com/engine/reference/commandline/docker/)

## Creating users (admin/merchant)
To create users you can run `docker-compose exec server bash -c "bundle exec rake db:create_users"`.
It uses a CSV file `user_data.csv` you can edit it to create users of you choice.

## Authorizing user and getting token
<img src="readme_images/user_authentication_success.png" height="280">

### Some checks while user authentication
1. If we can not find user with give params
<img src="readme_images/user_auth_fail1.png" height="280">

2. If email or password is invalid
<img src="readme_images/user_auth_fail2.png" height="280">

3. If user is not an active merchant
<img src="readme_images/user_auth_fail3.png" height="280">

## Creating different type of transactions

* **Base Transaction**<br>
<img src="readme_images/create_base_transaction.png" height="400">

* **Authorized Transaction**<br>
<img src="readme_images/authorize_transaction.png" height="400">

* **Charged Transaction**<br>
<img src="readme_images/charge_transaction.png" height="400">

* **Reversed Transaction**<br>
<img src="readme_images/reversal_transaction.png" height="400">

* **Refunded Transaction**<br>
<img src="readme_images/refund_transaction.png" height="400">
