# Rapid Health

A health based application made with flutter alone. The backend for the application is local *(this is the first time I have done something like this)* although the interfaces which the `widgets` and `bloc` can be extended to fit any type of backened needed

## Getting Started
- Download the application **APK** from [releases](https://github.com/Sid911/rapid-health/releases) Page.
- Install the application (make sure to be developer on your device)
- Login or Make a new User or Doctor

  Note : guest accounts exists whenever you open the application for getting a very basic application enviroment running.
  So you don't have to create new accounts in order to test out features like `Chat` and `Posts` bookings etc.
```
  
  Patient:
    email: guestpatient@dev.com
    password: guest
  
  Doctor:
    email: guestdoctor@dev.com
    password: guest
```
- Explore! Currently the application supports 
  - Making Posts as Doctor
  - Reviews as Patient
  - Chat System
  - Bookings
  - Location system for using google maps etc.
## What were the things I couldn't add ?
- **IMAGES** : the biggest problem with local server is actually the ability to use images, copying every image to post, review, chat etc. would have been a very difficult and mundane task to do.
- **Notifications** : I just didn't have the need to figure this out in a local Server 🤷‍♂️ ... I mean you can't really see the other side of the message till you log into it.

## What did my todo look like?
Just as an extra I use obsidian app to make todos which is basically `markdown` so I can just copy paste it here 😋

### Complete the Rapid Health App

  > Start Date : 18/05/22
  > 
  > Deadline : 8/06

  ```txt
  # = Days Used
  X = Days didn't work on
  * = Days till actual deadline 

  TimeLeft = [ # # # X X X # # # X X X # # # # # x x # # * ]
  [may]        18  20  22  24  26  28  30  1   3   5   7 8   [june]
  ```

  #### Features
  - [x] Complete Registration Process
  - [x] Complete Setup Page
    - [x] Generate Random Data
    - [x] Location Permission
  - [x] Figure out implementing Service offering
  - [x] Homepage Animation
  - [x] Auth Service
  - [x] Login Page
    - [x] Login Card
    - [x] Login Animation
    - [x] Registration Page
    - [x] Registration Intro animation
  - [x]  Booking Mini Card
    - [x] Patient
    - [x] Doctor
  - [x] Bookings Page
  - [x]  Bookings Service
  - [x] Posts Service
  - [x] Post Creations 
  - [x] and view?
  - [x] Google Maps Support
    - [x]  Style map
    - [x] Location Selection
  - [x] Permission handling 
  - [x] Reviews Service
  - [x] Ability to post Review
  - [x] Reviews Page
  - [x] Chat Page
    - [x]  Chat Service
    - [ ] Notifications? Maybe
  - [x] Search Page
    - [x] Search Widget
    - [x] Search Implementation
    - [x] Search Service
  - [x] Complete Home Page 
    - [x] Figure out icons for the categories
    - [x] Figure out Search
    - [x] Filters in search
  - [ ] Complete Settings Page
