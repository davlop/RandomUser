# RandomUser
RandomUser is an app that displays a list of randomized users on the screen. Users of the app may also see the details of each user displayed.

## Screenshots
<img width="430" alt="Screenshot 2022-09-26 at 16 47 40" src="https://user-images.githubusercontent.com/20024431/192308528-33145fab-d5e1-4754-8d08-18bfaac4a5c1.png">
<img width="435" alt="Screenshot 2022-09-26 at 16 47 52" src="https://user-images.githubusercontent.com/20024431/192308553-0cefda6a-07ba-4454-80e7-ddcb66193f8d.png">
<img width="433" alt="Screenshot 2022-09-26 at 16 48 03" src="https://user-images.githubusercontent.com/20024431/192308707-8f50d465-a8a0-4812-8ad6-6f829b55a3fc.png">
<img width="435" alt="Screenshot 2022-09-26 at 12 48 21" src="https://user-images.githubusercontent.com/20024431/192308720-1d93d2bb-9827-4c9e-a297-3060b40ca9c3.png">

## Features
- [x] Fetch list of random users from RandomUserAPI
- [x] Display list of users in a list with their image, first name, and last name
- [x] Obtain users' images remotely
- [x] When tapped, display the user's details on a separate screen

## Additional Features
- [x] Add endless scrolling - pagination from the API
- [x] Show option to retry in case there is any error with the network calls
- [x] Implement option to save, reuse, and clear the seed
- [x] Avatar images are locally cached

## Features that may be implemented in the future
- [ ] Flags of each country instead of general icon
- [ ] Option to show/hide the password
- [ ] Support for landscape mode
- [ ] Long names are not fully shown in the list screen - number of lines is 1
- [ ] Avatar images to have oval shape
- [ ] Links to email and phone fields to send emails and calls from the app
- [ ] Redesign UI to have card-format
- [ ] ....

## Architecture of the app
The app follows a Model-View-Controller architecture. It is a simple architecture that suits well for this small app. It has good separation of concerns and does not allow for huge view controllers. 

The views do not include any logic, they are purely responsible for the UI. 

The necessary logic is provided by the view controllers. These are also responsible for when the network calls are made, what the state of the UI is (loading, error, or successfully fetched list of users), tap events, and navigation.

The network calls are separated in a network layer. It can be extended to allow for any type of service and method. Each case would create a different service. In this case, we only have one - RandomUserService, but we could have multiple.

The app makes use of UserDefaults to save, reuse, and clear the seed.

The avatar images are cached using an NSCache, which is simple enough for this case. The ImageCache file follows a singleton pattern. Ideally, we would inject the instance into the necessary dependencies. However, this is a small app, so this solution is simple enough and not overkill.

The app follows SOLID principles as possible. The code is reusable and extendible. It is divided as needed and the classes try to have a single responsability. Abstraction is used as needed.

## Project structure
Since the app follows an MVC architecture, the project files are divided into three groups: model, view, and viewcontroller
### Model
- Utils: this contains extensions to Swift's classes and constants
- Domain: includes all the model objects for the app - User, Login, Picture... These are also used during the parsing of network responses
- Network: all the necessary files to perform network requests. These files may be common to any service and use case. The cache of the images is also included here
- RandomUserDefauts: wrapper of UserDefaults to handle the seeds
### View
All the views used in the app are added here
- UserCell
- UserView
- UserDetailsView
- ImageTextView
### View Controllers
Since the app has two screens, there are two view controllers here
- UserListViewController
- UserDetailsViewController
