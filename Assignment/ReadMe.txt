MyStopMonitor - FIT 3027 Monash University Major Assignment by Eddie Power (c) 2014.

GitHub repo: https://github.com/eddiePower/MyStop-UniAssignment/

This is my Public transport stop Monitoring application to help those people like me who fall asleep on the train, bus or tram and miss the stop they are meant to get off at. This will send you an alert before you arrive at the station. How is this different to the normal iPhone notification at location you ask, well this is built around the PTV or public transport Victoria network Victoria data so the train or stop locations are already in the app you just need to search or look through the list to select your desired stoping location.

References :
All code files located in ExtraResources folder and has appropriate copyright on each file from these users below ACPReminder - App in background Notification Banner. - https://github.com/antoniocasero/ACPReminder - Anton Iocasero

A custom class that provides notifications based on the localNotification class that can be fired in a matter of seconds rather then days, i used this to help alert the user when the application is closed. To keep with the train theme i set a sound of train crossing.

TDNotificationPanel - Green Bar In Application Banner. - https://github.com/tomdiggle/TDNotificationPanel - Tom Diggle

A custom class that provides a in application type notification which can consist of 3 colours and 3 different uses such as error, success and loading types. I chose to use this to help alert the user of an upcoming train station by using the success colour scheme.

Application Functions:

Build list of stations from the PTV api.
Lets users set alerts or alarms based on these stops
Alert's user if app is running and in foreground by a Green alert bar on top of view and a Pop up alert button.
Alert's user when running but in background by a custom notification in notification centre, the user must dismiss or touch this alert to stop the custom sound playing.
Notify's user if the app is not running due to region monitoring, it will then use the notification alert as if the app was not running.
Shows station information and maps.
Notes

Some errors that are encountered when running in iPhone simulator but not on actual device are

03:08:58.852 ERROR: AVAudioSessionUtilities.h:88: GetProperty_DefaultToZero: AudioSessionGetProperty ('disa') failed with error: '?ytp' - found to be simulator error to do with Speech Synthesiser by others on stackOverflow
Encountered a location manager issue when iPhone sim was not set to auto enable fake location data but fixed this with if statement to check if error detail is nil then chances are its probably a simulator issue
Other Logged messages include:
[ACPReminder.m:112] Local notification scheduled Message: Wake Up now Kananook Station is coming up next! - comes from added library for notification centre messages
Event was: You've Entered the Region Seaford Station at 2014-06-17 17:03:14 +0000 - My Events as user enters region area and alert is triggered.
Features to be Added & completed:

Check for new stations on API server - at this point as a new station development is a big and long process i will release a new update for users forcing apps to re download the list fresh for new stop updates, until i can check download list against stored list in a cpu and time efficient manner.
Set the map type globally in userDefaults so it is shown in station details as set in settings page of app.
Add in station information such as Mykey manned station (human to buy new myKey card from at station) and parking details for that station
Connect UIAlert views up to actions
Customise look of tableViews
Add Train Line Table View and logic selecting correct line numbers
Add Train Lines to Core Data Model
Add in sounds and set up logic for selection
Remove GPS coords from TableViews and Add MapSnapShot images of station view for train line stops
Have next 3 train times for station details from callout button - have other station specific related details from left callout button may be connecting bus route numbers.
Show Station myKey outlet details and parking availability near by from google search or PTV POI search.
load instruction info page on first run of application to help communicate instructions, updates and changes to the user by showing them how to interact with the application.
Add Twitter feed page with interruptions to service like metro times application.
Future Updates:

With new iterations of iOS coming out new features or API's will become available to work on and utilise from within this application, one which is coming up in IOS 8 is a family location sharing feature which will enable you to share you location with approved people for a set time period, I think this would be a great feature to take advantage of. For example: A student is on their way home from school in the evening they are going to be collected by a parent at the station near their home which normally involves picking up the phone and calling home well now we can make this app call home for us, with the app connecting from the school child's phone to the parents phone at a set location before the child reaches their stop. This will prevent a phone call, the child or person waiting around at the station possibly in an unsafe environment More modern UI that will take advantage of more or the iOS 7+ design principals. These and many more features to come so stay tuned....