## Importing resource

Sometimes `.tfstate` file might deleted unforunately. even though its hard to recovere it we can import a deplyoed resource to our tfstate and manage it with tf. Importing resource to a terraform state can be done in two ways.
- the first might be using cmd line. for this case i can import an s3 bucket to my tf state
`terraform import aws_s3_bucket.bucket bucket-name` in my case `terraform import aws_s3_bucket.myterr-s3-bucket-00 myterr-s3-bucket-01`

- second option might be adding an `import.tf` file and use this syntax.
---


```import {
    to = aws_s3_bucket.bucket
    id = "bucket-name"
}```

* with such kind i can import the s3 bucket. again in my case

```import {
    to = aws_s3_bucket.myterr-s3-bucket-00
    id = "myterr-s3-bucket-01"
}``` 
