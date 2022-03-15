# Excel Gateway for Oracle APEX

No possibility to let your users access your APEX app? Consider using our tool to handle that in a good and modern way.

Create your own Excel template(s) in APEX, email them to your recipient(s) and then upload the finished file.  
Now you can check and correct the data. If everything is well, publish the data for further analysis, reports etc.
  
![Excel Gateway for Oracle APEX 3](https://user-images.githubusercontent.com/61868531/137738511-b92f2638-3f71-413f-a8d6-e4014375e0bc.jpg)
  
## Requirement
- Oracle Application Express 21.1 (or higher)
- Oracle Database 12.2 (or higher)

## Installation
Go into the APEX workspace, where you like to install the "Excel Gateway for Oracle APEX" app and import the file "/src/apex/excel_gateway_for_oracle_apex.sql" as a database application.   

This will install all DB-Objects and the application

## Getting Started

![1](https://user-images.githubusercontent.com/61868531/158388621-117f39f3-7013-4689-b3a1-ac3ad7291d74.JPG)

### 1. Create Template
#### First step is to create a new Excel template

![2](https://user-images.githubusercontent.com/61868531/158390363-2ca35af0-162f-4f51-8c2b-f7ad26fdb326.JPG)

1) Click "Create Template" and follow the wizard
2) Give your template a unique name
3) Optional you can enter a deadline which is needed to calculate when the application will send reminders
4) You need a sheet protection to prevent various actions. Then choose a password for your workbook here
5) You can enter a maximum number of rows which indicates how many rows are available to the editor
6) Adopt specifications from existing templates

#### Second step is to add column headings to the template  

![3](https://user-images.githubusercontent.com/61868531/158390432-e067f5da-b2ac-4e63-8308-62e91f22fa6a.JPG)

1) Drag and drop the titles from the left area (1) to the right (2)  
Use the up or down arrows to change the order  
The title can be deleted with the recycle bin
3) If you need new titles, click "Add Header" (3) 

![4](https://user-images.githubusercontent.com/61868531/158390486-f2491b22-e7cb-47c0-ac75-cba5c8d29ccb.JPG)

1) Enter the name of the title  
2) Enter the width for the column in your Excel Spreadsheet  
3) If the column in your table needs validation, choose one here (for example number, date, email...)  
4) If you want the column shows a dropdown list, enter the values here  

#### Next step is to add header-groups to the template (optional) 

![5](https://user-images.githubusercontent.com/61868531/158390544-bcaa8461-b0cf-45de-947b-e32290beb517.JPG)

Choose a heading group for each column that needs merge cells  
If you need new header-groups, click on "Add Header-Group" and create a new one  
For this you have to enter the name, background and font color

#### The next step is to set the background and font color for the columns  

![6](https://user-images.githubusercontent.com/61868531/158390611-1e93d288-71e6-4065-b523-abc36b8518b7.JPG)

You can use the Color Picker for this

#### In the last step, formulas or min/max values can be set for the validations

![7](https://user-images.githubusercontent.com/61868531/158390655-bf8e9e59-8cb4-43b4-b699-7b5ae9b4fb10.JPG)

For number or date validations, use Formula 1 as the minimum and Formula 2 as the maximum value.  
If the validation is "Formula", enter the formula you need in Formula 1.  
Click "Show Columns/Info" for more details and examples.

#### Finally, you get an overview. 
Before you create the template you can download a preview file. To do this, click the "Preview" button. 
Everything is fine, click "Save Template" to create.

![8](https://user-images.githubusercontent.com/61868531/158390701-925b7fbd-b6f6-4e37-a443-9aeecdd27fc6.JPG)

### 2. Send Template

![9](https://user-images.githubusercontent.com/61868531/158390745-fde69f5d-b38b-47bc-9911-e13a18f08247.JPG)

First of all the template has to be selected (1).  
Next, person(s) need to be added (2). All person(s) involved in the process are listed in the grid (3).  

If you want to add person(s), click on "Add Person" and select the person(s) in the modal dialog.

![10](https://user-images.githubusercontent.com/61868531/158390803-6162606c-6cc9-4ddb-8985-f45c8b5b9f18.JPG)

Click "Add Person" to continue.  
Now all persons involved in the process are displayed and the template can be sent by email.  
To do this, a mailtype must be selected first.  

There are three different types:

1. Initial Mail - all templates that have not yet been sent and processed
2. Correction Mail - all templates where corrections must be made
3. Reminder Mail - all templates where the deadline has passed

![11](https://user-images.githubusercontent.com/61868531/158390850-65450540-074e-414b-be24-b7dff26b9a22.jpg)

When a selection is made, the grid is always updated and only the affected recipients are displayed.  
For example, the initial email can be sent only once a time and a reminder can be sent only when the deadline is exceeded.  

So first select "Initial Mail" and then click "Send Mail" to send everyone the initial email with the selected template.  

All available emails can also be sent automatically.  
To do this, click on "Automations". The dialog shows how the status of the automation is and on which days it should be sent if the function is enabled.  

![12](https://user-images.githubusercontent.com/61868531/158390879-dfc952cf-e170-43f9-8a0e-152cff955d00.jpg)

### 3. Upload Template

After sending e-mails, the recipient must fill them out and send them back.  
To upload the finished template, navigate to "Upload template" in the navigation menu and click "Upload".  

![13](https://user-images.githubusercontent.com/61868531/158390912-255b48fb-b7be-48d7-a5d9-3ebbe86673c5.jpg)

Note: If something should fail during the upload, you can check the error log to find out what the problem is.

### 4. Check Data

If the upload was successful, the data can be checked.  
To do this, navigate to "Check data" and select the one to be checked.

![14](https://user-images.githubusercontent.com/61868531/158390954-88d66c19-9e13-4a0d-9451-175092440cf2.JPG)

This example shows data without errors that were detected by the application via the previously defined validations.

![15](https://user-images.githubusercontent.com/61868531/158391001-f0a64cfb-9ec6-4f32-8eff-cf7928c38154.JPG)

If incorrect data were detected by the application, this is displayed in the "Validation" column.  
For example, an incorrect email address was detected here.

![16](https://user-images.githubusercontent.com/61868531/158391048-7c7e3bce-9fd9-4cb6-a266-4eddc6050a9b.JPG)

Now there are two options.
1. The incorrect data can be corrected directly in the application or 
2. a new excel file will be created in which all incorrect rows are listed. To create this, click "Provide Correction" and then sent it as a "Correction Mail" (navigate to "Send Mail" and select the mailtype "Correction Mail").  

If everything is fine, the status can be set to "Completed".  
All the data that are "Completed" are available for export.

![17](https://user-images.githubusercontent.com/61868531/158391097-ad97ed83-fbdc-4033-9ead-13ff17c939c1.jpg)

### 5. Publication / Export Data

All data are displayed here and are available for download.
Alternatively, interactive reporting can be done here.

![18](https://user-images.githubusercontent.com/61868531/158391129-d165f6ed-6606-4371-8fd5-ca6a28241a39.JPG)

## How to contribute as a developer to this project

**This github repository is for developers willing to contribute to the upcoming version of Excel Gateway for Oracle APEX**

1. Clone/fork the repository apex-excel-gateway to get your own copy.
2. Create a workspace with the ID 33850085021086653. For this you will
    need your own APEX environment.
3. Run /src/install_all_scratch_dev.sql.    
    When prompted enter the parameters.    
    This will install all DB-Objects and the application with fixed ID 445.    
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
