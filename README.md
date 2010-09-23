Deployr
=======
Deployr is a platform for managing websites, stored within Git and distributed via FTP, SFTP, etc.

Requirements
------------
Deployr is a [Rails 3](http://www.rubyonrails.org/) application, and has the following gem dependencies.

Installation
------------
Once you have met all of the requirements listed above you must run the install rake task to setup the appropriate directories and configuration files. The simple method involves invoking the deployr:install rake task:
    rake deployr:install
The install task may also be customized with the following parameters (in this order):
* **working_directory**: The directory where Deployr will store all of its local working copies
For example:
    rake deployr:install[/tmp/deployr]

Contribute
----------
Interested in contributing to Deployr? Please feel free to fork and send a pull request. We would be happy to incorporate the work of others and make Deployr a better product. Not a developer? That isn't a problem, submitting bug reports on the issue page are just as important, in order to make Deployr a better solution for everyone.

Special Thanks
--------------
A big thank you to [Team Colab](http://www.teamcolab.com/) for their support and direction on this project.
