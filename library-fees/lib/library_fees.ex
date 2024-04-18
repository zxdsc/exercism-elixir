defmodule LibraryFees do
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  def before_noon?(datetime) do
    NaiveDateTime.to_time(datetime)
    |> Time.before?(~T[12:00:00])
  end

  def return_date(checkout_datetime) do
    days =
      case before_noon?(checkout_datetime) do
        true -> 28
        false -> 29
      end

    NaiveDateTime.add(checkout_datetime, days, :day) |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    dif = Date.diff(actual_return_datetime, planned_return_date)
    if dif > 0, do: dif, else: 0
  end

  def monday?(datetime) do
    day =
      NaiveDateTime.to_date(datetime)
      |> Date.day_of_week()

    day == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_dt = datetime_from_string(checkout)
    actual_return = datetime_from_string(return)
    return_date = return_date(checkout_dt)
    days = days_late(return_date, actual_return)
    fee = days * rate
    if monday?(actual_return), do: floor(fee / 2) , else: fee
  end
end
