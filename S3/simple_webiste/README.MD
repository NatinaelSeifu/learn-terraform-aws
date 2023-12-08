## Creating a static website 

* In this I have created a static website using `S3` and `cloudfront`. S3 objects are private and cannot be accessed directly using `s3 endpoint` or `bucket domain name`.
* The recommended way to configure cloudfront with S3 is by using `OAC` or `Origin Access Control` which restricts to access to an Amazon S3 origin. 

* While configuring s3 to upload objects make sure to set its `content_type`. Otherwise when you access the distribution domain, the file of the default root object defined in cloudfront distribution configuration will start downloading.
* Enabling S3 Website configuration is not neccessary when using cloudfront OAC.