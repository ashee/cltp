# Welcome to cltp 

This application will be used to track M1/M2 medical students to track
their clinical encounters for a multidimensional perspectives

1. LCME accreditation and compliance
2. Pedagogical model
3. Portfolio
4. Longitudinal and life-long repository 

# Getting Started

This application is built on Rails 2.3.8. It uses MySQL 5.1 as the backend database. 

# Installation

## Install Xcode
[Xcode](http://developer.apple.com/technologies/xcode.html)

Make sure you download the correct version. Apple defaults to Xcode 3.2 (as of Aug 2, 2010) - this is 
a Snow Leopard version. For Leopard, you have to hunt for the appropriate download in their website.

## Git (source control)
[Download Git](http://git-scm.com/)

It builds using the linux/unix standard ./configure, make and make install.

## Ruby Version Manager (RVM) setup
[Install RVM](http://rvm.beginrescueend.com/rvm/install/) I have copied the relevant instructions below:

Open a Terminal session and enter the following

	ashee:~ amitava$ bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )

	ashee:~ amitava$ mkdir -p ~/.rvm/src/ && cd ~/.rvm/src && rm -rf ./rvm/ && git clone --depth 1 http://github.com/wayneeseguin/rvm.git && cd rvm && ./install

Append the following line to ~/.bashrc (assuming you are running BASH shell)

	echo [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

Source ~/.bashrc after making this changes or restart a new Terminal session

	ashee:~ amitava$ source ~/.bashrc

Now we are ready to install one or more ruby environments. We will start off by install ruby-1.8.7 and the
required gems

	ashee:~ amitava$ rvm install ruby-1.8.7

Make it the default ruby (from a rvm standpoint)

	ashee:~ amitava$ rvm --default ruby-1.8.7
	ashee:~ amitava$ rvm default
	ashee:~ amitava$ ruby -v
	ruby 1.8.7 (2009-06-12 patchlevel 174) [universal-darwin10.0]

## Install Rails and it's dependencies. 
I prefer to leave out the documentation files which explains --no-rdoc and --no-ri

	ashee:~ amitava$ gem install rails --no-rdoc --no-ri
	
Install mysql client - either the **native version** which requires mysql development headers and libraries

	ashee:~ amitava$ gem install mysql --no-rdoc --no-ri -- --with-mysql-config=$MYSQL_HOME/my.cnf 
	
OR a pure **ruby version**

	ashee:~ amitava$ gem install ruby-mysql --no-rdoc --no-ri
	
Optional - If you like sqlite3, install the driver

	ashee:~ amitava$ gem install sqlite3-ruby --no-rdoc --no-ri


## MySQL
[Download](http://dev.mysql.com/downloads/mysql/)

## Application

This application is built on Rails 2.3.8. It uses MySQL 5.1 as the
backend database. So make sure you have both installed.

To get going you need to:

1. Copy config/database.yml.template to config/database.yml
2. Create a database named cltp_dev in MySQL
3. Change the "development:" stanza in the config/database.yml so that
   the "username:" and "password:" specify a user that has sufficient
   privileges in the cltp_dev database.
4. Initialize the database. Details on how to do so will be shared
shortly.

Just invoke ./script/server to fire up the app within a 
ruby built-in webserver called webrick. 

## Production Envrionment

We plan to

1. Deploy this application on 
[Apache 2.2](http://httpd.apache.org/docs/2.2/) and 
[Phusion Passenger](http://www.modrails.com/).
2. Use [ruby enterprise edition (REE)](http://www.rubyenterpriseedition.com/)

See my [blog](http://amitava1.blogspot.com/2010/08/ruby-on-rails-on-centos-55-with.html)
to setup the production rails stack.

