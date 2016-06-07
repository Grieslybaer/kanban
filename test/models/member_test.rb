require "test_helper"

class MemberTest < ActiveSupport::TestCase

  def member
    @member ||= Member.new
  end

  def test_valid
    assert member.valid?
  end

end
