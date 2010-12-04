require File.dirname(__FILE__) + '/helper'
require 'family'

context 'A simple family' do
  setup do
    @family = Family.new(FAMILY)
  end

  test 'partners' do
    assert_equal ['Wendy Elliston'], @family.names(:partners)
  end

  test 'children' do
    assert_equal [], @family.names(:children)
  end

  test 'parents' do
    assert_equal ['Mike Elliston', 'Marg Elliston'], @family.names(:parents)
  end

  test 'handprint' do
    assert_match 'Parents', @family.handprint
  end
end
