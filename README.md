# GitHub Peer Recommendation API

GitHub Peer Recommendation allows GitHub users to nominate other GitHub users and vouch for their employability. Nominations are anonymous. Once nominated, the nominated user will receive an email invite to claim their profile if they are not already a member. Everyone receives a score based on how many people have nominated them.

GitHub Peer Recommendation API is a Ruby on Rails back-end for the [GitHub Peer Recommendation Client](https://github.com/yehudabortz/github-peer-recommendation-client) React front-end.

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

- Create a new OAuth app in your GitHub account.

- In the .env file create your environment variables for GitHub OAuth

```bash
GITHUB_CLIENT_ID=USE YOUR GITHUB CLIENT ID
GITHUB_CLIENT_SECRET=YOUR GITHUB CLIENT SECRET HERE
```

Create a new GitHub personal access token in your GitHub account.

- In the .env file create your environment variables for GitHub access token.

```bash
GITHUB_ACCESS_TOKEN=USE YOUR GITHUB ACCESS TOKEN
```

- In the .env file create redirect variable for your GitHub callback URI.

```bash
REDIRECT_URI=http://localhost:3000/auth/github/callback
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
