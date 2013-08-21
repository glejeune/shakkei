Code.require_file "test_helper.exs", __DIR__

defmodule DigestTest do
  use ExUnit.Case

  test "Simple MD4 test" do
    assert('11485b1454ba6ae6038d64c766fd9a8f' == Digest.md4("greg") |> Digest.hexdigest)
  end

  test "Simple MD5 test" do
    assert('ea26b0075d29530c636d6791bb5d73f4' == Digest.md5("greg") |> Digest.hexdigest)
  end

  test "Simple SHA1 test" do
    assert('79e2475f81a6317276bf7cbb3958b20d289b78df' == Digest.sha1("greg") |> Digest.hexdigest)
  end

  test "Simple SHA224 test" do
    assert('7dd4ddb8babe98392ae80473e6daadd3fdc8c0159736c3e5d57205de' == Digest.sha224("greg") |> Digest.hexdigest)
  end

  test "Simple SHA256 test" do
    assert('7dd4ddb8babe98392ae80473e6daadd3fdc8c0159736c3e5d57205de' == Digest.sha224("greg") |> Digest.hexdigest)
  end

  test "Simple SHA384 test" do
    assert('f2db58b6dde1333f70cab1a612cc6a515784da954bbdb284c3a71dde03b4e8f9d58dd064fb455339162d67f0d80680f6' == Digest.sha384("greg") |> Digest.hexdigest)
  end

  test "Simple SHA512 test" do
    assert('e054dfcc191f1901e1e7c5d90ef6dff878f68ee7d4cdddab3b36ad451fb20d4d24f0f309a24d3f591c1df64a8d9660f531d5e710b66f70fa4b50857fdf010d58' == Digest.sha512("greg") |> Digest.hexdigest)
  end

  test "rand bytes" do
    assert("" != Digest.hexdigest(Digest.rand_bytes(32)))
  end

  test "MD4 by update" do
    digest = Digest.hash_init(:md4) 
      |> Digest.hash_update("Hello ")
      |> Digest.hash_update("World!")
      |> Digest.hash_final()
    assert(Digest.md4("Hello World!") == digest)
  end

  test "MD5 by update" do
    digest = Digest.hash_init(:md5) 
      |> Digest.hash_update("Hello ")
      |> Digest.hash_update("World!")
      |> Digest.hash_final()
    assert(Digest.md5("Hello World!") == digest)
  end

  test "SHA1 by update" do
    digest = Digest.hash_init(:sha) 
      |> Digest.hash_update("Hello ")
      |> Digest.hash_update("World!")
      |> Digest.hash_final()
    assert(Digest.sha1("Hello World!") == digest)
  end

  test "SHA224 by update" do
    digest = Digest.hash_init(:sha224) 
      |> Digest.hash_update("Hello ")
      |> Digest.hash_update("World!")
      |> Digest.hash_final()
    assert(Digest.sha224("Hello World!") == digest)
  end

  test "SHA256 by update" do
    digest = Digest.hash_init(:sha256) 
      |> Digest.hash_update("Hello ")
      |> Digest.hash_update("World!")
      |> Digest.hash_final()
    assert(Digest.sha256("Hello World!") == digest)
  end

  test "SHA384 by update" do
    digest = Digest.hash_init(:sha384) 
      |> Digest.hash_update("Hello ")
      |> Digest.hash_update("World!")
      |> Digest.hash_final()
    assert(Digest.sha384("Hello World!") == digest)
  end

  test "SHA512 by update" do
    digest = Digest.hash_init(:sha512) 
      |> Digest.hash_update("Hello ")
      |> Digest.hash_update("World!")
      |> Digest.hash_final()
    assert(Digest.sha512("Hello World!") == digest)
  end

  test "HMAC MD5" do
    digest = Digest.hmac_init(:md5, "mys3cr3tk3Y")
      |> Digest.hmac_update("Hello ")
      |> Digest.hmac_update("World!")
      |> Digest.hmac_final()
    assert(Digest.hmac(:md5, "mys3cr3tk3Y", "Hello World!") == digest)
    assert(Digest.md5_hmac("mys3cr3tk3Y", "Hello World!") == digest)
  end

  test "HMAC SHA1" do
    digest = Digest.hmac_init(:sha, "mys3cr3tk3Y")
      |> Digest.hmac_update("Hello ")
      |> Digest.hmac_update("World!")
      |> Digest.hmac_final()
    assert(Digest.hmac(:sha, "mys3cr3tk3Y", "Hello World!") == digest)
    assert(Digest.sha1_hmac("mys3cr3tk3Y", "Hello World!") == digest)
  end

  test "HMAC SHA224" do
    digest = Digest.hmac_init(:sha224, "mys3cr3tk3Y")
      |> Digest.hmac_update("Hello ")
      |> Digest.hmac_update("World!")
      |> Digest.hmac_final()
    assert(Digest.hmac(:sha224, "mys3cr3tk3Y", "Hello World!") == digest)
    assert(Digest.sha224_hmac("mys3cr3tk3Y", "Hello World!") == digest)
  end

  test "HMAC SHA256" do
    digest = Digest.hmac_init(:sha256, "mys3cr3tk3Y")
      |> Digest.hmac_update("Hello ")
      |> Digest.hmac_update("World!")
      |> Digest.hmac_final()
    assert(Digest.hmac(:sha256, "mys3cr3tk3Y", "Hello World!") == digest)
    assert(Digest.sha256_hmac("mys3cr3tk3Y", "Hello World!") == digest)
  end

  test "HMAC SHA384" do
    digest = Digest.hmac_init(:sha384, "mys3cr3tk3Y")
      |> Digest.hmac_update("Hello ")
      |> Digest.hmac_update("World!")
      |> Digest.hmac_final()
    assert(Digest.hmac(:sha384, "mys3cr3tk3Y", "Hello World!") == digest)
    assert(Digest.sha384_hmac("mys3cr3tk3Y", "Hello World!") == digest)
  end

  test "HMAC SHA512" do
    digest = Digest.hmac_init(:sha512, "mys3cr3tk3Y")
      |> Digest.hmac_update("Hello ")
      |> Digest.hmac_update("World!")
      |> Digest.hmac_final()
    assert(Digest.hmac(:sha512, "mys3cr3tk3Y", "Hello World!") == digest)
    assert(Digest.sha512_hmac("mys3cr3tk3Y", "Hello World!") == digest)
  end
end
