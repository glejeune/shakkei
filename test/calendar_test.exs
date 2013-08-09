defmodule CalendarTest do
  use ExUnit.Case

  test "datetime basics" do
    dt = Calendar.DateTime[
      year: 2013,
      month: 8,
      day: 7,
      hour: 12,
      minute: 7,
      second: 43,
    ]

    assert(dt.epoch == 1375877263)
    assert(dt.is_leap == false)
    assert(dt.day_of_the_week == 3)
    assert(dt.week_number == 32)
    assert(dt.last_day_of_the_month == 31)
    assert(dt.day_of_year == 219)
  end

  test "strftime" do
    dt = Calendar.DateTime[
      year: 2013,
      month: 8,
      day: 7,
      hour: 12,
      minute: 7,
      second: 43,
    ]

    assert(Calendar.strftime("%z", dt) == "UTC+0")
    assert(Calendar.strftime("%%", dt) == "%")
    assert(Calendar.strftime("%Y", dt) == "2013")
    assert(Calendar.strftime("%y", dt) == "13")
    assert(Calendar.strftime("%C", dt) == "20")
    assert(Calendar.strftime("%D", dt) == "08/07/13")
    assert(Calendar.strftime("%d", dt) == "07")
    assert(Calendar.strftime("%e", dt) == "7")
    assert(Calendar.strftime("%F", dt) == "2013-08-07")
    assert(Calendar.strftime("%H", dt) == "12")
    assert(Calendar.strftime("%I", dt) == "12")
    assert(Calendar.strftime("%j", dt) == "219")
    assert(Calendar.strftime("%k", dt) == "12")
    assert(Calendar.strftime("%l", dt) == "12")
    assert(Calendar.strftime("%M", dt) == "07")
    assert(Calendar.strftime("%m", dt) == "08")
    assert(Calendar.strftime("%n", dt) == "\n")
    assert(Calendar.strftime("%p", dt) == "AM")
    assert(Calendar.strftime("%R", dt) == "12:07")
    assert(Calendar.strftime("%r", dt) == "12:07:43 AM")
    assert(Calendar.strftime("%S", dt) == "43")
    assert(Calendar.strftime("%s", dt) == "1375877263")
    assert(Calendar.strftime("%T", dt) == "12:07:43")
    assert(Calendar.strftime("%t", dt) == "\t")
    assert(Calendar.strftime("%U", dt) == "32")
    assert(Calendar.strftime("%u", dt) == "3")
  end

  test "DateTime add" do
    dt = Calendar.DateTime[
      year: 2013,
      month: 8,
      day: 7,
      hour: 12,
      minute: 7,
      second: 43,
    ]

    dt_year = dt.add(2, :years)
    assert(dt_year.year == 2015)
    assert(dt_year.month == 8)
    assert(dt_year.day == 7)

    dt_hour = dt.add(37, :hours)
    assert(dt_hour.year == 2013)
    assert(dt_hour.month == 8)
    assert(dt_hour.day == 9)
    assert(dt_hour.hour == 1)
    assert(dt_hour.minute == 7)
    assert(dt_hour.second == 43)
  end

  test "DateTime add on leap year" do
    dt = Calendar.DateTime[
      year: 2012,
      month: 2,
      day: 29,
      hour: 12,
      minute: 7,
      second: 43,
    ]

    dt_year = dt.add(1, :years)
    assert(dt_year.year == 2013)
    assert(dt_year.month == 2)
    assert(dt_year.day == 28)
  end

  test "DateTime extrem" do
    dt = Calendar.DateTime[
      year: 2000,
      month: 1,
      day: 1,
      hour: 0,
      minute: 0,
      second: 0,
    ]

    dt_minus_one_second = dt.add(-1, :second)
    assert(dt_minus_one_second.year == 1999)
    assert(dt_minus_one_second.month == 12)
    assert(dt_minus_one_second.day == 31)
    assert(dt_minus_one_second.hour == 23)
    assert(dt_minus_one_second.minute == 59)
    assert(dt_minus_one_second.second == 59)

    dt = Calendar.DateTime[
      year: 2000,
      month: 12,
      day: 31,
      hour: 23,
      minute: 59,
      second: 59,
    ]

    dt_plus_one_second = dt.add(1, :second)
    assert(dt_plus_one_second.year == 2001)
    assert(dt_plus_one_second.month == 1)
    assert(dt_plus_one_second.day == 1)
    assert(dt_plus_one_second.hour == 0)
    assert(dt_plus_one_second.minute == 0)
    assert(dt_plus_one_second.second == 0)
  end

  test "Parse date" do
    dt = Calendar.parse("09/08/1974 2:38 PM")
    assert(dt.year == 1974)
    assert(dt.month == 8)
    assert(dt.day == 9)
    assert(dt.hour == 14)
    assert(dt.minute == 38)

    dt = Calendar.parse("2010-09-01T20:49:05.185Z")
    assert(dt.year == 2010)
    assert(dt.month == 9)
    assert(dt.day == 1)
    assert(dt.hour == 20)
    assert(dt.minute == 49)
    assert(dt.second == 5)

    dt = Calendar.parse("2010-09-01 20:49:05 UTC-4")
    assert(dt.year == 2010)
    assert(dt.month == 9)
    assert(dt.day == 1)
    assert(dt.hour == 20)
    assert(dt.minute == 49)
    assert(dt.second == 5)
    assert(dt.utc == -4)
  end

  test "Easter" do
    dt = Calendar.easter(2008)
    assert(dt.year == 2008)
    assert(dt.month == 3)
    assert(dt.day == 23)

    dt = Calendar.easter(2009)
    assert(dt.year == 2009)
    assert(dt.month == 4)
    assert(dt.day == 12)

    dt = Calendar.easter(2010)
    assert(dt.year == 2010)
    assert(dt.month == 4)
    assert(dt.day == 4)

    dt = Calendar.easter(2011)
    assert(dt.year == 2011)
    assert(dt.month == 4)
    assert(dt.day == 24)

    dt = Calendar.easter(2012)
    assert(dt.year == 2012)
    assert(dt.month == 4)
    assert(dt.day == 8)

    dt = Calendar.easter(2013)
    assert(dt.year == 2013)
    assert(dt.month == 3)
    assert(dt.day == 31)

    dt = Calendar.easter(2014)
    assert(dt.year == 2014)
    assert(dt.month == 4)
    assert(dt.day == 20)
  end

  test "Compare" do
    assert(Calendar.compare(Calendar.now(), Calendar.tomorrow()) == -1)
    assert(Calendar.compare(Calendar.now(), Calendar.yesterday()) == 1)
    assert(Calendar.compare(Calendar.now(), Calendar.now()) == 0)
  end

  test "Is futur and past" do
    assert(Calendar.is_futur(Calendar.now()) == false)
    assert(Calendar.is_futur(Calendar.tomorrow()) == true)
    assert(Calendar.is_futur(Calendar.yesterday()) == false)

    assert(Calendar.is_past(Calendar.now()) == true)
    assert(Calendar.is_past(Calendar.tomorrow()) == false)
    assert(Calendar.is_past(Calendar.yesterday()) == true)
  end
end
