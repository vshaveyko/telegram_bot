# frozen_string_literal: true
class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end

  def camelize(uppercase_first_letter = true)
    string = self
    if uppercase_first_letter
      string = string.sub(/^[a-z\d]*/) { |match| match.capitalize }
    else
      string = string.sub(/^(?:(?=\b|[A-Z_])|\w)/) { |match| match.downcase }
    end
    string.gsub!(/(?:_|(\/))([a-z\d]*)/i) { "#{$1}#{$2.capitalize}" }
    string.gsub!("/".freeze, "::".freeze)
    string
  end
end
# require('pry')
def Object.const_missing(name, target=(default_used=self == Object; self))
  target_steps        = (default_used ? [] : target.name.split('::').reject(&:empty?))
  target_steps_length = target_steps.length
  str_name            = (default_used ? '' : target.name + '::')  + name.to_s
  guessed_dir_path    = str_name.underscore.split('::').join('/')
  guesses             = Dir['app/*/' + guessed_dir_path + '*']

  if guesses.empty?
    raise "Class not defined #{name}"
  end

  res = nil

  guesses.each do |guess|
    if (File.exists?(guess) && File.file?(guess)) || File.exists?(guess + '.rb')
      require_relative '../' + guess

      res = target.const_get(name)

      break
    elsif File.directory?(guess)

      guess_steps = guess.split('/')[(2+target_steps_length)..-1]

      res = guess_steps.inject(target) do |target, guess_step|
        guess_const = guess_step.camelize

        (target.const_defined?(guess_const) && target.const_get(guess_const)) ||
          target.const_set(guess_const, Module.new)
      end

      break
    end
  end

  return res if res

  raise "Class not defined #{name}"
end
#
class Module
  def const_missing(name)
    Object.const_missing(name, self)
  end
end
#
# class Class
#   def const_missing(name)
#     Object.const_missing(name, self)
#   end
# end

require 'bundler'
Bundler.require
Dotenv.load

require_relative('database')
require('telegram/bot')

begin
  require 'pry'
rescue LoadError
end

Dir['app/**/*.rb'].each { |file| require_relative('../' + file) }
