require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:short_description].any?
  end

  # test "the truth" do
  #   assert true
  # end
end
