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

DIVORCED_FAMILY = <<-END
{"focus":{"created_by":"https://stage.geni.com/api/profile-1","locked":"false","suffix":"","gender":"female","claimed":"true","url":"https://stage.geni.com/api/profile-2","first_name":"Marg","middle_name":"","last_name":"Elliston","public":"false","maiden_name":"Sher","big_tree":"true","name":"Marg Elliston","birth_location":"","id":"2","current_residence":"Albuquerque, NM, United States","birth_date":"8/23/1944"},"nodes":{"profile-109":{"edges":{"union-4025682659990010360":{"rel":"partner"},"union-4025682657580010358":{"rel":"partner"},"union-4025682641820010303":{"rel":"child"}},"gender":"female","url":"https://stage.geni.com/api/profile-109","public":"false","last_name":"Daugherty","first_name":"Reta","id":"109"},"union-4025682647920010324":{"edges":{"profile-1":{"rel":"child"},"profile-2":{"rel":"partner"},"profile-3":{"rel":"partner"},"profile-98":{"rel":"child"}},"status":"ex_spouse"},"profile-1":{"edges":{"union-4025682647920010324":{"rel":"child"},"union-4025682643510010314":{"rel":"partner"}},"gender":"male","url":"https://stage.geni.com/api/profile-1","public":"false","last_name":"Elliston","middle_name":"Eagle","first_name":"Amos","id":"1"},"profile-95":{"edges":{"union-4025682701740010359":{"rel":"child"},"union-4025682678190010307":{"rel":"partner"},"union-4025682646650010322":{"rel":"partner"}},"gender":"male","url":"https://stage.geni.com/api/profile-95","public":"false","last_name":"Harris","first_name":"Fred","id":"95"},"profile-100":{"edges":{"union-4025682706690010366":{"rel":"child"},"union-4025682641820010303":{"rel":"partner"}},"gender":"female","url":"https://stage.geni.com/api/profile-100","public":"false","last_name":"Sher","middle_name":"Frankel","first_name":"Hortense ","maiden_name":"Frankel","id":"100"},"profile-2":{"edges":{"union-4025682647920010324":{"rel":"partner"},"union-4025682646650010322":{"rel":"partner"},"union-6000000009825586080":{"rel":"partner"},"union-4025682641820010303":{"rel":"child"}},"gender":"female","url":"https://stage.geni.com/api/profile-2","public":"false","last_name":"Elliston","middle_name":"","first_name":"Marg","maiden_name":"Sher","id":"2"},"profile-3":{"edges":{"union-5244046826250128745":{"rel":"partner"},"union-4025682647920010324":{"rel":"partner"},"union-4025682642320010306":{"rel":"child"}},"gender":"male","url":"https://stage.geni.com/api/profile-3","public":"false","last_name":"Elliston","middle_name":"Shaw","first_name":"Michael","id":"3"},"profile-113":{"edges":{"union-4025682666710010384":{"rel":"partner"},"union-4025682641820010303":{"rel":"child"}},"gender":"female","url":"https://stage.geni.com/api/profile-113","public":"false","last_name":"Hertz","middle_name":"","first_name":"Barbara","id":"113"},"union-4025682646650010322":{"edges":{"profile-95":{"rel":"partner"},"profile-2":{"rel":"partner"}},"status":"spouse"},"profile-98":{"edges":{"union-4025682647920010324":{"rel":"child"},"union-4025682693630010346":{"rel":"partner"}},"gender":"female","url":"https://stage.geni.com/api/profile-98","public":"false","last_name":"Elliston","first_name":"Amanda","id":"98"},"profile-103":{"edges":{"union-4025682648310010327":{"rel":"partner"},"union-4025682641820010303":{"rel":"child"}},"gender":"male","url":"https://stage.geni.com/api/profile-103","public":"false","last_name":"Sher","middle_name":"Michael","first_name":"Andy","id":"103"},"union-6000000009825586080":{"edges":{"profile-2":{"rel":"partner"},"profile-6000000009825586077":{"rel":"partner"}},"status":"spouse"},"profile-99":{"edges":{"union-4025682660670010362":{"rel":"child"},"union-4025682641820010303":{"rel":"partner"}},"gender":"male","url":"https://stage.geni.com/api/profile-99","public":"false","last_name":"Sher","first_name":"Malcolm","id":"99"},"union-4025682641820010303":{"edges":{"profile-109":{"rel":"child"},"profile-100":{"rel":"partner"},"profile-2":{"rel":"child"},"profile-113":{"rel":"child"},"profile-103":{"rel":"child"},"profile-99":{"rel":"partner"}},"status":"spouse"},"profile-6000000009825586077":{"edges":{"union-6000000009825586080":{"rel":"partner"}},"gender":"male","url":"https://stage.geni.com/api/profile-6000000009825586077","public":"false","last_name":"Harris","first_name":"Fred","id":"6000000009825586077"}}}
END
