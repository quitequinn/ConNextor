ConNextor
=========

### Description

ConNextor is a web platform to gather bright minds, spawn creativity and build projects. 
(add in more!!)

### Running this application

#### Prerequisites

You need the following installed, preferably on a Linux system. _The versions are what is used during core development, use other versions at your own risk._

* **Ruby**, version 2.1.5
* **PostgreSQL**, version 9.3.5

See `docs/` for stripped-down guides to install them.

#### Installation

```bash
git clone https://github.com/tlulu/ConNextor.git   # Clone this repository
cd ConNextor/                                      # Go to working directory
bundle install                                     # Installs the correct gems
rake db:migrate                                    # Import the database
rake db:seed                                       # Seed the database
rake test                                          # Run test suites
rails server                                       # Start the server
```

#### Configuration

See the `config/` folder to see configuration details and make changes as you need. `database.yml` is not version controlled, so configure it to local environment. 

Need some keys for OmniAuth. (will add later)

### Application Stack and Frameworks

* Frontend
 * [Sass](http://sass-lang.com/) with [Compass](http://compass-style.org/), which compiles to CSS3 (with [Rails Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html)); Helps produce more readable and dynamic code, and Compass helps align the frontend to modern design patterns
 * [Bootstrap](http://getbootstrap.com/) libraries for styling and formatting; Robust, small and has critical components for mobile support
 * JavaScript, with libraries including [jQuery](http://jquery.com/); Powerful with a multitude of functionalities for interactive elements
* Backend
 * [Ruby on Rails](http://rubyonrails.org/), see gem versions in `Gemfile`; Stable MVC framework that is easy to start because of [Rails generators](http://guides.rubyonrails.org/command_line.html#rails-generate), and has a large community to support it
 * OmniAuth from [Twitter](https://dev.twitter.com/), [Facebook](https://developers.facebook.com/) and [LinkedIn](https://developer.linkedin.com/); Widely used for better security and easy login
* Operating System
 * Unix-based system; Ease of development

### Styling and other

See `docs/` folder for more documentation on style, and installation of prerequisites.
