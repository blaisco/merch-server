Start rabbitmq
$ rabbitmq-server -detached

Start Consumer
$ ruby consumer.rb start

Start Resque Worker (in Rails.root)
$ QUEUE=* rake environment resque:work

----

Start Resque Web (if you want it)
$ resque-web

Fake some data (in Rails.root)
$ rake queue:new_merch
