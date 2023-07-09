## Decision Documentation

Check [v1.0 decision documentation](https://github.com/techgrounds/techgrounds-anj-dtmr/blob/main/000_cloud_project/v1.0/Documentation/05_decision_doc.md) for the first weeks.

- Why did you used this services?
- Write out your considerations and substantiate your decisions.
- Assumptions and improvements. 

July 3, 2023
Today I decide to focus on non-technical sides, as after I've read the v1.1 requirements. I don't know where to proceed anymore on my own project. I ask a network on how I can proceed to another version without forgetting or missing out any requirements from the old version. From there I follow the steps of the things I know and search for key terminologies that are unclear for me. I've made a draft planning for the next 3 weeks. Tomorrow I would like to ask question to my team mates and the learning coach (on q&a) on how to proceed smartly.

July 4, 2023
The v1.0 was working, but not according to the best practices. Today, I spent half day building a main.bicep where my modules are for the management side. It was a day full of learning about how my bicep templates can be connected to the modules using output and param. Because of limited time and low level of energy, I focused on deploying the database server, the sql database, as it seems less complicated than the new requirements for the web server.

I've chosen a SQL Database because it is dynamic and general-purpose.

July 5, 2023
It's a self-study day but I chose to be at Zoom with the AWS team. It's AWSome how the same the concepts are.

I focused on the database, found that I can use private endpoints to connect the vnets of the management server and web server. Half-way thru I need to work on converting the web network into modules at my main.bicep.

It was successfully deployed but I could not ping the server name from the management server.

I focused on DB yesterday and today, so that I can work on my modules next to it.

July 6, 2023
Chose to start on understanding what Application Gateway is.
No definite progress today.
