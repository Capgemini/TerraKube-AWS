{
  "Version": "2012-10-17",
  "Id": "key-default-1",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
        "${arn}",
        "${masterarn}",
        "${rootarn}"
        ]
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
