# implementation of caesar cipher
defmodule Caesar do
    # PoC function
    def test() do
        text = 'foo'
        key = 5
        cipher = encrypt(text, key)
        #IO.inspect cipher
        decrypt(cipher, key)
    end

    def encrypt([], _), do: []
    def encrypt([char|rest], key) do
        [encryptchar(char, key) | encrypt(rest, key)]
    end

    def encryptchar(char, key), do: rem(char+key-97, 26)

    def decrypt([], _), do: []
    def decrypt([char|rest], key) do
        [decryptchar(char, key) | decrypt(rest, key)]
    end

    def decryptchar(char, key), do: char-rem(key, 26)+97
end
