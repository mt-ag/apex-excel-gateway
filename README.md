# Excel Gateway for Oracle APEX

No possibility to let your users access your APEX app? Consider using our Tool to handle that in a good and modern way.

Create your own Excel template(s) in APEX, email them to your recipient(s) and then upload the finished file.  
Now you can check and correct the data. If everything is well, publish the data for further analysis, reports etc.
  
![Excel Gateway for Oracle APEX 3](https://user-images.githubusercontent.com/61868531/137738511-b92f2638-3f71-413f-a8d6-e4014375e0bc.jpg)
  
## Demo
https://apex.mt-ag.com/ords/mt_excel_gateway/r/mt_excel_gateway_demo

## Compability
- Oracle Application Express 21.1
- Oracle Database Express Edition 12c

## Installation
Run /src/install_all_scratch.sql.  
When prompted enter the parameters.    

This will install all DB-Objects and the application

## Deinstallation
Run /src/deinstall_objects.sql

## Getting Started

![1](https://user-images.githubusercontent.com/61868531/137754438-47ebd4b8-836f-4b8b-b20f-655c82aab4bf.JPG)

### 1. Create Template
#### First Step is to create a new Excel template.

![1 1](https://user-images.githubusercontent.com/61868531/137742216-778090fb-6712-4431-8664-6dab604a1c15.JPG)

1) Click "Create Template" and follow the wizard.
2) Give your Template an unique Name.
3) Optional you can enter a deadline which is needed to calculate when the application will send reminders.  
4) And optional too, you can enter a maximum number of rows which indicates how many rows are available to the editor.  

#### Second step is to add column headings to the template.  

![1 21](https://user-images.githubusercontent.com/61868531/137754872-922cdb40-70dd-48ef-b15a-c3e920a66c3b.jpg)

1) Drag and drop the titles from the left area (1) to the right (2).  
Use the up or down arrows to change the order.  
The title can be deleted with the recycle bin
3) If you need new titles, click "Add Header" (3) 

![1 3](https://user-images.githubusercontent.com/61868531/137885822-9b911807-cc3a-4e7e-8842-51c744129d07.JPG)

1) Enter the Name of the Title  
2) Enter the width for the column in your Excel Spreadsheet  
3) If the column in your table needs validation, choose one here (for example number, date, email...)  
4) If you want the column shows a dropdown list, enter the values here  

#### Next step is to add header-groups to the template (optional). 

![1 4](https://user-images.githubusercontent.com/61868531/137750291-d3f11533-a68d-4312-ace8-2ad34250e883.JPG)

Choose a heading group for each column that needs merge cells.  
If you need new header-groups, click on "Add Header-Group" and create a new one.  
For this you have to enter the name, background and font color.

#### The next step is to set the background and font color for the columns.  

![1 5](https://user-images.githubusercontent.com/61868531/137751600-ed97bf9c-509f-43c6-8b07-b3482b80ec86.JPG)

You can use the Color Picker for this.

#### In the last step, formulas or min/max values can be set for the validations

![1 6](https://user-images.githubusercontent.com/61868531/137886852-f1f65929-d207-4c23-b37e-8c2afb97ed01.JPG)

For number or date validations, use Formula 1 as the minimum and Formula 2 as the maximum value.  
If the validation is "Formula", enter the formula you need in Formula 1.  
Click "Show Columns/Info" for more details and examples.

#### Finally, you get an overview. Click "Save Template" to create.

![1 7](https://user-images.githubusercontent.com/61868531/137886880-c1e7a8fc-5f26-41c4-9431-fb7d572e3378.JPG)

### 2. Send Template

![2 1](https://user-images.githubusercontent.com/61868531/137870039-60e1ce0a-ceba-4aa7-9288-b2ea84684171.JPG)

First of all the template has to be selected (1).  
Next, person(s) need to be added (2). All person(s) involved in the process are listed in the grid (3).  

If you want to add person(s), click on "Add Person" and select the person(s) in the modal dialog.

![2 2](https://user-images.githubusercontent.com/61868531/137870944-e1181669-1175-415f-a603-53849304f99b.JPG)

Click "Add Person" to continue.  
Now all persons involved in the process are displayed and the template can be sent by email.  
To do this, a mailtype must be selected first.  

There are three different types:

1. Initial Mail - all templates that have not yet been sent and processed
2. Correction Mail - all templates where corrections must be made
3. Reminder Mail - all templates where the deadline has passed

![2 3](https://user-images.githubusercontent.com/61868531/137873185-06dc6610-c497-4479-a865-0082cb709ab7.JPG)

When a selection is made, the grid is always updated and only the affected recipients are displayed.  
For example, the initial email can be sent only once a time and a reminder can be sent only when the deadline is exceeded.  

So first select "Initial Mail" and then click "Send Mail" to send everyone the initial email with the selected template.  

All available emails can also be sent automatically.  
To do this, click on "Automations". The dialog shows how the status of the automation is and on which days it should be sent if the function is enabled.  

![2 4](https://user-images.githubusercontent.com/61868531/137875158-36d878cb-b774-405b-855d-9a3bb68e89dc.JPG)

### 3. Upload Template

After sending e-mails, the recipient must fill them out and send them back.  
To upload the finished template, navigate to "Upload template" in the navigation menu and click "Upload".  

![3 1](https://user-images.githubusercontent.com/61868531/137878019-07297b22-2dab-48a8-83f0-1624ca343fe2.JPG)

Note: If something should fail during the upload, you can check the error log to find out what the problem is.

### 4. Check Data

If the upload was successful, the data can be checked.  
To do this, navigate to "Check data" and select the one to be checked.

![4 1](https://user-images.githubusercontent.com/61868531/137879363-2ae0d1e3-d1fb-4b6e-b61f-64a7f4996591.JPG)

This example shows data without errors that were detected by the application via the previously defined validations.

![4 2](https://user-images.githubusercontent.com/61868531/137881197-c5283fdb-480d-4c5e-8b9b-d3bde9cd7913.JPG)

If incorrect data were detected by the application, this is displayed in the "Validation" column.  
For example, an incorrect email address was detected here.

![4 3](https://user-images.githubusercontent.com/61868531/137881555-ac21b834-1931-4d0f-a106-22c2aaf5c39b.JPG)

Now there are two options.
1. The incorrect data can be corrected directly in the application or 
2. a new excel file will be created in which all incorrect rows are listed. To create this, click "Provide Correction" and then sent it as a "Correction Mail" (Navigate to "Send Mail" and select the mailtype "Correction Mail").  

If everything is fine, the status can be set to "Completed".  
All the data that are "Completed" are available for export.

![4 4](https://user-images.githubusercontent.com/61868531/137884347-d0150415-78d0-41fb-8139-7f5a876d2495.JPG)

### 5. Publication / Export Data

All data are displayed here and are available for download.
Alternatively, interactive reporting can be done here.

![5 1](https://user-images.githubusercontent.com/61868531/137884668-14c9998e-57c8-4987-9242-59fe111fa70c.JPG)

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
