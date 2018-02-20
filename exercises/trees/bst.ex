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

    def modify(_, _, :nil), do: :nosuchkey
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

    def lookup(key, {:node, key, v, _, _}), do: {:found, key, v}
    def lookup(key, {:node, k, _, left, _}) when key < k and left != :nil, do: lookup(key, left)
    def lookup(key, {:node, _k, _, _, right}) when right != :nil, do: lookup(key, right)
    def lookup(_key, {:node, _k, _, :nil, :nil}), do: :nosuchkey
    def lookup(_key, :nil), do: :nosuchkey

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
