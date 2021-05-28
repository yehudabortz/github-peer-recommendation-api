# Peer Recommendation API

Peer Recommendation allows users to nominate current and past co-workers and vouch for their employability. Nominations are anonymous. Everyone receives a score based on how many people have nominated them.

Peer Recommendation API is a Ruby on Rails back-end for the [Peer Recommendation Client](https://github.com/yehudabortz/github-peer-recommendation-client) React front-end.

- [Live Site](https://github-peer-recommendation-cli.herokuapp.com)
- [Demo Video](https://drive.google.com/file/d/1cUDQedVj2yXPEsOZB3OzbqbBG74X7qiI/view?usp=sharing)

## Installation

- Clone this repo.

- This repo uses ruby version 2.6.6 and Rails 6.1.3.1

```bash
rvm use 2.6.6
```

- Bundle Install all dependencies

```bash
bundle install
```

- Create a .env file in the root directory

```bash
touch .env
```

- Create your app secret for decoding JWT tokens.

```bash
SECRET_KEY_BASE=YOUR VERY SECURE PASSWORD
```

- Create a new OAuth app in your Google Developers account.

- In the .env file create your environment variables for GitHub OAuth

```bash
GOOGLE_CLIENT_ID=USE YOUR GOOGLE CLIENT ID
GOOGLE_CLIENT_SECRET=YOUR GOOGLE CLIENT SECRET HERE
```

Create a new Twilio Sendgrid account.

- In the .env file create your environment variables for Twilio SendGrid and your sender email.

```bash
SENDGRID_API_KEY=USE YOUR TWILIO Sendgrid API KEY
FROM_EMAIL_ADDRESS=EMAIL USED IN TWILIO SENDGRID ACCOUNT
DOMAIN=USE DOMAIN OF FRONT END i.e. http://localhost:3000
```

- Migrate the database

```bash
rails db:migrate
```

- Start the server on 4000 if you want to have the front end running on 3000.

```bash
rails server -p 4000
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
