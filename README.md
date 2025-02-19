# Program 2: Ruby on Rails

This repository contains the project structure for the Ruby on Rails project for booking movies.

**Members:** Moaad Benkaraache, Cole Bianco, Brian Huynh

The documentation for this project will primarily be covered in the [GitHub Wiki](https://github.ncsu.edu/bhhuynh/CSC_ECE517-Project2/wiki) pages and will be organizedthere instead of here in the README document. This will make it much
easier to organize and grade. However, basic requirements and procedures for setting up and running the program will still be documented below.

The link to access the website can be found here: https://rubymovieapp-production.up.railway.app/.

## Version Configurations

| Tool | Version |
| ---- | ------- |
| **Ruby Version:** | 3.4.0 |
| **Rails Version:** | 8.0.1 |
| **sqlite3 Version:** | 2.1 and above |

If you need assistance in installing Ruby on Rails, please refer to the [Ruby Installation Guide](https://guides.rubyonrails.org/v5.0/getting_started.html).

## Installation Guide

This project is fully stored on GitHub and can be freely cloned using the following command in a Git Bash terminal:

```bash
git clone https://github.ncsu.edu/bhhuynh/CSC_ECE517-Project2.git
```

Provided that you have the appropriate permissions, you can clone and pull from this repository.
After ensuring that all necessary files are present within the system, please install all the ruby
gems that are included in the `Gemfile`.

```bash
bundle update
bundle install
```

If there are issues with the installation of the bundle packages, please ensure that your Ruby version
matches the version being used for the project.

## Deployment

Running the following command will start the website server on localhost on port 3000 by default:

```bash
rails server
```

Running this will allow the developer to access the website at [localhost:3000](localhost:3000).


## Usage Guide

### Credentials for admin ###

```
username: admin
password: password
```

### Navigation ###

After logging into the admin account, you can use navigation links to view the admin profile,
all the users who have signed up, the movies list, and purchase history of all users.

**How to create a ticket as an admin**

1. Click *View All Movies*
2. Select a movie by clicking its title
3. Click *View Showtimes*
4. Select a show by clicking *View Show*
5. Click *Book Ticket*
6. Select *admin* for the user
7. Select a show
8. Click *Book Ticket*

**How to add credit card information as a non-admin user**
1. Click *View Profile*
2. Click *View Credit Cards*
3. Click *Add a new Credit Card*
4. Fill out the form (feel free to use any number such as 123)
5. Click *Add Credit Card*

**How to purchase a ticket as a non-admin user**

1. Click *View All Movies*
2. Select a movie by clicking its title
3. Click *View Showtimes*
4. Select a show by clicking *View Show*
5. Click *Book Ticket*
6. Select a credit card
7. Click *Book Ticket*
