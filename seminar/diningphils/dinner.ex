defmodule Dinner do
    def start(), do: spawn(fn -> init() end)

    def wait(0, chopsticks) do
        Enum.each(chopsticks, fn(c) -> Chopstick.quit(c) end)
    end
    def wait(n, chopsticks) do
        #IO.puts("whodis")
        receive do
            :done ->
                wait(n-1, chopsticks)
            :abort ->
                Process.exit(self(), :kill)
        end
    end

    def init() do
        c1 = Chopstick.start()
        c2 = Chopstick.start()
        c3 = Chopstick.start()
        c4 = Chopstick.start()
        c5 = Chopstick.start()
        ctrl = self()
        Philosopher.start(5, c1, c2, "Arne", ctrl)
        Philosopher.start(5, c2, c3, "Bengt", ctrl)
        Philosopher.start(5, c3, c4, "Carl", ctrl)
        Philosopher.start(5, c4, c5, "David", ctrl)
        Philosopher.start(5, c1, c5, "Evert", ctrl)
        wait(5, [c1,c2,c3,c4,c5])
    end
end
