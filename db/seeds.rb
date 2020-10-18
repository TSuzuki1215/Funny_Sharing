require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require "open-uri"
require "sinatra/json"
require './models.rb'
require 'net/http'
require "json"
require 'uri'

Camp.create({
    camp_period: '2020夏',
    camp_name: '7三田'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: '7オンライン'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: '7オンラインライト'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'B新横浜'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'B名古屋'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'Aオンラインライト'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'Aオンラインライト土日'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'Bオンライン'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'B大阪オフィス'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'B東京オフィス'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'C成蹊大学'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'Cオンライン'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'C東京オフィス'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'C大阪オフィス'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'D東京オフィス'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'D大阪オフィス'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'Dオンライン'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'DオンラインT4T'
    })

Camp.create({
    camp_period: '2020夏',
    camp_name: 'Dオンラインライト'
    })