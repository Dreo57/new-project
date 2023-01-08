# new-project
procedure to deployment
deploy the s3 first, to be able to store the application codes
deploy the everything else except asg and launch template, this is because the load balancer and the database endpoints need to be updated inside the application code 
and this endpoint can be generated after they have been deployed
then deploy the asg and launch template with the userdata for both appserver and webserver.