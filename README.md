## Basic Control Panel for Prey Standalone users

If you want to use Prey on Standalone mode and wish to manage multiple devices,
this is a small app that can give you a hand. It's written in Ruby using Sinatra
and MongoMapper.

## Requirements

 - Ruby 
 - Mongo DB
 - Bundler ruby gem

## Installation

Once you've got Mongo and Ruby set up, clone the repo and run:

```
bundle install
```

And let Bundler take care of all the gem dependencies. Once you're ready you can
run:

```
rackup -s thin
```

And the app should load. By browsing to / you'll be requested a username and 
password via Basic HTTP auth. The default values are 'admin/secret' but you can
change it by modifying config.ru if you want to.

## Setting up the clients

Edit the config file and add your server to the check_url variable

```
check_url='http://your.server.com'
```

And that's it. Your device should now start checking its state against your own
Control Panel. If it ever goes missing, just log in again and change the missing
field for that device from 'false' to 'true', and Prey will begin to send reports
via email using your SMTP settings.

Additionally, you can change the execution delay and modify the modules which will
be triggered remotely using the module_list field. Just make sure you separate 
them with spaces (e.g. "geo network lock").

## Credits

Written by Tomás Pollak.

## Legal

(c) 2011 - Fork Ltd. Released under the GPLv3 license.
