# Quiz 2 Question 1
# Question: Register an application with the Github API here https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories (hint: this is the url you want 
# "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. 
# What time was it created? This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
# You may also need to run the code in the base R package and not R studio.

#based on the code https://github.com/hadley/httr/blob/master/demo/oauth2-github.r

#load the httr and jsonlite libraries
library(httr)
library(jsonlite)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications;
#    Use any URL you would like for the homepage URL (http://github.com is fine)
#    and http://localhost:1410 as the callback urlgit
#
#    Insert your client ID and secret below - if secret is omitted, it will
#    look it up in the GITHUB_CONSUMER_SECRET environmental variable.
myapp <- oauth_app("GettingAndCleaningDataQuiz", "YOUR_APP_KEY", "YOUR_APP_SECRET")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
res = GET("https://api.github.com/users/jtleek/repos", gtoken)
json1 = content(res)
#parse the json content into a json object
json2 = jsonlite::fromJSON(toJSON(json1))
#print out the datasharing repo created_at cell
print(json2[json2$name=='datasharing',grep("created_at", colnames(json2))])