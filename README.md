#DocHub :books:
An online Computer Science pdf documents sharing site built with Ruby on Rails.  

###Features:  
* Upload your documents from your local computer or online cloud storage
* Read,download and manage your documents  
* Comment and reply under each document  
* Add your favorite documents to your collection  
* Upvote or downvote a document
* Follow/Unfollow other users
* Post microposts and see others' microposts and doc feeds 
* Simple search by doc name
* Tabs 'zeroview','active','recent' to list docs in 3 scopes

###Configure and run:  
* Sign up and create an app at [filepicker's developer portal] (https://www.filepicker.com)  
* Copy the API Key and replace the one in config/application.rb:  
```bash
config.filepicker_rails.api_key = ""   
```

* Open the terminal in root directory folder:  
```bash
RUN 'bundle install' to install gems 
RUN 'rails s' to start the default WEBrick server 
(delete 'server.pid' file in tmp folder if port collides)  
```  
* Sign in with admin account:  
```bash
email: admin@gmail.com
password: dochub
```  
