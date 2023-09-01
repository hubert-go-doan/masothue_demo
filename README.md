# TAX CODE INFO
"Quickly look up personal and business information"
## Introduction
"This is a user-friendly, fast tax code lookup platform. Our user-friendly application is designed to provide you with quick and efficient access to both personal and business tax information. With taxcodeinfo, you can search for tax identification numbers quickly and conveniently, ensuring a smooth and seamless experience for all your tax-related needs."
## Description

"My application will have the following permissions:

System Administrator: This is the person who can log in to the system and perform the following operations on the system:

- Manage tax code information for all company and personal.
- Manage company, including adding, editing, and deleting businesses.
- Manage personal taxes.
- Manage Company type.
- Manage Business Area.
- Manage user contact forms.

For guest users: They can use the application without logging into the system. Users can easily search for information about company and personal right on the interface, and they can perform actions such as list, searching, filtering..., and send feedback."

## Technologies
To develop the TaxCodeInfo website, we utilize the following technologies:

- Programming language: Ruby, Javascript, SCSS.
- Framework: Rails 7 (Have used Turbo and Stimulus), Bootstrap.
- Database: PostgreSQL.
- Gem: Devise, pundit, rspec, bullet, simple_form, pagy, rubocop...
## DB Diagram
![image](https://github.com/hubert-go-doan/masothue_demo/assets/137854325/1d17d5d8-7715-4be8-a472-df5249fc4bf0)

## Setup environment
- Installing Ruby (version: 3.2.2)
- Installing Rails (version: 7.0.6)
- Installing PostgreSQL
## Usage
Step 1. Clone the repo
```sh
git clone git@github.com:hubert-go-doan/masothue_demo.git
```
Step 2: Run `bundle install` to install all denpendencies

Step 3: Config in config/database.yml

```sh
development:
  adapter: postgresql
  encoding: unicode
  database: myapp_development
  pool: 5
  username: myapp
  password: password
```
Step 4: Create database `rails db:create`

Step 5: Migrate database `rails db:migrate`

Step 6: Run `rails db:seed`

Step 7: Run `rails server`

## Contact
- Hubert Doan: hubert.doan.goldenowl@gmail.com
- Project Link: https://taxcode.onrender.com/



