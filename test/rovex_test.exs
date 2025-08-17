defmodule RoverTest do
  use ExUnit.Case

  test "get_state should return current state" do
    {:ok, _} = Rover.start_link({9, 9, :N, "rover0"})
    {:ok, state} = Rover.get_state("rover0")
    assert state == {9, 9, :N}
  end

  test "go_forward should update rover position" do
    {:ok, _} = Rover.start_link({0, 0, :N, "rover1"})
    Rover.go_forward("rover1")
    {:ok, state} = Rover.get_state("rover1")
    assert state == {0, 1, :N}
  end

  test "handle_cast :go_forward should return updated state" do
    {:noreply, state} = Rover.handle_cast(:go_forward, %Rover{x: 1, y: 3, direction: :N})
    assert state.x == 1
    assert state.y == 4
    assert state.direction == :N
  end

  test "handle_cast :rotate_left should return updated state (N)" do
    {:noreply, state} = Rover.handle_cast(:rotate_left, %Rover{x: 1, y: 3, direction: :N})
    assert state.x == 1
    assert state.y == 3
    assert state.direction == :W
  end
end
