defmodule Blockcipher do
    # Dependency: init by compiling caesar.ex
    def test() do
        text = 'strikeatdawn'
        key = 'caesar'
        IO.puts("encrypting '#{text}' with key '#{key}'")
        cipher = encrypt(text, key)
        IO.puts("ciphertext generated: #{cipher}")
        clear = decrypt(cipher, key)
        IO.puts("decrypted ciphertext: #{clear}")
    end

    def encrypt(text, key) do
        encrypt(text, key, 0, length(key))
    end
    defp encrypt([], _, _, _), do: []
    defp encrypt([char|rest], key, i, keylen) do
        keyindex = rem(i, keylen)
        [Caesar.encryptchar(char, elem(Enum.fetch(key, keyindex), 1)-97)
        | encrypt(rest, key, i+1, keylen)]
    end

    def decrypt(text, key) do
        decrypt(text, key, 0, length(key))
    end
    defp decrypt([], _, _, _), do: []
    defp decrypt([char|rest], key, i, keylen) do
        keyindex = rem(i, keylen)
        [Caesar.decryptchar(char, elem(Enum.fetch(key, keyindex), 1)-97)
        | decrypt(rest, key, i+1, keylen)]
    end
end
