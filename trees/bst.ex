# a node is defined as a quintuple: {:node, value, left, right}
defmodule BST do
    def insert(key, value, :nil), do: {:node, key, value, :nil, :nil}
    def insert(key, value, {:node, k, v, left, right}) do
        if key < k do
            {:node, k, v, insert(key, value, left), right}
        else
            {:node, k, v, left, insert(key, value, right)}
        end
    end

    def modify(_, _, :nil), do: :nil
    def modify(key, val, {:node, key, _, left, right}) do
        {:node, key, val, left, right}
    end
    def modify(key, val, {:node, k, v, left, right}) do
        if key < k do
            {:node, k, v, modify(key, val, left), right}
        else
            {:node, k, v, left, modify(key, val, right)}
        end
    end

    def delete(key, {:node, key, _, :nil, :nil}), do: :nil
    def delete(key, {:node, key, _, left, :nil}), do: left
    def delete(key, {:node, key, _, :nil, right}), do: right
    def delete(key, {:node, key, _, left, right}) do
        {:node, elem(left, 0), elem(left, 1), delete(elem(left, 0), left), right}
    end
    def delete(key, {:node, k, v, left, right}) do
        if key < k do
            {:node, k, v, delete(key, left), right}
        else
            {:node, k, v, left, delete(key, right)}
        end
    end

end
