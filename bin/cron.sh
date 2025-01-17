#! /bin/sh

wait-for-it "redis:6379" -- echo "Redis up and running"

wait-for-it "memcached:11211" -- echo "Memcached up and running"

wait-for-it "postgresql:5432" -- echo "PostgreSQL up and running"

wait-for-it "elasticsearch:9200" -- echo "Elastic up and running"

bundle exec ruby cron.rb
