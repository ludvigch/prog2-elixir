defmodule Eager do
    def eval_expr({:atm, id}, _), do: {:ok, id}

    def eval_expr({:var, id}, env) do
        case Env.lookup(id, env) do
            nil -> :error
            {_, str} -> {:ok, str}
        end
    end

    def eval_expr({:cons, hp, tp}, env) do
        case eval_expr(hp, env) do
            :error -> :error
            {:ok, stra} ->
                case eval_expr(tp, env) do
                    :error -> :error
                    {:ok, strb} -> {stra, strb}
                end
        end
    end

    def eval_match(:ignore, _, env), do: {:ok, env}
    def eval_match({:atm, _}, _, env), do: {:ok, env}

    def eval_match({:var, id}, str, env) do
        case Env.lookup(id, env) do
            nil -> {:ok, Env.add(id, str, env)}
            {_, ^str} -> {:ok, env}
            {_,_} -> :fail
        end
    end

    def eval_match({:cons, hp, tp}, {:cons, hp2, tp2}, env) do
        case eval_match(hp, hp2, env) do
            :fail -> :fail
            {:ok, newenv} ->
                #IO.inspect newenv
                eval_match(tp, tp2, newenv)
        end
    end

    def eval_match(_,_,_), do: :fail

end
