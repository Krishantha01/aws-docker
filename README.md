# aws-docker

# What does my application do?

Get the local time from one of the docker containers and get current time from http://worldtimeapi.org/ and return the following values from an api.
* Container ‘s local time
* Current time
* Container Ip
* Container id


# How do I build it?

Step 01  
First I have created a python script to get the local time and get the current time from http://worldtimeapi.org/. 
And also created an api using flask to return those values.

Step 02
Create an ec2 instance from the AWS console and install docker on it.

Step 03
Create docker container and install the packages and services

Step 04
Deploy flask app with nginx

Step 05
Install aws cli in the docker container

Step 06
Create an image from the container and push it to the amazon ECR

Step 07
Create multiple containers using the image
 
Step 08
Create mail service ( if script detect any errors a mail will send to the support team)

Step 09
Configure logging mechanism

Step 10
Check the results by typing http://34.201.65.107:8083/ in your browser


***All the steps were described in the setup.docx file.





