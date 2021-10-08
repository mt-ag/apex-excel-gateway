# Excel Gateway for Oracle APEX

No possibility to let your users access your APEX app? Consider using our Tool to handle that in a good and modern way.

Create your own Excel template(s) in APEX, email them to your recipient(s) and then upload the finished file.
Now you can check and correct the data. If everything is well, publish the data for further analysis, reports etc.


![prozess](https://i.ibb.co/XDkJ8hy/prozess.jpg)



**This github repository is for developers willing to contribute to the upcoming version of Excel Gateway for Oracle APEX**

## How to contribute as a developer to this project

1. Clone/fork the repository apex-excel-gateway to get your own copy.
2. Create a workspace with the ID 33850085021086653. For this you will
    need your own APEX environment.
3. Run /src/install_all_scratch.sql.    
    When prompted enter the parameters.    
    This will install all DB-Objects and the application with fixed ID
    445.    
    Make sure you have Application ID 445 free for this.
4. Make your changes in the app and/or db objects.
5. Commit your changes in your own branch.
    Preferable a dedicated branch for the feature you're working on.
6. Send in a pull request for review.    
    We will then verify the changes before accepting the pull request.    
    We might ask you to update your pull request based on our findings.

**Some important rules:**
1. Retain Workspace ID and Application ID, otherwise each and every file of the application export will be marked as changed.
Easiest way to achieve this is to use the provided development install script mentioned above.
2. Always enable "Export as ZIP" and "Export with Original IDs".

## Getting in touch

Send a DM on Twitter to [Timo Herwix (@therwix)](https://twitter.com/THerwix/) to get involved.
