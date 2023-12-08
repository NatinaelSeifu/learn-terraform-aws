## Import
Importing from existing resource can be done using the `Import` command. after defining the id of the resource and resource type in the main or any terraform file that we want to we can use 
`tf plan -generate-config-out=filename.tf`. 
`filename.tf` is a file name for the imported resource configuration to be stored. you dont have to create it earlier. the command will create it for you.

Finally, Depending on your need you can select preferred configuration and move them into your main configuration files.