# Exercise 2:
# ● Create a new script.
# ● Use user input to ask for their information (first name, last name, job title, company).
# Store the information in a dictionary.
# ● Write the information to a csv file (comma-separated values). The data should not be
# overwritten when you run the script multiple times.

from csv import *

user_info = {}

first_name = input("First name: ")
last_name = input("Last name: ")
job_title = input("Job title: ")
company_name = input("Company: ")

user_info['First name'] = first_name
user_info['Last name'] = last_name
user_info['Job title'] = job_title
user_info['Company'] = company_name

print(user_info)


with open('08_user_data.csv', mode='a') as csv_file:
    fieldnames = ['First name', 'Last name', 'Job title', 'Company']
    writer = DictWriter(csv_file, fieldnames)
    writer.writerow(user_info)

    csv_file.close()
