# Detection, response and analysis

## Key terminology

- [ ] Detection, response and analysis
- [ ] social engineering
- [ ] malicious software (malware)
- [ ] Intrusion detection systems (IDS)
- [ ] intrusion prevention systems (IPS)
- [ ] Recovery Point Objective (RPO)
- [ ] Recovery Time Objective (RTO)
- [ ] Hack response strategies
- [ ] The concept of systems hardening
- [ ] Different types of disaster recovery options

## Opdrachten

- [x] A Company makes daily backups of their database. The database is automatically recovered when a failure happens using the most recent available backup. The recovery happens on a different physical machine than the original database, and the entire process takes about 15 minutes. What is the RPO of the database?

1. We should define what the RPO of the database is. RPO is a measure of how much data a company is willing to lose in the event of failure. Using RPO we should specify the point in time to which data must be recovered.

2. In the case since the company backups of their database daily. The point in time to which data must be recovered should be 24 hours. The company decided that in an attack, they are willing to lose a maximum 1 day worth of resources, having to calculate the difference between the backups scheduling.

3. Analysing more the case, I could not find a way of how detection, response, and analysis are directly necessary because there is no attack requiring the security implementation at the first place. I see this as prevention of the future attacks rather.

- [x] An automatic failover to a backup web server has been configured for a website Because the backup has to be powered on first and has to pull the newest version of the website from GitHub, the process takes about 8 minutes. What is the RTO of the website?

1. Again we should first define what RTO of the website is. Recovery Time Objective is the maximum time allowed to recover a system or service after an outage or disaster. In this case, the RTO of the website is 8 minutes. This means that the website should be back up and running within 8 minutes after a failure of the primary web server.

2. The Incident: An automatic failover to a backup web server.

How did the team of this company detected the incident? We could imagine that the team use different tools like network monitoring software, system logs, and alerting systems that can detect abnormal behavior or a failure of a system.

3. The Response: The backup web server has been configured for a website

How and why did the team of this company chose this response? The team would, as quickly as possible, follow an already pre-defined procedures and protocols to restore the affected system or service to its normal operation. Tasks like, analyzing the root cause of the incident, implementing temporary fixes would be divided among the team, depending on the priority.

4. The Analysis: The process takes about 8 minutes

Why is it important to analize and document these kinds of incident? Evaluating the incident to determine what caused it, how it was detected, and what could be done to prevent similar incidents from happening in the future

## Sources list used for solving the exercise

- [Notes](https://drive.google.com/drive/folders/1ngTMmDk8hX61yQQGFieqFLswh6UdoEGO)

## Overcome challenges:

Short description of the challeges encountered, and how I solved them:

Issue 1: Asking better questions. Instead of writing and reporting this case study in a normal way with only sentences that directly answers the task. I formulate questions I have along the way and start from there.

## Results

For this week, I was able to finish all the tasks on time and even have time to review and dive deeper into the topics within and beyond the tasks. Here's how I am doing it:

1. Prioritize which of the tasks I can do with the team's availability and the task I can do on my own.
2. Write down the key terminologies.
3. Read and watch resources. But this time, I allow myself a time limit until when I can only do the reading and watching focusing on the key terminologies.
4. I schedule a time when I should focus on the tasks itself. When I should ask the teammates already and when not.
5. To retain what I am learning, I'm creating flashcards for myself and make sure I block a time to run through it in the mornings consistently.
