defmodule Chopstick do
    def start() do
        stick = spawn_link(fn -> available() end)
    end

    defp available() do
        receive do
            {:request, pid} -> send(pid, :ok)
                               gone()
            :quit -> :ok
        end
    end

    defp gone() do
        receive do
            {:return, pid} -> send(pid, :ok)
                              available()
            :quit -> :ok
        end
    end

    def quit(c) do
        send(c, :quit)
    end

    def request(stick, timeout) do
        send(stick, {:request, self()})
        receive do
            :ok -> :ok
        after 
            timeout -> :no
        end
    end

    def return(stick) do
        send(stick, {:return, self()})
        receive do
            :ok -> :ok
        end
    end
end
