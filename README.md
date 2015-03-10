BCITBlurbBoard
=================

This is a project created by Matthew Banman, Alan Lai, Ben Soer, Ryan Sadio and Inderjeet Khangura

#Accessing GlobalAppData
GlobalAppData is implemented as a singleton and allows access to regularly needed data on all pages so as
to effectively communicate with the API. To access the GlobalAppData object create an instance of it by
calling its initialization method
````swift
let appData = GlobalAppData.getGlobalAppData();
````
Then you can access its content with the appropriate method call.
To get the user token call:
````swift
let token:String = appData.getUserToken();
````
To get the user type call:
````swift
let usertype:String = appData.getUserType();
````