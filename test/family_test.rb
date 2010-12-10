require File.dirname(__FILE__) + '/helper'
require 'family'

context 'A simple family' do
  setup do
    @family = Family.new(FAMILY)
  end

  test 'partners' do
    assert_equal 'Wendy Spero', @family.names(:partners)
  end

  test 'children' do
    assert_equal 'Penelope Elliston', @family.names(:children)
  end

  test 'parents' do
    assert_equal "Marg Elliston, Michael Elliston", @family.names(:parents)
  end

  test 'handprint' do
    assert_match 'Parents', @family.handprint
  end
end

context 'Divorced family' do
  setup do
    @family = Family.new(DIVORCED_FAMILY)
  end
  test 'partners' do
    assert_equal 'Fred Harris, Fred Harris, Michael Elliston', @family.names(:partners)
  end
end
