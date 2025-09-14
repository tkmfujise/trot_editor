extends GutTestMeta


func test_reverse():
	var arr = [1,2,3]
	assert_eq(ArrayHelper.reverse(arr), [3,2,1])
	assert_eq(arr, [1,2,3])
