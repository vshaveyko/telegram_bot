#!/bin/bash
bundle exec rake features:preload

ruby config.ru
