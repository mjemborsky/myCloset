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

#60 - US: As a user, I want to be able to export my finished collage so that an image saved to my photos.
- Tested by: Selecting 4 items and creating a collage. Click the “Post” button. A message pops up informing the user that the image is saved to their cameral roll and posted to their feed. The image then appears in the cameral roll. 
- Tested by: Selecting 4 items, creating a collage. Click “post”. The collage image is not saved to the camera roll because the user has not allowed the app to access their camera roll in their privacy settings. 

#28 - US: As a user, If I forget my password, I woould like to recieve an email with a possible solution.
- Tested by: Entering a user email that is already registered with myCloset. (An email with password reset instructions are sent to that email address).
- Tested by: Entering a user email that is not registered with myCloset. (An email is not sent to the inputted email address).

#61 - US: As a user, I want to be able to post may outfits to my profile page where I can view them later and so they can be seen by other users.
- Tested by: Creating a collage by selecting four items, and clicking “yes” to build outfit. Clicked “post” on the saveOutfitView page. A message appears saying the collage was saved to the user’s camera roll. The user is taken to the feed view. Once there, the user clicks on the side pull menu, and clicks “profile”. The user is taken to the profile view, where their saved collage will appear.
- Tested by: Create a collage by selecting four items, and clicking “yes” to build outfit. Click “post” on the Your Outfit collage page. An error message appears with the appropriate error as to why the photo could not be posted. The image is not posted to the feed, saved to the camera roll or saved to the user’s profile. 

#7 - US: As a user, I want to see and scroll through a list of posts on my home feed so that I can view other user's posts.
Tested by: User opens the app, and logs in. The user is then taken to the feed view where they can scroll through other user’s collage outfit posts.
Tested by: The user opens the app and logs in. The user is shown a blank screen indicating the feed view is not drawing from the database correctly, or there are no user posts to see. 

#42 - US: As a user, I want to be able to be able to like and save other user's posts so I can interact with their completed outfits.
- Tested by: The user opens their app to the feed view. The user then scrolls until they find a post they want to like. The user hits the “like” button. The post is then saved as liked. The number of likes on the post will increase by 1. The like is added to the database, and upon refresh, the like count of the post will be incremented by one.
- Tested by: The user created an outfit collage. The user clicks “post”. Their outfit collage is posted to the feed. Other users like their post by clicking “like” button.
- Tested by: The user opens their app to the feed view. The user then scrolls until they find a post they want to save. The user hits the “save” icon. The post is then marked as saved. The saved indicator will marked as saved. The save is added to the database, and upon refresh, the post will continue to be displayed as saved.

#59 - US: As a user, I want to be able to navigate through the app using the tap bar and by scrolling, so that I may view and access all app functions.
- Tested by: The user will open up the app, and be taken to the feed view. To build an outfit, the user will pull out the sidebar and go to the closet page. The user can then pull out the sidebar to return to the feed page.
- Tested by: The user will open up the app, and be taken to the feed view. To view their profile, the user will pull out the sidebar and go to the profile page. The user can then pull out the sidebar to return to the feed page.
- Tested by: The user opens the app to the feed page. The user then decides to go to the closet to build outfit. The user pulls out the side bar and clicks on their closet page. The app displays all clothing items that the user has uploaded.
