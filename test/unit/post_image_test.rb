require 'test_helper'

class PostImageTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert PostImage.new.valid?
  end
end
