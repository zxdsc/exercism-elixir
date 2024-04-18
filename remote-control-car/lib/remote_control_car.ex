defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(), do: %RemoteControlCar{nickname: "none"}

  def new(nickname), do: %RemoteControlCar{nickname: nickname}

  def display_distance(%RemoteControlCar{} = rcc),
    do: "#{Map.fetch!(rcc, :distance_driven_in_meters)} meters"

  def display_battery(%RemoteControlCar{battery_percentage: 0}), do: "Battery empty"
  def display_battery(%RemoteControlCar{battery_percentage: bp}), do: "Battery at #{bp}%"

  def drive(%RemoteControlCar{battery_percentage: 0} = car), do: car

  def drive(%RemoteControlCar{battery_percentage: bp, distance_driven_in_meters: ds} = car) do
    %{car | battery_percentage: bp - 1, distance_driven_in_meters: ds + 20}
  end
end
