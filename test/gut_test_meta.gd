extends GutTest
class_name GutTestMeta


func assert_match(val, str):
	var regex = RegEx.new()
	regex.compile(str)
	assert_not_null(regex.search(val))


func assert_match_time_str(val):
	assert_match(val, '^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}$')
