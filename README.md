# myCloset

Created by...
- Jonah Gloss - Implementing the login/signup pages and functionality.
- Michael Emborsky - Implementing the search and feed components.
- Alexa Rodriguez - Implementing the createCloset component, creating required style tags, and importing pictures.
- Taylor McMillon - Implementing the createOutfit component, as well as posting it to the PostDatabase
- Ryan Lounsbury - Implementing functionality to upload clothing items, and creating the closet page framework.

Instructions (Building/Running the Project): 
- User Interfaces will be created using SwiftUI Files. The file should be named (The page name) + view. (ex. LoginPageView)
- Interactable elements regarding the View files will be coded in a controller file. (ex. the code for controlling what the login page actually does (LoginPageController))
- Data classes can be stored in a seperate file/files. Whatever is convienent to programmer.
- Code requested to be merged into main must be at the very least able to be compiled/ran. (Will be checked by lead dev.)


TESTING:

#57 - US: As a user, I want to be able to create an account, so that I can save my data and access it from other devices.
- Tested by: Inputting a valid email address and passwords that match. "Account created successfully!" popped up.
- Tested by: Inputting a valid email address and passwords that don't match. "Passwords do not match!" popped up.

#9 - US: As a user, I want to log in with email and password so that I can access my account and closet data.
- Tested by: Inputting a valid email (an email used to sign up) and valid password. Took me to the home page.
- Tested by: Inputting an invalid email (email that was not used to sign up) and invalid password. Does not let me login.

#8 - US: As a user, I want to be able to upload a photo of my clothing item, so that it is available in my closet to be used.
- Tested by: Tapping "select a photo", selecting the photo I would like to upload, then pressing "upload photo." A success message popped up and we can see the photo in the database.

#12 - US: As a user, I want to be able to create my own outfit collages. 
- Tested By: Selecting more than 4 pictures to put into the collage. Gave me an error message that reads "Too many items chosen! Select up to four items to build your outfit!”. When “okay” is clicked the user is able to unselect items. 
- Tested by: Selecting 4 closet items, and clicking ‘done” and then “yes” when asked if I want to build the outfit. I was then taken to a new page that displayed the four chosen items in a collage. I could then save or post the collage to my profile. 
- Tested by: Selecting 4 closet items, and clicking ‘done” and then “yes” when asked if I want to build the outfit. I then decided I changed my mind and wanted to switch out one of the items. I clicked “cancel’ and was taken back to the closet page, where I could re-select my items. 

#11 -  US: As a user, I want to be able to categorize and tag my uploaded items, so that they are organized in my closet. 
- Tested by: Clicking the plus sign on the closet page. A pop-up screen comes up with an “select a photo” button and a text box. When I click “select a photo’, I am able to chose an item from my camera roll to import into my closet. I can then add a tag to the photo, that will be stored in firebase, by typing one in the text field. When click “upload photo” the photo appears in my closet. 
