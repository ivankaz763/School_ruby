class My_Test_Class
    class << self

        def start_test()
            puts yield
        end 

        def my_assert_equal(value_1, value_2)
            if value_1 == value_2
                return "Test Passed"
            else 
                return "Error"
            end
        end

        def my_assert_includes(arr, elem)
            if arr.include?(elem)
                return "Test Passed"
            else 
                return "Error"
            end
        end

        def my_assert_execption
            message = yield
	    	
	    	message == "Error" ? "Test Passed" : "Error"
	    end

    end
end

My_Test_Class.start_test() do
    My_Test_Class.my_assert_equal(1+1 ,2)
end

My_Test_Class.start_test() do
    My_Test_Class.my_assert_equal(1+1,11)
end

My_Test_Class.start_test() do
    My_Test_Class.my_assert_includes([4,5,6],5)
end

My_Test_Class.start_test() do
    My_Test_Class.my_assert_includes([4,5,6],7)
end

My_Test_Class.start_test do
    My_Test_Class.my_assert_execption do
        My_Test_Class.my_assert_includes([4,5,6], 7)
    end
end

My_Test_Class.start_test do
    My_Test_Class.my_assert_execption do
        My_Test_Class.my_assert_includes([4,5,6], 5)
    end
end
 
