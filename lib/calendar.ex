defmodule Calendar do
  @moduledoc """
  This module allow you to manipulate date and time informations.
  """

  defrecord DateTime,
    year:   1970,
    month:  1,
    day:    1,
    hour:   0,
    minute: 0,
    second: 0,
    utc:    0 do
    @recorddoc """
    datetime représentation
    """

    def to_datetime(record) do
      {
        record.to_date,
        record.to_time
      }
    end

    def to_date(record) do
      {record.year, record.month, record.day}
    end

    def to_time(record) do
      {record.hour, record.minute, record.second}
    end

    @doc """
    return the UNIX Epoch value
    """
    def epoch(record) do
      gregorian = :calendar.datetime_to_gregorian_seconds(record.to_datetime)
      unix = :calendar.datetime_to_gregorian_seconds({{1970,1,1},{0,0,0}})
      gregorian - unix
    end

    @doc """
    Return true if the year is leap. False otherwise
    """
    def is_leap(record) do
      :calendar.is_leap_year(record.year)
    end

    @doc """
    Return the day of the week for the current DateTime
    """
    def day_of_the_week(record) do
      :calendar.day_of_the_week(record.to_date)
    end

    @doc """
    Return the week number for the current DateTime
    """
    def week_number(record) do
      {_, wn} = :calendar.iso_week_number(record.to_date)
      wn
    end

    @doc """
    Return the last day for the month of the current DateTime
    """
    def last_day_of_the_month(record) do
      :calendar.last_day_of_the_month(record.year, record.month)
    end

    @doc """
    Return the day of the year for the current DateTime
    """
    def day_of_year(record) do
      {days,_} = :calendar.time_difference({{record.year,1,1},{0,0,0}}, record.to_datetime)
      days + 1
    end

    @doc """
    Return a new DateTime by adding _value_ _unit_s to the current DateTime

    Supported _unit_s are :

    * :year | :years
    * :month | :months
    * :day | :days
    * :hour | :hours
    * :minute | :minutes
    * :second | :seconds
    """
    def add(value, unit, record) when unit in [:year, :years] do
      record.add(value * 12, :months)
    end
    def add(value, unit, record) when unit in [:month, :months] do
      {year, month, day} = record.to_date
      total_month = (12 * year) + month + value
      new_month = rem(total_month, 12)
      new_year = div(total_month - new_month, 12)
      {new_year, new_month, new_day} = find_valid({new_year, new_month, day})
      Calendar.DateTime[
        year: new_year, 
        month: new_month, 
        day: new_day, 
        hour: record.hour, 
        minute: record.minute, 
        second: record.second, 
        utc: record.utc
      ]
    end
    def add(value, unit, record) when unit in [:day, :days] do
      {year, month, day} = :calendar.gregorian_days_to_date(:calendar.date_to_gregorian_days(record.to_date) + value);
      Calendar.DateTime[
        year: year, 
        month: month, 
        day: day, 
        hour: record.hour, 
        minute: record.minute, 
        second: record.second, 
        utc: record.utc
      ]
    end
    def add(value, unit, record) when unit in [:hour, :hours] do
      record.add(value*60, :minute)
    end
    def add(value, unit, record) when unit in [:minute, :minutes] do
      record.add(value*60, :second)
    end
    def add(value, unit, record) when unit in [:second, :seconds] do
      gregorian = :calendar.datetime_to_gregorian_seconds(record.to_datetime)
      {{year, month, day}, {hour, minute, second}} = :calendar.gregorian_seconds_to_datetime(gregorian + value)
      Calendar.DateTime[
        year: year, 
        month: month, 
        day: day, 
        hour: hour, 
        minute: minute, 
        second: second, 
        utc: record.utc
      ]
    end
    defp find_valid({year, month, day}=date) do
      case :calendar.valid_date(date) do
        true -> date
        false -> find_valid({year, month, day - 1})
      end
    end

    def inspect(record) do
      Calendar.strftime("%F %T", record)
    end
  end

  @doc """
  return a Calendar.DateTime record corresponding to the current local time.
  """
  def now() do
    {date, time} = :calendar.local_time()
    {{year, month, day}, {hour, minute,second}} = {date, time}

    # get UTC
    {_, {uhour, _, _}} = :calendar.universal_time()
    utc = hour - uhour

    Calendar.DateTime[
      year: year, 
      month: month, 
      day: day, 
      hour: hour, 
      minute: minute, 
      second: second, 
      utc: utc
    ]
  end

  @doc """
  return a Calendar.DateTime record corresponding to the tomorrow local time.
  """
  def tomorrow() do
    now().add(1, :day)
  end

  @doc """
  return a Calendar.DateTime record corresponding to the yesterday local time.
  """
  def yesterday() do
    now().add(-1, :day)
  end

  @doc """
  Compare to Calendar.DateTime.

  ## Return

  * 0 if the two datetime are identical
  * 1 if the first DateTime is greater than the second one
  * -1 if the first DateTime is lower than to the second one

  ## Example

      iex> Calendar.compare(Calendar.now(), Calendar.tomorrow())
      -1
      iex> Calendar.compare(Calendar.now(), Calendar.yesterday())
      1
      iex> Calendar.compare(Calendar.now(), Calendar.now())
      0
  """
  def compare(dt1, dt2) do
    dt1s = :calendar.datetime_to_gregorian_seconds(dt1.to_datetime)
    dt2s = :calendar.datetime_to_gregorian_seconds(dt2.to_datetime)
    result = 0
    if dt1s > dt2s do
      result = 1
    end
    if dt1s < dt2s do
      result = -1
    end
    result
  end

  @doc """
  Return true if the given date is in the futur

  ## Example

      iex> Calendar.is_futur(Calendar.now())
      false
      iex> Calendar.is_futur(Calendar.tomorrow())
      true
      iex> Calendar.is_futur(Calendar.yesterday())
      false
  """
  def is_futur(dt) do
    compare(dt, now()) == 1
  end

  @doc """
  Return true if the given date is in the past

  ## Example

      iex> Calendar.is_past(Calendar.now())
      false
      iex> Calendar.is_past(Calendar.tomorrow())
      true
      iex> Calendar.is_past(Calendar.yesterday())
      false
  """
  def is_past(dt) do
    n = now()
    compare(dt, n) == -1 or compare(dt, n) == 0
  end

  @doc """
  Create a Calendar.DateTime
  """
  def datetime(dt) do
    datetime(dt, 0)
  end
  def datetime({{year, month, day}, {hour, minute, second}}, utc) do
    Calendar.DateTime[
      year: year, 
      month: month, 
      day: day, 
      hour: hour, 
      minute: minute, 
      second: second,
      utc: utc
    ]
  end

  @doc """
  Return a formated string of the given Calendar.DateTime record, according to the string pointed to by format.

  ## Format string

  * _%%_ - is replaced by `%'.
  * _%Z_ - is replaced by the time zone name. (not yet supported)
  * _%Y_ - is replaced by the year with century as a decimal number.
  * _%y_ - is replaced by the year without century as a decimal number (00-99).
  * _%A_ - is replaced by national representation of the full weekday name. (not yet supported)
  * _%a_ - is replaced by national representation of the abbreviated weekday name. (not yet supported)
  * _%B_ - is replaced by national representation of the full month name. (not yet supported)
  * _%b_ - is replaced by national representation of the abbreviated month name. (not yet supported)
  * _%C_ - is replaced by (year / 100) as decimal number; single digits are preceded by a zero.
  * _%c_ - is replaced by national representation of time and date. (not yet supported)
  * _%D_ - is equivalent to ``%m/%d/%y''.
  * _%d_ - is replaced by the day of the month as a decimal number (01-31).
  * _%e_ - is replaced by the day of the month as a decimal number (1-31); single digits are preceded by a blank.
  * _%F_ - is equivalent to ``%Y-%m-%d''.
  * _%G_ - is replaced by a year as a decimal number with century.  This year is the one that contains the greater part of the week (Monday as the first day of the week). (not yet supported)
  * _%g_ - is replaced by the same year as in ``%G'', but as a decimal number without century (00-99). (not yet supported)
  * _%H_ - is replaced by the hour (24-hour clock) as a decimal number (00-23).
  * _%h_ - the same as %b.
  * _%I_ - is replaced by the hour (12-hour clock) as a decimal number (01-12).
  * _%j_ - is replaced by the day of the year as a decimal number (001-366).
  * _%k_ - is replaced by the hour (24-hour clock) as a decimal number (0-23); single digits are preceded by a blank.
  * _%l_ - is replaced by the hour (12-hour clock) as a decimal number (1-12); single digits are preceded by a blank.
  * _%M_ - is replaced by the minute as a decimal number (00-59).
  * _%m_ - is replaced by the month as a decimal number (01-12).
  * _%n_ - is replaced by a newline.
  * _%p_ - is replaced by national representation of either "ante meridiem" (a.m.)  or "post meridiem" (p.m.)  as appropriate.
  * _%R_ - is equivalent to ``%H:%M''.
  * _%r_ - is equivalent to ``%I:%M:%S %p''.
  * _%S_ - is replaced by the second as a decimal number (00-60).
  * _%s_ - is replaced by the number of seconds since the Epoch, UTC (see mktime(3)).
  * _%T_ - is equivalent to ``%H:%M:%S''.
  * _%t_ - is replaced by a tab.
  * _%U_ - is replaced by the week number of the year (Sunday as the first day of the week) as a decimal number (00-53).
  * _%u_ - is replaced by the weekday (Monday as the first day of the week) as a decimal number (1-7).
  * _%V_ - is replaced by the week number of the year (Monday as the first day of the week) as a decimal number (01-53).  If the week containing January 1 has four or more days in the new year, then it is week 1; otherwise it is the last week of the previous year, and the next week is week 1. (not yet supported)
  * _%v_ - is equivalent to ``%e-%b-%Y''. (not yet supported)
  * _%W_ - is replaced by the week number of the year (Monday as the first day of the week) as a decimal number (00-53). (not yet supported)
  * _%w_ - is replaced by the weekday (Sunday as the first day of the week) as a decimal number (0-6). (not yet supported)
  * _%X_ - is replaced by national representation of the time. (not yet supported)
  * _%x_ - is replaced by national representation of the date. (not yet supported)
  * _%z_ - is replaced by the time zone offset from UTC; a leading plus sign stands for east of UTC, a minus sign for west of UTC, hours and minutes follow with two digits each and no delimiter between them (common form for RFC 822 date headers).
  """
  def strftime(format, datetime) when is_list(format) do
    strftime(:string, format, datetime, [])
  end
  def strftime(format, datetime) when is_bitstring(format) do
    strftime(String.to_char_list!(format), datetime)
  end

  defp strftime(:string, [], _, result) do
    list_to_bitstring result
  end

  defp strftime(:string, [?%|rest], datetime, result) do
    strftime(:format, rest, datetime, result)
  end

  defp strftime(:string, [any|rest], datetime, result) do
    strftime(:string, rest, datetime, result++[any])
  end

  # %%    is replaced by `%'.
  defp strftime(:format, [?%|rest], datetime, result) do
    strftime(:string, rest, datetime, result++[?%])
  end

  # %Z    is replaced by the time zone name.
  # TODO

  # %Y    is replaced by the year with century as a decimal number.
  defp strftime(:format, [?Y|rest], datetime, result) do
    strftime(:string, rest, datetime, result++String.to_char_list!("#{datetime.year}"))
  end

  # %y    is replaced by the year without century as a decimal number (00-99).
  defp strftime(:format, [?y|rest], datetime, result) do
    [_,_|y] = String.to_char_list!("#{datetime.year}")
    strftime(:string, rest, datetime, result++y)
  end

  # %A    is replaced by national representation of the full weekday name.
  # TODO

  # %a    is replaced by national representation of the abbreviated weekday name.
  # TODO

  # %B    is replaced by national representation of the full month name.
  # TODO

  # %b    is replaced by national representation of the abbreviated month name.
  # TODO

  # %C    is replaced by (year / 100) as decimal number; single digits are preceded by a zero.
  defp strftime(:format, [?C|rest], datetime, result) do
    strftime(:string, rest, datetime, result++int_to_padded_list(div(datetime.year, 100), 2))
  end

  # %c    is replaced by national representation of time and date.
  # TODO

  # %D    is equivalent to ``%m/%d/%y''.
  defp strftime(:format, [?D|rest], datetime, result) do
    strftime(:string, String.to_char_list!("%m/%d/%y")++rest, datetime, result)
  end

  # %d    is replaced by the day of the month as a decimal number (01-31).
  defp strftime(:format, [?d|rest], datetime, result) do
    strftime(:string, rest, datetime, result++int_to_padded_list(datetime.day, 2))
  end

  # %e    is replaced by the day of the month as a decimal number (1-31); single digits are preceded by a blank.
  defp strftime(:format, [?e|rest], datetime, result) do
    strftime(:string, rest, datetime, result++String.to_char_list!("#{datetime.day}"))
  end

  # %F    is equivalent to ``%Y-%m-%d''.
  defp strftime(:format, [?F|rest], datetime, result) do
    strftime(:string, String.to_char_list!("%Y-%m-%d")++rest, datetime, result)
  end

  # %G    is replaced by a year as a decimal number with century.  This year is the one that contains the greater part of the week (Monday as the first day of the week).
  # TODO

  # %g    is replaced by the same year as in ``%G'', but as a decimal number without century (00-99).
  # TODO

  # %H    is replaced by the hour (24-hour clock) as a decimal number (00-23).
  defp strftime(:format, [?H|rest], datetime, result) do
    strftime(:string, rest, datetime, result++int_to_padded_list(datetime.hour, 2))
  end

  # %h    the same as %b.
  defp strftime(:format, [?h|rest], datetime, result) do
    strftime(:string, String.to_char_list!("%b")++rest, datetime, result)
  end

  # %I    is replaced by the hour (12-hour clock) as a decimal number (01-12).
  defp strftime(:format, [?I|rest], datetime, result) do
    value = to_twelve(datetime.hour)
    strftime(:string, rest, datetime, result++int_to_padded_list(value, 2))
  end

  # %j    is replaced by the day of the year as a decimal number (001-366).
  defp strftime(:format, [?j|rest], datetime, result) do
    strftime(:string, rest, datetime, result++int_to_padded_list(datetime.day_of_year, 3))
  end

  # %k    is replaced by the hour (24-hour clock) as a decimal number (0-23); single digits are preceded by a blank.
  defp strftime(:format, [?k|rest], datetime, result) do
    strftime(:string, rest, datetime, result++int_to_list(datetime.hour))
  end

  # %l    is replaced by the hour (12-hour clock) as a decimal number (1-12); single digits are preceded by a blank.
  defp strftime(:format, [?l|rest], datetime, result) do
    value = to_twelve(datetime.hour)
    strftime(:string, rest, datetime, result++int_to_list(value))
  end

  # %M    is replaced by the minute as a decimal number (00-59).
  defp strftime(:format, [?M|rest], datetime, result) do
    strftime(:string, rest, datetime, result++int_to_padded_list(datetime.minute, 2))
  end

  # %m    is replaced by the month as a decimal number (01-12).
  defp strftime(:format, [?m|rest], datetime, result) do
    strftime(:string, rest, datetime, result++int_to_padded_list(datetime.month, 2))
  end

  # %n    is replaced by a newline.
  defp strftime(:format, [?n|rest], datetime, result) do
    strftime(:string, rest, datetime, result++['\n'])
  end

  # %p    is replaced by national representation of either "ante meridiem" (a.m.)  or "post meridiem" (p.m.)  as appropriate.
  defp strftime(:format, [?p|rest], datetime, result) do
    ampm = "PM"
    if(datetime.hour > 0 and datetime.hour < 13) do
      ampm = "AM"
    end
    strftime(:string, rest, datetime, result++String.to_char_list!(ampm))
  end

  # %R    is equivalent to ``%H:%M''.
  defp strftime(:format, [?R|rest], datetime, result) do
    strftime(:string, String.to_char_list!("%H:%M")++rest, datetime, result)
  end

  # %r    is equivalent to ``%I:%M:%S %p''.
  defp strftime(:format, [?r|rest], datetime, result) do
    strftime(:string, String.to_char_list!("%I:%M:%S %p")++rest, datetime, result)
  end

  # %S    is replaced by the second as a decimal number (00-60).
  defp strftime(:format, [?S|rest], datetime, result) do
    strftime(:string, rest, datetime, result++int_to_padded_list(datetime.second, 2))
  end

  # %s    is replaced by the number of seconds since the Epoch, UTC (see mktime(3)).
  defp strftime(:format, [?s|rest], datetime, result) do
    strftime(:string, rest, datetime, result++int_to_list(datetime.epoch))
  end

  # %T    is equivalent to ``%H:%M:%S''.
  defp strftime(:format, [?T|rest], datetime, result) do
    strftime(:string, String.to_char_list!("%H:%M:%S")++rest, datetime, result)
  end

  # %t    is replaced by a tab.
  defp strftime(:format, [?t|rest], datetime, result) do
    strftime(:string, rest, datetime, result++['\t'])
  end

  # %U    is replaced by the week number of the year (Sunday as the first day of the week) as a decimal number (00-53).
  defp strftime(:format, [?U|rest], datetime, result) do
    strftime(:string, rest, datetime, result++int_to_padded_list(datetime.week_number, 2))
  end

  # %u    is replaced by the weekday (Monday as the first day of the week) as a decimal number (1-7).
  defp strftime(:format, [?u|rest], datetime, result) do
    strftime(:string, rest, datetime, result++int_to_list(datetime.day_of_the_week))
  end

  # %V    is replaced by the week number of the year (Monday as the first day of the week) as a decimal number (01-53).  If the week containing January 1 has four or more days in the new year, then it is week 1; otherwise it is the last week of the previous year, and the next week is week 1.
  # TODO

  # %v    is equivalent to ``%e-%b-%Y''.
  # TODO

  # %W    is replaced by the week number of the year (Monday as the first day of the week) as a decimal number (00-53).
  # TODO

  # %w    is replaced by the weekday (Sunday as the first day of the week) as a decimal number (0-6).
  # TODO

  # %X    is replaced by national representation of the time.
  # TODO

  # %x    is replaced by national representation of the date.
  # TODO

  # %z    is replaced by the time zone offset from UTC; a leading plus sign stands for east of UTC, a minus sign for west of UTC, hours and minutes follow with two digits each and no delimiter between them (common form for RFC 822 date headers).
  defp strftime(:format, [?z|rest], datetime, result) do
    utcs = "UTC+#{datetime.utc}"
    if datetime.utc < 0 do
      utcs = "UTC#{datetime.utc}"
    end
    strftime(:string, rest, datetime, result++String.to_char_list!(utcs))
  end

  defp int_to_padded_list(i, pad) do
    value = int_to_list(i)
    rec = {value, i}
    l = Enum.map 0..(pad-1), fn i -> i end
    {value, _} = List.foldl l, rec, fn(x, s) -> {value,i} = s; if(:math.pow(10, x) > i) do;  value = [?0|value]; end; {value, i} end
    value
  end
  defp int_to_list(i) do
    String.to_char_list!("#{i}")
  end
  defp to_twelve(h) do
    result = h
    if(h == 0) do
      result = 12
    else
      if(h > 12) do
        result = h - 12
      end
    end
    result
  end

  @doc """
  Parse the given string and return the corresponding Calendar.DateTime

  ## Example

      iex> Calendar.parse("2010-09-01 20:49:05 UTC-4")
      Calendar.DateTime[year: 2010, month: 9, day: 1, hour: 20, minute: 49, second: 5,
       utc: -4]
      iex> Calendar.parse("2010-09-01T20:49:05.185Z")
      Calendar.DateTime[year: 2010, month: 9, day: 1, hour: 20, minute: 49, second: 5,
       utc: 0]
  """
  def parse(str) do
    parse(tokenize(String.to_char_list!(String.upcase(str)), []), now())
  end

  defp is_meridian(pm) do
    pm == <<"AM">> or pm == <<"PM">>
  end
  defp hour(hour, <<"AM">>) do
    hour
  end
  defp hour(hour, <<"PM">>) do
    hour + 12
  end

  defp parse([], datetime) do
    datetime
  end
  # yyyy-mm-jj
  defp parse([year, sep, month, sep, day | rest], datetime) when year >= 1000 and month in 1..12 and day in 1..31 and sep in [?/, ?-] do
    datetime = DateTime[
      year: year,
      month: month,
      day: day,
      hour: datetime.hour,
      minute: datetime.minute,
      second: datetime.second
    ]
    parse(rest, datetime)
  end
  # jj-mm-yyyy
  defp parse([day, sep, month, sep, year | rest], datetime) when year > 1000 and month in 1..12 and day in 1..31 and sep in [?/, ?-] do
    datetime = DateTime[
      year: year,
      month: month,
      day: day,
      hour: datetime.hour,
      minute: datetime.minute,
      second: datetime.second
    ]
    parse(rest, datetime)
  end
  # hh:mm:jj pm
  defp parse([hour, ?:, minute, ?:, second, pm | rest], datetime) when hour in 0..23 and minute in 0..59 and second in 0..59 do
    if is_meridian(pm) do
      hour = hour(hour, pm)
    else
      rest = [pm] ++ rest
    end
    datetime = DateTime[
      year: datetime.year,
      month: datetime.month,
      day: datetime.day,
      hour: hour,
      minute: minute,
      second: second
    ]
    parse(rest, datetime)
  end
  # hh:mm pm
  defp parse([hour, ?:, minute, pm | rest], datetime) when hour in 0..23 and minute in 0..59 do
    if is_meridian(pm) do
      hour = hour(hour, pm)
    else
      rest = [pm] ++ rest
    end
    datetime = DateTime[
      year: datetime.year,
      month: datetime.month,
      day: datetime.day,
      hour: hour,
      minute: minute,
      second: datetime.second
    ]
    parse(rest, datetime)
  end
  # UTC+/-X
  defp parse([{:utc, v} | rest], datetime) do
    datetime = DateTime[
      year: datetime.year,
      month: datetime.month,
      day: datetime.day,
      hour: datetime.hour,
      minute: datetime.minute,
      second: datetime.second,
      utc: v
    ]
    parse(rest, datetime)
  end
  defp parse([_ | rest], datetime) do
    #:io.format("Ignore ~p~n",[e])
    parse(rest, datetime)
  end

  defp tokenize([], result) do
    result
  end
  defp tokenize([n1, n2, n3, n4 | rest], result) when n1 in ?0..?9 and n2 in ?0..?9 and n3 in ?0..?9 and n4 in ?0..?9 do
    tokenize(rest, result++[list_to_integer([n1, n2, n3, n4])])
  end
  defp tokenize([n1, n2, n3 | rest], result) when n1 in ?0..?9 and n2 in ?0..?9 and n3 in ?0..?9 do
    tokenize(rest, result++[list_to_integer([n1, n2, n3])])
  end
  defp tokenize([n1, n2 | rest], result) when n1 in ?0..?9 and n2 in ?0..?9 do
    tokenize(rest, result++[list_to_integer([n1, n2])])
  end
  defp tokenize([n1 | rest], result) when n1 in ?0..?9 do
    tokenize(rest, result++[list_to_integer([n1])])
  end
  defp tokenize([sep | rest], result) when sep in [?:, ?/, ?-]do
    tokenize(rest, result++[sep])
  end
  defp tokenize([?A, ?M | rest], result) do
    tokenize(rest, result++["AM"])
  end
  defp tokenize([?P, ?M | rest], result) do
    tokenize(rest, result++["PM"])
  end
  defp tokenize([?U, ?T, ?C, pm, v | rest], result) when pm in [?+, ?-] and is_integer(v) do
    tokenize(rest, result++[{:utc, list_to_integer([pm, v])}])
  end
  defp tokenize([32 | rest], result) do
    tokenize(rest, result)
  end
  defp tokenize([t | rest], result) do
    tokenize(rest, result++[{:unknown, t}])
  end

  # http://www.gmarts.org/index.php?go=415#geteasterdatec
  @doc """
  Returns the date for Easter (Roman Catholic) in `year'

  ## Example

      iex> Calendar.easter(2012)
      Calendar.DateTime[year: 2012, month: 4, day: 8, hour: 0, minute: 0, second: 0,
       utc: 0]
  """
  def easter(year) do
    ncent = div(year, 100)
    nremain19 = rem(year, 19)
    n1tmp1 = fix(ncent, div((ncent - 15), 2) + 202 - (11 * nremain19))
    n1tmp2 = rem(n1tmp1, 30)
    n1 = case n1tmp2 == 29 or (n1tmp2 == 28 and nremain19 > 10) do
      true -> n1tmp2 - 1
      false -> n1tmp2
    end
    dtpfm = case n1 > 10 do
      true -> {year, 4, n1 - 10}
      false -> {year, 3, n1 + 21}
    end
    nweekday = rem(:calendar.day_of_the_week(dtpfm), 7)
    datetime({dtpfm, {0, 0, 0}}).add(7 - nweekday, :days)
  end

  defp fix(c, n) when c >= 38 do
    n - 2
  end
  defp fix(c, n) when c == 21 or c == 24 or c == 25 do
    n - 1
  end
  defp fix(c, n) when c == 33 or c == 36 or c == 37 do
    n - 2
  end
  defp fix(c, n) when c > 26 do
    n - 1
  end
  defp fix(_, n) do
    n
  end
end
