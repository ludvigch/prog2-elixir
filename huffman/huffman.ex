defmodule Huffman do
    def sample do
        'the quick brown fox jumps over tha lazy dog
        this is a sample text that we will user when we build
        up a table we will only handle lower case letters and
        no punctuation symbols the frequency will of course not
        represent english but it is probably not that far off'
    end

    def text, do: 'this is something that we should encode'

    def test do
        sample = sample()
        tree = tree(sample)
        encode = encode_table(tree)
        decode = decode_table(tree)
        text = text()
        seq = encode(text, encode)
        decode(seq, decode)
    end

    def freq(sample), do: freq(sample, %{})

    def freq([], map), do: Map.to_list(map)
    def freq([h|t], map) do
        import Elixir.Map
        case val=get(map, h) do
            nil -> freq(t, put(map, h, 1))
            _   -> freq(t, put(map, h, val+1))
        end
    end

    def tree(sample) do
        sorted = freq(sample) |> List.keysort(1)
        buildtree(sorted)
    end

    defp buildtree([_ | []]=l), do: l
    defp buildtree([s1|[s2|t]]) do
        buildtree(List.keysort([makenode(s1,s2)|t], 1))
    end

    defp makenode({c1, f1}, {c2,f2}), do: {{c1,c2}, f1+f2}

    def encode_table(tree) do
        
    end

    def decode_table(tree) do
        tree
    end

    def encode(text, table) do
        text
    end

    def decode(seq, tree) do
        seq
    end
end
