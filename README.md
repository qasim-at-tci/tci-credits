# POC for getting remaining credits on a Travis CI Free plan

# Development

>In the terminal:

1. Run ```git clone https://github.com/qasim-at-tci/tci-credits.git```
2. Make sure **ruby-3.1.1** is installed
3. Rename **.env-example** to **.env**
4. Get travis api token from https://app.travis-ci.com/account/preferences and add it to **.env** file
5. Run ```bundle install```
6. Run ```ruby request.rb```