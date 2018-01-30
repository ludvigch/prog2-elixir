defmodule Eager do
    def eval_expr({:atm, id}, _), do: {:ok, id}

    def eval_expr({:var, id}, env) do
        case Env.lookup(id, env) do
            nil -> :error
            {_, str} -> {:ok, str}
        end
    end

    def eval_expr({:cons, {typea, ida}, {typeb, idb}}, env) do
        case eval_expr({typea, ida}, env) do
            :error -> :error
            {:ok, stra} ->
                case eval_expr({typeb, idb}, env) do
                    :error -> :error
                    {:ok, strb} -> {stra, strb}
                end
        end
    end
end
