dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'
require 'test/unit'
require 'rubygems'
require 'pp'

##
# test/spec/mini 3
# http://gist.github.com/25455
# chris@ozmm.org
# file:lib/test/spec/mini.rb
#
def context(*args, &block)
  return super unless (name = args.first) && block
  require 'test/unit'
  klass = Class.new(defined?(ActiveSupport::TestCase) ? ActiveSupport::TestCase : Test::Unit::TestCase) do
    def self.test(name, &block) 
      define_method("test_#{name.gsub(/\W/,'_')}", &block) if block
    end
    def self.xtest(*args) end
    def self.setup(&block) define_method(:setup, &block) end
    def self.teardown(&block) define_method(:teardown, &block) end
  end
  (class << klass; self end).send(:define_method, :name) { name.gsub(/\W/,'_') }
  klass.class_eval &block
end

FAMILY= <<-END
{"focus":{"name":"Amos Elliston","birth_location":"","public":"false","current_residence":"Los Angeles, CA, USA","url":"https://qa.geni.com/api/profiles/2","gender":"male","created_by":"https://qa.geni.com/api/profiles/2","id":"2","claimed":"true","birth_date":"11/8/1978","last_name":"Elliston","display_name":"","suffix":"","big_tree":"false","middle_name":"","locked":"false","first_name":"Amos"},"nodes":{"profile-2334022":{"edges":{"union-2334025":{"rel":"partner"}},"public":"false","url":"https://qa.geni.com/api/profiles/2334022","gender":"female","id":"2334022","last_name":"Elliston","middle_name":"","first_name":"Wendy"},"union-2334025":{"edges":{"profile-2334022":{"rel":"partner"},"profile-2":{"rel":"partner"}},"status":"spouse"},"profile-2":{"edges":{"union-2334025":{"rel":"partner"},"union-557814":{"rel":"child"}},"public":"false","url":"https://qa.geni.com/api/profiles/2","gender":"male","id":"2","last_name":"Elliston","middle_name":"","first_name":"Amos"},"union-557814":{"edges":{"profile-2":{"rel":"child"},"profile-557602":{"rel":"partner"},"profile-561202":{"rel":"partner"}},"status":"spouse"},"profile-557602":{"edges":{"union-1109421":{"rel":"partner"},"union-10000327204":{"rel":"child"},"union-557814":{"rel":"partner"}},"public":"false","url":"https://qa.geni.com/api/profiles/557602","gender":"male","id":"557602","last_name":"Elliston","middle_name":"","first_name":"Mike"},"profile-561202":{"edges":{"union-557814":{"rel":"partner"},"union-561314":{"rel":"partner"}},"public":"false","url":"https://qa.geni.com/api/profiles/561202","gender":"female","id":"561202","last_name":"Elliston","middle_name":"","first_name":"Marg"}}}
END
