# Excel Gateway for Oracle APEX

No possibility to let your users access your APEX app? Consider using our Tool to handle that in a good and modern way.

Create your own Excel template(s) in APEX, email them to your recipient(s) and then upload the finished file.  
Now you can check and correct the data. If everything is well, publish the data for further analysis, reports etc.
  
![Excel Gateway for Oracle APEX 3](https://user-images.githubusercontent.com/61868531/137738511-b92f2638-3f71-413f-a8d6-e4014375e0bc.jpg)
  
## Demo
https://apex.mt-ag.com/ords/mt_excel_gateway/r/mt_excel_gateway_demo

## Compability
- Oracle Application Express 20.2
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

![1 3](https://user-images.githubusercontent.com/61868531/137747998-c7763839-121f-4527-8def-ad536a69e87c.JPG)

1) Enter the Name of the Title  
2) Enter the width for the column in your Excel Spreadsheet  
3) If the column in your table needs validation, choose one here (for example number, date, email...)  
4) If you want the column shows a dropdown list, enter the values here  

#### Next step is to add header-groups to the template. 

![1 4](https://user-images.githubusercontent.com/61868531/137750291-d3f11533-a68d-4312-ace8-2ad34250e883.JPG)

Choose a heading group for each column that needs merge cells.  
If you need new header-groups, click on "Add Header-Group" and create a new one.  
For this you have to enter the name, background and font color.

#### The next step is to set the background and font color for the columns.  

![1 5](https://user-images.githubusercontent.com/61868531/137751600-ed97bf9c-509f-43c6-8b07-b3482b80ec86.JPG)

You can use the Color Picker for this.

#### In the last step, formulas or min/max values can be set for the validations

![1 6](https://user-images.githubusercontent.com/61868531/137752697-aacfa59f-bbd6-44ac-95f9-bbc035735872.JPG)

For number or date validations, use Formula 1 as the minimum and Formula 2 as the maximum value.  
If the validation is "Formula", enter the formula you need in Formula 1.  
Click "Show Columns/Info" for more details and examples.

#### Finally, you get an overview. Click "Save Template" to create.

![1 7](https://user-images.githubusercontent.com/61868531/137754043-84d6567a-8fb1-451e-b96b-30d2d0403c52.JPG)

### 2. Send Template

### 3. Upload Template

### 4. Check Data

### 5. Publication

## How to contribute as a developer to this project

**This github repository is for developers willing to contribute to the upcoming version of Excel Gateway for Oracle APEX**

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
