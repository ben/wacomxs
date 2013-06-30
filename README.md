# Wacom expert settings tool

This is the source code to http://wacomxs.herokuapp.com.

## HOWTO: Get set up for development

1. Install git.
1. Install the [heroku toolbelt](https://toolbelt.herokuapp.com/).
1. Clone the repository locally:  
   `git clone https://github.com/ben/wacomxs`
1. Add heroku as a remote:  
   `heroku git:remote -a wacomxs`

## HOWTO: Add a tablet model

1. Edit [app/helpers/download_helper.rb](app/helpers/download_helper.rb), and add a line to the `tablet_models` array.
1. Commit and push back to GitHub.
1. Redeploy (see below).

## HOWTO: Deploy

1. Make sure you're added to the Heroku collaborator list (see below).
1. Make sure everything is committed.
1. `git push heroku master`

## HOWTO: Change collaborators

Check out [this guide](https://devcenter.heroku.com/articles/sharing).
Basically, someone already on the list has to run this command:

```sh
heroku sharing:add <email.address@example.com>
```
