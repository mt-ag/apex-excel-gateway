# Excel Gateway for Oracle APEX 

This github repository is for developers willing to contribute to the upcoming version of Excel Gateway for Oracle APEX.

Documentation
How to contribute as a developer to this project
Clone/fork the repository apex-excel-gateway to get your own copy.
Create a workspace with the ID 33850085021086653. For this you will need your own APEX environment.
Run /src/install_all_scratch.sql.
When prompted enter the parameters.
This will install all DB-Objects and the application with fixed ID 445.
Make sure you have Application ID 445 free for this.
Make your changes in the app and/or db objects.
Commit your changes in your own branch.
Preferable a dedicated branch for the feature you're working on.
Send in a pull request for review.
We will then verify the changes before accepting the pull request.
We might ask you to update your pull request based on our findings.
Some important rules:

Retain Workspace ID and Application ID, otherwise each and every file of the application export will be marked as changed.
Easiest way to achieve this is to use the provided development install script mentioned above.
Always enable "Export as ZIP" and "Export with Original IDs".
Getting in touch
Send a DM on Twitter to Timo Herwix (@therwix) to get involved.