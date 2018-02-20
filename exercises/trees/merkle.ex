defmodule Merkle do
    def hash(data) do
        :crypto.hash(:sha256, data) |> Base.encode16 |> String.downcase
    end

    
end
