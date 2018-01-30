defmodule Env do
    # return a new empty environment
    def new(), do: []

    # add binding to existing environment
    def add(id, str, []), do: [{id, str}]
    def add(id, str, [h|rest]) do
        [h | add(id, str, rest)]
    end

    # lookup if id is bound to a datastructure, if true return {id, str} else :nil
    def lookup(_, []), do: :nil
    def lookup(id, [h|rest]) do
        if id == elem(h, 0) do
            h
        else
            lookup(id, rest)
        end
    end

    # return environment where bindings for all ids in list ids are removed
    def remove([], env), do: env
    def remove([id|rest], env) do
        remove(rest, List.keydelete(env, id, 0))
    end

end
