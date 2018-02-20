defmodule Philosopher do
    def sleep(t) do
        :timer.sleep(:rand.uniform(t))
    end

    def start(hunger, right, left, name, ctrl) do
        philosopher = spawn_link(fn ->
            dreaming(hunger, right, left, name, ctrl)
        end)
    end

    def dreaming(0, _right, _left, name, ctrl) do
        IO.puts("#{name} is full")
        send(ctrl, :done)
        sleep(500)
        #IO.puts("sent shutdown signal")
        #Process.exit(self(), :normal)
    end

    def dreaming(hunger, right, left, name, ctrl) do
        sleep(400)
        request_left(hunger, right, left, name, ctrl)
    end

    def request_left(hunger, right, left, name, ctrl) do
        case Chopstick.request(left, 100) do
            :ok ->  IO.puts("#{name} picked up left")
                    request_right(hunger, right, left, name, ctrl)
            :no ->  IO.puts("#{name} tried picking up left")
                    Chopstick.return(left)
                    dreaming(hunger, right, left, name, ctrl)
        end
    end

    def request_right(hunger, right, left, name, ctrl) do
        case Chopstick.request(right, 100) do
            :ok ->  IO.puts("#{name} picked up right")
                    eat(hunger, right, left, name, ctrl)
            :no ->  IO.puts("#{name} tried picking up right")
                    Chopstick.return(left)
                    Chopstick.return(right)
                    dreaming(hunger, right, left, name, ctrl)
        end
    end

    def eat(hunger, right, left, name, ctrl) do
        IO.puts("#{name} starts eating")
        sleep(200)
        IO.puts("#{name} is done eating")
        case Chopstick.return(left) do
            :ok ->  IO.puts("#{name} returned left chopstick")
                    case Chopstick.return(right) do
                        :ok ->  IO.puts("#{name} returned right chopstick")
                                dreaming(hunger-1, right, left, name, ctrl)
                    end
        end
    end


end
