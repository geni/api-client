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
{"focus":{"middle_name":"Eagle","locked":"false","suffix":"","gender":"male","url":"https://stage.geni.com/api/profile-101","first_name":"Amos","last_name":"Elliston","public":"false","birth_location":"Albuquerque, NM, United States","current_residence":"Los Angeles, CA","created_by":"https://stage.geni.com/api/profile-101","birth_date":"August 8","display_name":"","name":"Amos Elliston","big_tree":"true","id":"profile-101","guid":"1","claimed":"true"},"nodes":{"profile-207":{"edges":{"union-321":{"rel":"child"},"union-209":{"rel":"partner"},"union-33371139":{"rel":"child"}},"gender":"female","url":"https://stage.geni.com/api/profile-207","public":"false","last_name":"Spero","first_name":"Wendy","id":"profile-207"},"profile-101":{"edges":{"union-218":{"rel":"child"},"union-209":{"rel":"partner"}},"middle_name":"Eagle","gender":"male","url":"https://stage.geni.com/api/profile-101","public":"false","last_name":"Elliston","first_name":"Amos","id":"profile-101"},"profile-102":{"edges":{"union-200":{"rel":"child"},"union-33239438":{"rel":"partner"},"union-217":{"rel":"partner"},"union-218":{"rel":"partner"}},"middle_name":"","maiden_name":"Sher","gender":"female","url":"https://stage.geni.com/api/profile-102","public":"false","last_name":"Elliston","first_name":"Marg","id":"profile-102"},"union-218":{"edges":{"profile-101":{"rel":"child"},"profile-102":{"rel":"partner"},"profile-103":{"rel":"partner"},"profile-181":{"rel":"child"}},"status":"ex_spouse"},"profile-103":{"edges":{"union-202":{"rel":"child"},"union-218":{"rel":"partner"},"union-4858372":{"rel":"partner"}},"middle_name":"Shaw","gender":"male","url":"https://stage.geni.com/api/profile-103","public":"false","last_name":"Elliston","first_name":"Michael","id":"profile-103"},"profile-181":{"edges":{"union-311":{"rel":"partner"},"union-218":{"rel":"child"}},"gender":"female","url":"https://stage.geni.com/api/profile-181","public":"false","last_name":"Elliston","first_name":"Amanda","id":"profile-181"},"union-209":{"edges":{"profile-207":{"rel":"partner"},"profile-101":{"rel":"partner"},"profile-55441458":{"rel":"child"}},"status":"spouse"},"profile-55441458":{"edges":{"union-209":{"rel":"child"}},"gender":"female","url":"https://stage.geni.com/api/profile-55441458","public":"false","last_name":"Elliston","first_name":"Penelope","id":"profile-55441458"}}}
END

DIVORCED_FAMILY = <<-END
{"focus":{"middle_name":"","maiden_name":"Sher","locked":"false","suffix":"","gender":"female","url":"https://stage.geni.com/api/profile-102","first_name":"Marg","last_name":"Elliston","public":"false","birth_location":"","current_residence":"Albuquerque, NM, United States","created_by":"https://stage.geni.com/api/profile-101","birth_date":"8/23/1944","name":"Marg Elliston","big_tree":"true","id":"profile-102","guid":"2","claimed":"true"},"nodes":{"union-200":{"edges":{"profile-186":{"rel":"child"},"profile-102":{"rel":"child"},"profile-191":{"rel":"child"},"profile-193":{"rel":"child"},"profile-182":{"rel":"partner"},"profile-183":{"rel":"partner"}},"status":"spouse"},"profile-101829285":{"edges":{"union-33239438":{"rel":"partner"}},"gender":"male","url":"https://stage.geni.com/api/profile-101829285","public":"false","last_name":"Harris","first_name":"Fred","id":"profile-101829285"},"union-33239438":{"edges":{"profile-101829285":{"rel":"partner"},"profile-102":{"rel":"partner"}},"status":"spouse"},"profile-186":{"edges":{"union-200":{"rel":"child"},"union-220":{"rel":"partner"}},"middle_name":"Michael","gender":"male","url":"https://stage.geni.com/api/profile-186","public":"false","last_name":"Sher","first_name":"Andy","id":"profile-186"},"profile-101":{"edges":{"union-218":{"rel":"child"},"union-209":{"rel":"partner"}},"middle_name":"Eagle","gender":"male","url":"https://stage.geni.com/api/profile-101","public":"false","last_name":"Elliston","first_name":"Amos","id":"profile-101"},"profile-178":{"edges":{"union-282":{"rel":"partner"},"union-217":{"rel":"partner"},"union-320":{"rel":"child"}},"gender":"male","url":"https://stage.geni.com/api/profile-178","public":"false","last_name":"Harris","first_name":"Fred","id":"profile-178"},"union-217":{"edges":{"profile-178":{"rel":"partner"},"profile-102":{"rel":"partner"}},"status":"spouse"},"profile-102":{"edges":{"union-200":{"rel":"child"},"union-33239438":{"rel":"partner"},"union-217":{"rel":"partner"},"union-218":{"rel":"partner"}},"middle_name":"","maiden_name":"Sher","gender":"female","url":"https://stage.geni.com/api/profile-102","public":"false","last_name":"Elliston","first_name":"Marg","id":"profile-102"},"union-218":{"edges":{"profile-101":{"rel":"child"},"profile-102":{"rel":"partner"},"profile-103":{"rel":"partner"},"profile-181":{"rel":"child"}},"status":"ex_spouse"},"profile-103":{"edges":{"union-202":{"rel":"child"},"union-218":{"rel":"partner"},"union-4858372":{"rel":"partner"}},"middle_name":"Shaw","gender":"male","url":"https://stage.geni.com/api/profile-103","public":"false","last_name":"Elliston","first_name":"Michael","id":"profile-103"},"profile-191":{"edges":{"union-200":{"rel":"child"},"union-242":{"rel":"partner"},"union-243":{"rel":"partner"}},"gender":"female","url":"https://stage.geni.com/api/profile-191","public":"false","last_name":"Daugherty","first_name":"Reta","id":"profile-191"},"profile-181":{"edges":{"union-311":{"rel":"partner"},"union-218":{"rel":"child"}},"gender":"female","url":"https://stage.geni.com/api/profile-181","public":"false","last_name":"Elliston","first_name":"Amanda","id":"profile-181"},"profile-193":{"edges":{"union-200":{"rel":"child"},"union-265":{"rel":"partner"}},"middle_name":"","gender":"female","url":"https://stage.geni.com/api/profile-193","public":"false","last_name":"Hertz","first_name":"Barbara","id":"profile-193"},"profile-182":{"edges":{"union-244":{"rel":"child"},"union-200":{"rel":"partner"}},"gender":"male","url":"https://stage.geni.com/api/profile-182","public":"false","last_name":"Sher","first_name":"Malcolm","id":"profile-182"},"profile-183":{"edges":{"union-200":{"rel":"partner"},"union-322":{"rel":"child"}},"middle_name":"Frankel","maiden_name":"Frankel","gender":"female","url":"https://stage.geni.com/api/profile-183","public":"false","last_name":"Sher","first_name":"Hortense ","id":"profile-183"}}}
END
