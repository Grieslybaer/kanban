require "test_helper"

class AssignmentTest < ActiveSupport::TestCase

  def assignment
    @assignment ||= Assignment.new
  end

  def test_valid
    assert assignment.valid?
  end

end
