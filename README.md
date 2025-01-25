
# GiveAway

This App Helps you to list all ongoing Giveaways through different platforms, in order to keep you updated with all the giveways 

## Getting Started 
1- Make sure you have xcode version 14.2 or above

2- you need to have basic knowledge of combine or how reactive Programming works
## Architecture
GiveAway project is build with Clean Architecture following Architecture pattern MVVM
## Structure
for Each  screen we have we might have use case if there is a buissness logic that neeed implementation 

as you can see
For Example:
in Domain we have:
HomeUseCase which applies HomeUseCaseContract

for presentation
we seperate 2 folders 
view and ViewModel

in Utils
we have our generic network Layer using package Alamofire
and also we have our request Builder to help us build request with all its queries if needed


## Third Parties



1. Role of Alamofire
Alamofire provides a powerful and efficient HTTP networking layer with features like:
URL Session abstraction for easy request handling.
Built-in support for tasks like JSON encoding, multipart uploads, and download progress tracking.
Enhanced debugging tools for HTTP requests and responses.

2. Role of Moya
Moya sits on top of Alamofire to simplify API management by:
Enforcing clean and declarative API endpoint definitions.
Reducing boilerplate code by handling repetitive tasks like parameter encoding and request setup.
Supporting advanced features like plugins for request logging, network activity indicators, and token injection.