# Boston University's Metropolitan College
## CS665 Assignment Class Project:

### met-cs665-assignment-project-gchriswill

---
## ⚠️ IMPORTANT NOTES FOR CLASS PROJECT (FINAL ASSIGNMENT) ⚠️ :

Please note that the Delegation Design Pattern is applied to the  
`feature/delegation` branch only. The `master` branch only contains the raw  
project without the manual application of the pattern. This approach will help  
to preserve the full state of a raw mobile app that was implemented without any  
pattern in mind, and also, will help the reviewer to review the technique by  
having available a branch diff between the raw and applied pattern versions.  
Therefore, in order to review the applied delegation pattern, the reviewer will  
need to checkout the `feature/delegation` branch and proceed with the review  
accordingly.

Also, please note that the main implementation and approach information for the  
project is located in the IMPLEMENTATION_DESCRIPTION.md file.

## Repository:

This repo holds the source code of the met-cs665-assignment-project-gchriswill project for
[Christopher W. Gonzalez Melendez]'s MET-CS 665 "Software Design and Patterns" class of the  
Software Development Master's degree at Boston University's Metropolitan College.

The purposes of this repo are:

- Provide versioning control features to the project.
- Providing commit history/changelog of the project, for its evaluation by the instructor.
- Use Github's Project, Issues, WIKI and repository management tools.
- Host all the source code remotely on Github as the `remote` repository host.

---

# Project Info:

**Term:** Spring-O2, 2021  
**Project:** met-cs665-assignment-project-gchriswill  
**Instructor:** [Kia Teymourian](http://www.teymourian.de)  
**Facilitator:** Sudakar Sundararajan  
**Institution:** [Boston University's Metropolitan College](https://www.bu.edu/met/)  
**Course:** [CS665 - Software Design and Patterns](http://www.bu.edu/csmet/academic-programs/courses/cs665/)  
**Program:** [Software Development M.Sc. (MSSD)](https://www.bu.edu/met/degrees-certificates/ms-software-development/)  
**Student/Engineer/Developer:** Christopher W. Gonzalez Melendez, D.K.A. "[@gchriswill](https://github.com/gchriswill)"

### IDE Platforms:

- [Xcode 12](https://developer.apple.com/xcode/)

### CI/CD Platforms:

- Travis CI

### Development Devices:

- MacBook Pro (15 Inch, 2017)
- iOS 14 Simulator
- iPhone 12

---

# Project Description

The class project is based on a simple iOS mobile app that allows users to  
create, read, update and delete "CRUD" profiles with minimal information and
display all profiles in a list in the main screen. It uses native and
integrated frameworks that are bundled with "Cocoa Touch" (the main framework  
for iOS development.

### Application Requirements:

- User must be able to create a profile
- user must be able to edit a profile
- User must be able to delete a profile
- User must be able to display a profile and it's containing values
- User must be able to see a list of all saved profiles

### Assumptions

- Saving profiles uses the simplest storage available, "UserDefaults".  
- No additional confirmation is needed for performing a transaction.
- User can also delete a profile by swiping the profile row.
- user can delete all the profiles at once.
- A profile is constructed with username, name, last name and email values
- Any of the profile's values can't be empty at profile creation time
- All profile's values needs to be at least 2 characters in length
- All profile's values can't begin with a number at profile creation time
- The username is the only value that can't be edited
- The username serves as a username and also as an identifier
- The username is the only value that has an 6 character length requirement
- The username can't contain any special characters (Symbols, punctuation)
- The name and last name can't contain any Symbols
- The email needs to contains 1 "@" symbol character as a requirement

### Expected MVP Feature Set:

- Create profile
- Update profile
- Display profile
- Display all profiles as list in a table
- Delete a single profile via swipe interaction
- Delete a single profile via button interaction
- Delete all the profiles via button interaction
- Delete all the profiles via button performs with an table animation
- Save profiles created and updated to device simplest storage available

---

# How to `Compile` the project

In order to compile, Xcode is the only required tool. Xcode can be download  
from the following official sources:  

- [Mac App Store](https://apps.apple.com/us/app/xcode/id497799835?mt=12)
- [Apple's Developer website](https://developer.apple.com/download/more/).

After the download is completed, open the Xcode app located in your  
applications folder (If you downloaded it from Apple's website then move it  
to the applications folder). Xcode will start downloading additional tools.

When the additional tools download process gets completed, go to the repository  
and double click the `SwiftDelegation.xcodeproj` project file.

# How to `Run`

While Xcode is open with the `SwiftDelegation.xcodeproj` project, select the  
iPhone 12 simulator on the top left device selection dropdown list. After  
selecting the simulator, just hit the run/play button located in the top left  
window of Xcode. Done!

# Running the `Test` target

Very similar to running the project, in the top left window of Xcode, click  
and hold the run/play button and a tool-tip context popup with rise with more  
options. Move the mouse pointer to the `Test` option while holding and then  
release it. Done!

# IMPORTANT NOTES
Xcode has integrated several **FREE** tools for "finding bug" and/or "checking style"  
tools for iOS development with Swift. This project has already all these  
configurations manually set in the project scheme `SwiftDelegation` and project settings.  
Github actions/workflows were disabled as I couldn't find a **FREE** official service  
for CI/CD integrated in Github marketplace, and also I didn't had enough time   
to create my own. So, the only external CI/CD service found was Travis CI.  
A brief description is provided in the presentation to be submitted.

The Swift code written in this project **STRONGLY** follows the official  
Swift Code style and guidelines, and also, the app conforms with Apple's Human  
Interface Guidelines.
