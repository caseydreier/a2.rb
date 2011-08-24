#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'open-uri'
require 'cgi'

# Usage ruby a2.rb 123 My Address, Chicago, IL to 123 Other Address, Libon, Portugal
JSON.parse(open('http://maps.googleapis.com/maps/api/directions/json?sensor=false&'+send('sprintf', "origin=%s&destination=%s", *ARGV.join(' ').downcase.split(' to ').map { |n| CGI::escape(n.strip) })).read)['routes'].first['legs'].first['steps'].each_with_index { |s,i | puts ((i+1).to_s + '. ' + s['html_instructions'] + ' (' + s['distance']['text'] + ')').gsub(%r{</?[^>]+?>}, '') }