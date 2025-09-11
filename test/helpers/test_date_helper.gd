extends GutTest


func assert_match(val, str):
	var regex = RegEx.new()
	regex.compile(str)
	assert_not_null(regex.search(val))


func test_now():
	var time = TimeHelper.now()
	assert_typeof(time, TYPE_DICTIONARY)
	assert_not_null(time['year'])
	assert_eq(time.keys(), ["year", "month", "day", "weekday", "hour", "minute", "second"])


func test_now_str():
	var str = TimeHelper.now_str()
	assert_typeof(str, TYPE_STRING)
	assert_match(str, '^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}$')


func test_now_unix():
	var time = TimeHelper.now_unix()
	assert_typeof(time, TYPE_INT)


func test_unix2dict():
	var time = TimeHelper.now_unix()
	var dict = TimeHelper.unix2dict(time)
	assert_typeof(dict, TYPE_DICTIONARY)
	assert_eq(time, TimeHelper.dict2unix(dict))


func test_unix2str():
	var time = TimeHelper.now_unix()
	var str  = TimeHelper.unix2str(time)
	assert_typeof(str, TYPE_STRING)
	assert_eq(time, TimeHelper.str2unix(str))


func test_dict2unix():
	var time = TimeHelper.now()
	var unix = TimeHelper.dict2unix(time)
	assert_typeof(unix, TYPE_INT)
	assert_eq(time, TimeHelper.unix2dict(unix))


func test_dict2str():
	var time = TimeHelper.now()
	var str  = TimeHelper.dict2str(time)
	assert_typeof(str, TYPE_STRING)
	assert_eq(time, TimeHelper.str2dict(str))


func test_str2unix():
	var time = TimeHelper.now_str()
	var unix = TimeHelper.str2unix(time)
	assert_typeof(unix, TYPE_INT)
	assert_eq(time, TimeHelper.unix2str(unix))


func test_str2dict():
	var time = TimeHelper.now_str()
	var dict = TimeHelper.str2dict(time)
	assert_typeof(dict, TYPE_DICTIONARY)
	assert_eq(time, TimeHelper.dict2str(dict))
