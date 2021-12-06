require "minitest/autorun"

class Calculate
    def addition(first_addend, second_addend)
        first_addend.to_i + second_addend.to_i
    end

    def subtraction(minuend, subtrahend)
        minuend - subtrahend
    end

    def multiply(multiplicanda, multiplier)
        multiplicanda * multiplier
    end

    def quotient(dividend, divisor)
        dividend / divisor
    end

    def exception_assert_rise(list_of_element, element)
        result = list_of_element.include? element
        raise Exception, "The element not in list." if result == false
    end

end

class TestCalculate < MiniTest::Unit::TestCase
    def setup
        @calculate = Calculate.new
    end

    def test_suaddition
        assert_equal 5, @calculate.addition(2,3)
    end

    def test_subtraction
        assert_equal 1, @calculate.subtraction(3,2)
    end

    def test_multiply
        assert_equal 6, @calculate.multiply(2,3)
    end

    def test_quotient
        assert_equal 2, @calculate.quotient(6,3)
    end

    def test_includes
        assert_includes([5,6,7], 6)
    end 

    def test_exception
        result = [5,6,7].include? 8
        assert_equal false, result
    end

    def test_exception_assert_rise
        assert_raises Exception do
            exception_assert_rise([5,6,7], 8)
        end
      end

end


