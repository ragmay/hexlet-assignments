# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'
require 'minitest-power_assert'

class StackTest < Minitest::Test
  # BEGIN
  def test_stack_pop!
    assert { Stack.new([1, 2, 3]).pop! == [1, 2, 3].pop }
    assert { Stack.new([]).pop!.nil? }
  end

  def test_stack_push!
    assert { Stack.new([1, 2, 3]).push!([7, 8]) == [1, 2, 3].push([7, 8]) }
  end

  def test_stack_empty?
    assert { Stack.new([]).empty? }
  end

  def test_stack_to_a
    assert { Stack.new([1, 2, 3]).to_a == [1, 2, 3] }
    assert { Stack.new([]).to_a == [] }
  end

  def test_stack_clear!
    assert { Stack.new([1, 2, 3]).clear! == [] }
  end

  def test_stack_size
    assert { Stack.new([1, 2, 3]).size == [1, 2, 3].size }
  end

  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
