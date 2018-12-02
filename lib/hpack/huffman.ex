defmodule HPack.Huffman do
  @moduledoc """
    Huffman static table de/encoding as defined in RFC 7541.
  """

  @doc """
    Decodes a Huffman encoded string with the HPACK static table.

    Returns the decoded String.

  ### Examples

      iex> HPack.Huffman.decode(<< 0x27::6, 0x5::5, 0x28::6, 0x28::6, 0x7::5 >>)
      "hello"

  """
  @spec decode(binary) :: String.t()
  def decode(encoded) do
    dec(encoded, bit_size(encoded), <<>>)
  end

  @doc """
    Huffman encodes a string using the HPACK static table.

    Returns the encoded String.

  ### Examples

      iex> HPack.Huffman.encode("hello")
      <<0x9c, 0xb4, 0x50, 0x7f>>
  """
  @spec encode(String.t()) :: binary
  def encode(string) do
    enc(string, <<>>)
  end

  # eos
  defp enc(<<>>, <<bin::binary>>), do: bin
  defp enc(<<>>, <<bin::bitstring>>), do: enc(<<>>, <<bin::bitstring, 1::1>>)

  # static huffman encoding table
  defp enc(<<244>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFE7::27>>)
  defp enc(<<245>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFE8::27>>)
  defp enc(<<246>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFE9::27>>)
  defp enc(<<247>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFEA::27>>)
  defp enc(<<248>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFEB::27>>)
  defp enc(<<249>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFFE::28>>)
  defp enc(<<250>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFEC::27>>)
  defp enc(<<251>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFED::27>>)
  defp enc(<<252>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFEE::27>>)
  defp enc(<<253>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFEF::27>>)
  defp enc(<<254>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFF0::27>>)
  defp enc(<<255>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFEE::26>>)
  defp enc(<<207>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFFED::25>>)
  defp enc(<<208>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFF2::19>>)
  defp enc(<<209>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFE3::21>>)
  defp enc(<<210>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFE6::26>>)
  defp enc(<<211>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFE0::27>>)
  defp enc(<<212>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFE1::27>>)
  defp enc(<<213>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFE7::26>>)
  defp enc(<<214>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFE2::27>>)
  defp enc(<<215>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFF2::24>>)
  defp enc(<<216>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFE4::21>>)
  defp enc(<<217>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFE5::21>>)
  defp enc(<<218>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFE8::26>>)
  defp enc(<<219>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFE9::26>>)
  defp enc(<<220>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFFD::28>>)
  defp enc(<<221>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFE3::27>>)
  defp enc(<<222>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFE4::27>>)
  defp enc(<<223>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFE5::27>>)
  defp enc(<<224>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFEC::20>>)
  defp enc(<<225>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFF3::24>>)
  defp enc(<<226>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFED::20>>)
  defp enc(<<227>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFE6::21>>)
  defp enc(<<228>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFE9::22>>)
  defp enc(<<229>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFE7::21>>)
  defp enc(<<230>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFE8::21>>)
  defp enc(<<231>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFF3::23>>)
  defp enc(<<232>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFEA::22>>)
  defp enc(<<233>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFEB::22>>)
  defp enc(<<234>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFFEE::25>>)
  defp enc(<<235>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFFEF::25>>)
  defp enc(<<236>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFF4::24>>)
  defp enc(<<237>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFF5::24>>)
  defp enc(<<238>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFEA::26>>)
  defp enc(<<239>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFF4::23>>)
  defp enc(<<240>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFEB::26>>)
  defp enc(<<241>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFE6::27>>)
  defp enc(<<242>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFEC::26>>)
  defp enc(<<243>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFED::26>>)
  defp enc(<<117>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x2D::6>>)
  defp enc(<<118>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x77::7>>)
  defp enc(<<119>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x78::7>>)
  defp enc(<<120>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x79::7>>)
  defp enc(<<121>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7A::7>>)
  defp enc(<<122>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7B::7>>)
  defp enc(<<123>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFE::15>>)
  defp enc(<<124>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FC::11>>)
  defp enc(<<125>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFD::14>>)
  defp enc(<<126>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFD::13>>)
  defp enc(<<127>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFFC::28>>)
  defp enc(<<128>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFE6::20>>)
  defp enc(<<129>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFD2::22>>)
  defp enc(<<130>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFE7::20>>)
  defp enc(<<131>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFE8::20>>)
  defp enc(<<132>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFD3::22>>)
  defp enc(<<133>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFD4::22>>)
  defp enc(<<134>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFD5::22>>)
  defp enc(<<135>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFD9::23>>)
  defp enc(<<136>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFD6::22>>)
  defp enc(<<137>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFDA::23>>)
  defp enc(<<138>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFDB::23>>)
  defp enc(<<139>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFDC::23>>)
  defp enc(<<140>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFDD::23>>)
  defp enc(<<141>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFDE::23>>)
  defp enc(<<142>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFEB::24>>)
  defp enc(<<143>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFDF::23>>)
  defp enc(<<144>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFEC::24>>)
  defp enc(<<145>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFED::24>>)
  defp enc(<<146>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFD7::22>>)
  defp enc(<<147>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFE0::23>>)
  defp enc(<<148>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFEE::24>>)
  defp enc(<<149>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFE1::23>>)
  defp enc(<<150>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFE2::23>>)
  defp enc(<<151>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFE3::23>>)
  defp enc(<<152>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFE4::23>>)
  defp enc(<<153>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFDC::21>>)
  defp enc(<<154>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFD8::22>>)
  defp enc(<<155>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFE5::23>>)
  defp enc(<<156>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFD9::22>>)
  defp enc(<<157>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFE6::23>>)
  defp enc(<<158>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFE7::23>>)
  defp enc(<<159>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFEF::24>>)
  defp enc(<<160>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFDA::22>>)
  defp enc(<<161>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFDD::21>>)
  defp enc(<<162>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFE9::20>>)
  defp enc(<<163>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFDB::22>>)
  defp enc(<<164>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFDC::22>>)
  defp enc(<<165>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFE8::23>>)
  defp enc(<<166>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFE9::23>>)
  defp enc(<<167>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFDE::21>>)
  defp enc(<<168>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFEA::23>>)
  defp enc(<<169>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFDD::22>>)
  defp enc(<<170>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFDE::22>>)
  defp enc(<<171>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFF0::24>>)
  defp enc(<<172>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFDF::21>>)
  defp enc(<<173>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFDF::22>>)
  defp enc(<<174>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFEB::23>>)
  defp enc(<<175>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFEC::23>>)
  defp enc(<<176>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFE0::21>>)
  defp enc(<<177>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFE1::21>>)
  defp enc(<<178>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFE0::22>>)
  defp enc(<<179>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFE2::21>>)
  defp enc(<<180>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFED::23>>)
  defp enc(<<181>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFE1::22>>)
  defp enc(<<182>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFEE::23>>)
  defp enc(<<183>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFEF::23>>)
  defp enc(<<184>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFEA::20>>)
  defp enc(<<185>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFE2::22>>)
  defp enc(<<186>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFE3::22>>)
  defp enc(<<187>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFE4::22>>)
  defp enc(<<188>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFF0::23>>)
  defp enc(<<189>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFE5::22>>)
  defp enc(<<190>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFE6::22>>)
  defp enc(<<191>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFF1::23>>)
  defp enc(<<192>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFE0::26>>)
  defp enc(<<193>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFE1::26>>)
  defp enc(<<194>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFEB::20>>)
  defp enc(<<195>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFF1::19>>)
  defp enc(<<196>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFE7::22>>)
  defp enc(<<197>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFF2::23>>)
  defp enc(<<198>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFE8::22>>)
  defp enc(<<199>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFFFEC::25>>)
  defp enc(<<200>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFE2::26>>)
  defp enc(<<201>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFE3::26>>)
  defp enc(<<202>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFE4::26>>)
  defp enc(<<203>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFDE::27>>)
  defp enc(<<204>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFFDF::27>>)
  defp enc(<<205>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFE5::26>>)
  defp enc(<<206>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFF1::24>>)
  defp enc(<<49>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1::5>>)
  defp enc(<<50>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x2::5>>)
  defp enc(<<51>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x19::6>>)
  defp enc(<<52>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1A::6>>)
  defp enc(<<53>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1B::6>>)
  defp enc(<<54>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1C::6>>)
  defp enc(<<55>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1D::6>>)
  defp enc(<<56>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1E::6>>)
  defp enc(<<57>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1F::6>>)
  defp enc(<<58>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x5C::7>>)
  defp enc(<<59>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFB::8>>)
  defp enc(<<60>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFC::15>>)
  defp enc(<<61>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x20::6>>)
  defp enc(<<62>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFB::12>>)
  defp enc(<<63>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FC::10>>)
  defp enc(<<64>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFA::13>>)
  defp enc(<<65>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x21::6>>)
  defp enc(<<66>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x5D::7>>)
  defp enc(<<67>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x5E::7>>)
  defp enc(<<68>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x5F::7>>)
  defp enc(<<69>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x60::7>>)
  defp enc(<<70>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x61::7>>)
  defp enc(<<71>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x62::7>>)
  defp enc(<<72>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x63::7>>)
  defp enc(<<73>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x64::7>>)
  defp enc(<<74>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x65::7>>)
  defp enc(<<75>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x66::7>>)
  defp enc(<<76>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x67::7>>)
  defp enc(<<77>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x68::7>>)
  defp enc(<<78>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x69::7>>)
  defp enc(<<79>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x6A::7>>)
  defp enc(<<80>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x6B::7>>)
  defp enc(<<81>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x6C::7>>)
  defp enc(<<82>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x6D::7>>)
  defp enc(<<83>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x6E::7>>)
  defp enc(<<84>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x6F::7>>)
  defp enc(<<85>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x70::7>>)
  defp enc(<<86>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x71::7>>)
  defp enc(<<87>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x72::7>>)
  defp enc(<<88>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFC::8>>)
  defp enc(<<89>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x73::7>>)
  defp enc(<<90>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFD::8>>)
  defp enc(<<91>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFB::13>>)
  defp enc(<<92>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFF0::19>>)
  defp enc(<<93>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FFC::13>>)
  defp enc(<<94>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFC::14>>)
  defp enc(<<95>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x22::6>>)
  defp enc(<<96>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFD::15>>)
  defp enc(<<97>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3::5>>)
  defp enc(<<98>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x23::6>>)
  defp enc(<<99>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x4::5>>)
  defp enc(<<100>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x24::6>>)
  defp enc(<<101>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x5::5>>)
  defp enc(<<102>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x25::6>>)
  defp enc(<<103>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x26::6>>)
  defp enc(<<104>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x27::6>>)
  defp enc(<<105>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x6::5>>)
  defp enc(<<106>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x74::7>>)
  defp enc(<<107>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x75::7>>)
  defp enc(<<108>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x28::6>>)
  defp enc(<<109>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x29::6>>)
  defp enc(<<110>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x2A::6>>)
  defp enc(<<111>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7::5>>)
  defp enc(<<112>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x2B::6>>)
  defp enc(<<113>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x76::7>>)
  defp enc(<<114>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x2C::6>>)
  defp enc(<<115>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x8::5>>)
  defp enc(<<116>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x9::5>>)
  defp enc(<<0>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FF8::13>>)
  defp enc(<<1>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FFFD8::23>>)
  defp enc(<<2>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFE2::28>>)
  defp enc(<<3>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFE3::28>>)
  defp enc(<<4>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFE4::28>>)
  defp enc(<<5>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFE5::28>>)
  defp enc(<<6>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFE6::28>>)
  defp enc(<<7>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFE7::28>>)
  defp enc(<<8>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFE8::28>>)
  defp enc(<<9>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFEA::24>>)
  defp enc(<<10>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFFFC::30>>)
  defp enc(<<11>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFE9::28>>)
  defp enc(<<12>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFEA::28>>)
  defp enc(<<13>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFFFD::30>>)
  defp enc(<<14>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFEB::28>>)
  defp enc(<<15>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFEC::28>>)
  defp enc(<<16>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFED::28>>)
  defp enc(<<17>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFEE::28>>)
  defp enc(<<18>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFEF::28>>)
  defp enc(<<19>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFF0::28>>)
  defp enc(<<20>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFF1::28>>)
  defp enc(<<21>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFF2::28>>)
  defp enc(<<22>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FFFFFFE::30>>)
  defp enc(<<23>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFF3::28>>)
  defp enc(<<24>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFF4::28>>)
  defp enc(<<25>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFF5::28>>)
  defp enc(<<26>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFF6::28>>)
  defp enc(<<27>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFF7::28>>)
  defp enc(<<28>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFF8::28>>)
  defp enc(<<29>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFF9::28>>)
  defp enc(<<30>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFFA::28>>)
  defp enc(<<31>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFFFFFB::28>>)
  defp enc(<<32>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x14::6>>)
  defp enc(<<33>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3F8::10>>)
  defp enc(<<34>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3F9::10>>)
  defp enc(<<35>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFFA::12>>)
  defp enc(<<36>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x1FF9::13>>)
  defp enc(<<37>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x15::6>>)
  defp enc(<<38>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xF8::8>>)
  defp enc(<<39>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FA::11>>)
  defp enc(<<40>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FA::10>>)
  defp enc(<<41>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x3FB::10>>)
  defp enc(<<42>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xF9::8>>)
  defp enc(<<43>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x7FB::11>>)
  defp enc(<<44>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0xFA::8>>)
  defp enc(<<45>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x16::6>>)
  defp enc(<<46>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x17::6>>)
  defp enc(<<47>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x18::6>>)
  defp enc(<<48>> <> rest, bin), do: enc(rest, <<bin::bitstring, 0x0::5>>)

  # eos
  defp dec(_, 0, string), do: string
  defp dec(<<0b1::1>>, 1, string), do: string
  defp dec(<<0b11::2>>, 2, string), do: string
  defp dec(<<0b111::3>>, 3, string), do: string
  defp dec(<<0b1111::4>>, 4, string), do: string
  defp dec(<<0b11111::5>>, 5, string), do: string
  defp dec(<<0b111111::6>>, 6, string), do: string
  defp dec(<<0b1111111::7>>, 7, string), do: string

  # static huffman table
  defp dec(<<0x7FFFFE7::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<244>>)

  defp dec(<<0x7FFFFE8::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<245>>)

  defp dec(<<0x7FFFFE9::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<246>>)

  defp dec(<<0x7FFFFEA::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<247>>)

  defp dec(<<0x7FFFFEB::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<248>>)

  defp dec(<<0xFFFFFFE::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<249>>)

  defp dec(<<0x7FFFFEC::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<250>>)

  defp dec(<<0x7FFFFED::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<251>>)

  defp dec(<<0x7FFFFEE::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<252>>)

  defp dec(<<0x7FFFFEF::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<253>>)

  defp dec(<<0x7FFFFF0::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<254>>)

  defp dec(<<0x3FFFFEE::26, rest::bitstring>>, length, result),
    do: dec(rest, length - 26, result <> <<255>>)

  defp dec(<<0x1FFFFED::25, rest::bitstring>>, length, result),
    do: dec(rest, length - 25, result <> <<207>>)

  defp dec(<<0x7FFF2::19, rest::bitstring>>, length, result),
    do: dec(rest, length - 19, result <> <<208>>)

  defp dec(<<0x1FFFE3::21, rest::bitstring>>, length, result),
    do: dec(rest, length - 21, result <> <<209>>)

  defp dec(<<0x3FFFFE6::26, rest::bitstring>>, length, result),
    do: dec(rest, length - 26, result <> <<210>>)

  defp dec(<<0x7FFFFE0::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<211>>)

  defp dec(<<0x7FFFFE1::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<212>>)

  defp dec(<<0x3FFFFE7::26, rest::bitstring>>, length, result),
    do: dec(rest, length - 26, result <> <<213>>)

  defp dec(<<0x7FFFFE2::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<214>>)

  defp dec(<<0xFFFFF2::24, rest::bitstring>>, length, result),
    do: dec(rest, length - 24, result <> <<215>>)

  defp dec(<<0x1FFFE4::21, rest::bitstring>>, length, result),
    do: dec(rest, length - 21, result <> <<216>>)

  defp dec(<<0x1FFFE5::21, rest::bitstring>>, length, result),
    do: dec(rest, length - 21, result <> <<217>>)

  defp dec(<<0x3FFFFE8::26, rest::bitstring>>, length, result),
    do: dec(rest, length - 26, result <> <<218>>)

  defp dec(<<0x3FFFFE9::26, rest::bitstring>>, length, result),
    do: dec(rest, length - 26, result <> <<219>>)

  defp dec(<<0xFFFFFFD::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<220>>)

  defp dec(<<0x7FFFFE3::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<221>>)

  defp dec(<<0x7FFFFE4::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<222>>)

  defp dec(<<0x7FFFFE5::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<223>>)

  defp dec(<<0xFFFEC::20, rest::bitstring>>, length, result),
    do: dec(rest, length - 20, result <> <<224>>)

  defp dec(<<0xFFFFF3::24, rest::bitstring>>, length, result),
    do: dec(rest, length - 24, result <> <<225>>)

  defp dec(<<0xFFFED::20, rest::bitstring>>, length, result),
    do: dec(rest, length - 20, result <> <<226>>)

  defp dec(<<0x1FFFE6::21, rest::bitstring>>, length, result),
    do: dec(rest, length - 21, result <> <<227>>)

  defp dec(<<0x3FFFE9::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<228>>)

  defp dec(<<0x1FFFE7::21, rest::bitstring>>, length, result),
    do: dec(rest, length - 21, result <> <<229>>)

  defp dec(<<0x1FFFE8::21, rest::bitstring>>, length, result),
    do: dec(rest, length - 21, result <> <<230>>)

  defp dec(<<0x7FFFF3::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<231>>)

  defp dec(<<0x3FFFEA::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<232>>)

  defp dec(<<0x3FFFEB::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<233>>)

  defp dec(<<0x1FFFFEE::25, rest::bitstring>>, length, result),
    do: dec(rest, length - 25, result <> <<234>>)

  defp dec(<<0x1FFFFEF::25, rest::bitstring>>, length, result),
    do: dec(rest, length - 25, result <> <<235>>)

  defp dec(<<0xFFFFF4::24, rest::bitstring>>, length, result),
    do: dec(rest, length - 24, result <> <<236>>)

  defp dec(<<0xFFFFF5::24, rest::bitstring>>, length, result),
    do: dec(rest, length - 24, result <> <<237>>)

  defp dec(<<0x3FFFFEA::26, rest::bitstring>>, length, result),
    do: dec(rest, length - 26, result <> <<238>>)

  defp dec(<<0x7FFFF4::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<239>>)

  defp dec(<<0x3FFFFEB::26, rest::bitstring>>, length, result),
    do: dec(rest, length - 26, result <> <<240>>)

  defp dec(<<0x7FFFFE6::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<241>>)

  defp dec(<<0x3FFFFEC::26, rest::bitstring>>, length, result),
    do: dec(rest, length - 26, result <> <<242>>)

  defp dec(<<0x3FFFFED::26, rest::bitstring>>, length, result),
    do: dec(rest, length - 26, result <> <<243>>)

  defp dec(<<0x2D::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<117>>)

  defp dec(<<0x77::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<118>>)

  defp dec(<<0x78::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<119>>)

  defp dec(<<0x79::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<120>>)

  defp dec(<<0x7A::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<121>>)

  defp dec(<<0x7B::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<122>>)

  defp dec(<<0x7FFE::15, rest::bitstring>>, length, result),
    do: dec(rest, length - 15, result <> <<123>>)

  defp dec(<<0x7FC::11, rest::bitstring>>, length, result),
    do: dec(rest, length - 11, result <> <<124>>)

  defp dec(<<0x3FFD::14, rest::bitstring>>, length, result),
    do: dec(rest, length - 14, result <> <<125>>)

  defp dec(<<0x1FFD::13, rest::bitstring>>, length, result),
    do: dec(rest, length - 13, result <> <<126>>)

  defp dec(<<0xFFFFFFC::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<127>>)

  defp dec(<<0xFFFE6::20, rest::bitstring>>, length, result),
    do: dec(rest, length - 20, result <> <<128>>)

  defp dec(<<0x3FFFD2::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<129>>)

  defp dec(<<0xFFFE7::20, rest::bitstring>>, length, result),
    do: dec(rest, length - 20, result <> <<130>>)

  defp dec(<<0xFFFE8::20, rest::bitstring>>, length, result),
    do: dec(rest, length - 20, result <> <<131>>)

  defp dec(<<0x3FFFD3::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<132>>)

  defp dec(<<0x3FFFD4::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<133>>)

  defp dec(<<0x3FFFD5::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<134>>)

  defp dec(<<0x7FFFD9::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<135>>)

  defp dec(<<0x3FFFD6::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<136>>)

  defp dec(<<0x7FFFDA::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<137>>)

  defp dec(<<0x7FFFDB::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<138>>)

  defp dec(<<0x7FFFDC::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<139>>)

  defp dec(<<0x7FFFDD::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<140>>)

  defp dec(<<0x7FFFDE::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<141>>)

  defp dec(<<0xFFFFEB::24, rest::bitstring>>, length, result),
    do: dec(rest, length - 24, result <> <<142>>)

  defp dec(<<0x7FFFDF::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<143>>)

  defp dec(<<0xFFFFEC::24, rest::bitstring>>, length, result),
    do: dec(rest, length - 24, result <> <<144>>)

  defp dec(<<0xFFFFED::24, rest::bitstring>>, length, result),
    do: dec(rest, length - 24, result <> <<145>>)

  defp dec(<<0x3FFFD7::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<146>>)

  defp dec(<<0x7FFFE0::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<147>>)

  defp dec(<<0xFFFFEE::24, rest::bitstring>>, length, result),
    do: dec(rest, length - 24, result <> <<148>>)

  defp dec(<<0x7FFFE1::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<149>>)

  defp dec(<<0x7FFFE2::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<150>>)

  defp dec(<<0x7FFFE3::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<151>>)

  defp dec(<<0x7FFFE4::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<152>>)

  defp dec(<<0x1FFFDC::21, rest::bitstring>>, length, result),
    do: dec(rest, length - 21, result <> <<153>>)

  defp dec(<<0x3FFFD8::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<154>>)

  defp dec(<<0x7FFFE5::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<155>>)

  defp dec(<<0x3FFFD9::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<156>>)

  defp dec(<<0x7FFFE6::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<157>>)

  defp dec(<<0x7FFFE7::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<158>>)

  defp dec(<<0xFFFFEF::24, rest::bitstring>>, length, result),
    do: dec(rest, length - 24, result <> <<159>>)

  defp dec(<<0x3FFFDA::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<160>>)

  defp dec(<<0x1FFFDD::21, rest::bitstring>>, length, result),
    do: dec(rest, length - 21, result <> <<161>>)

  defp dec(<<0xFFFE9::20, rest::bitstring>>, length, result),
    do: dec(rest, length - 20, result <> <<162>>)

  defp dec(<<0x3FFFDB::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<163>>)

  defp dec(<<0x3FFFDC::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<164>>)

  defp dec(<<0x7FFFE8::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<165>>)

  defp dec(<<0x7FFFE9::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<166>>)

  defp dec(<<0x1FFFDE::21, rest::bitstring>>, length, result),
    do: dec(rest, length - 21, result <> <<167>>)

  defp dec(<<0x7FFFEA::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<168>>)

  defp dec(<<0x3FFFDD::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<169>>)

  defp dec(<<0x3FFFDE::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<170>>)

  defp dec(<<0xFFFFF0::24, rest::bitstring>>, length, result),
    do: dec(rest, length - 24, result <> <<171>>)

  defp dec(<<0x1FFFDF::21, rest::bitstring>>, length, result),
    do: dec(rest, length - 21, result <> <<172>>)

  defp dec(<<0x3FFFDF::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<173>>)

  defp dec(<<0x7FFFEB::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<174>>)

  defp dec(<<0x7FFFEC::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<175>>)

  defp dec(<<0x1FFFE0::21, rest::bitstring>>, length, result),
    do: dec(rest, length - 21, result <> <<176>>)

  defp dec(<<0x1FFFE1::21, rest::bitstring>>, length, result),
    do: dec(rest, length - 21, result <> <<177>>)

  defp dec(<<0x3FFFE0::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<178>>)

  defp dec(<<0x1FFFE2::21, rest::bitstring>>, length, result),
    do: dec(rest, length - 21, result <> <<179>>)

  defp dec(<<0x7FFFED::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<180>>)

  defp dec(<<0x3FFFE1::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<181>>)

  defp dec(<<0x7FFFEE::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<182>>)

  defp dec(<<0x7FFFEF::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<183>>)

  defp dec(<<0xFFFEA::20, rest::bitstring>>, length, result),
    do: dec(rest, length - 20, result <> <<184>>)

  defp dec(<<0x3FFFE2::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<185>>)

  defp dec(<<0x3FFFE3::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<186>>)

  defp dec(<<0x3FFFE4::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<187>>)

  defp dec(<<0x7FFFF0::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<188>>)

  defp dec(<<0x3FFFE5::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<189>>)

  defp dec(<<0x3FFFE6::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<190>>)

  defp dec(<<0x7FFFF1::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<191>>)

  defp dec(<<0x3FFFFE0::26, rest::bitstring>>, length, result),
    do: dec(rest, length - 26, result <> <<192>>)

  defp dec(<<0x3FFFFE1::26, rest::bitstring>>, length, result),
    do: dec(rest, length - 26, result <> <<193>>)

  defp dec(<<0xFFFEB::20, rest::bitstring>>, length, result),
    do: dec(rest, length - 20, result <> <<194>>)

  defp dec(<<0x7FFF1::19, rest::bitstring>>, length, result),
    do: dec(rest, length - 19, result <> <<195>>)

  defp dec(<<0x3FFFE7::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<196>>)

  defp dec(<<0x7FFFF2::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<197>>)

  defp dec(<<0x3FFFE8::22, rest::bitstring>>, length, result),
    do: dec(rest, length - 22, result <> <<198>>)

  defp dec(<<0x1FFFFEC::25, rest::bitstring>>, length, result),
    do: dec(rest, length - 25, result <> <<199>>)

  defp dec(<<0x3FFFFE2::26, rest::bitstring>>, length, result),
    do: dec(rest, length - 26, result <> <<200>>)

  defp dec(<<0x3FFFFE3::26, rest::bitstring>>, length, result),
    do: dec(rest, length - 26, result <> <<201>>)

  defp dec(<<0x3FFFFE4::26, rest::bitstring>>, length, result),
    do: dec(rest, length - 26, result <> <<202>>)

  defp dec(<<0x7FFFFDE::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<203>>)

  defp dec(<<0x7FFFFDF::27, rest::bitstring>>, length, result),
    do: dec(rest, length - 27, result <> <<204>>)

  defp dec(<<0x3FFFFE5::26, rest::bitstring>>, length, result),
    do: dec(rest, length - 26, result <> <<205>>)

  defp dec(<<0xFFFFF1::24, rest::bitstring>>, length, result),
    do: dec(rest, length - 24, result <> <<206>>)

  defp dec(<<0x1::5, rest::bitstring>>, length, result),
    do: dec(rest, length - 5, result <> <<49>>)

  defp dec(<<0x2::5, rest::bitstring>>, length, result),
    do: dec(rest, length - 5, result <> <<50>>)

  defp dec(<<0x19::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<51>>)

  defp dec(<<0x1A::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<52>>)

  defp dec(<<0x1B::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<53>>)

  defp dec(<<0x1C::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<54>>)

  defp dec(<<0x1D::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<55>>)

  defp dec(<<0x1E::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<56>>)

  defp dec(<<0x1F::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<57>>)

  defp dec(<<0x5C::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<58>>)

  defp dec(<<0xFB::8, rest::bitstring>>, length, result),
    do: dec(rest, length - 8, result <> <<59>>)

  defp dec(<<0x7FFC::15, rest::bitstring>>, length, result),
    do: dec(rest, length - 15, result <> <<60>>)

  defp dec(<<0x20::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<61>>)

  defp dec(<<0xFFB::12, rest::bitstring>>, length, result),
    do: dec(rest, length - 12, result <> <<62>>)

  defp dec(<<0x3FC::10, rest::bitstring>>, length, result),
    do: dec(rest, length - 10, result <> <<63>>)

  defp dec(<<0x1FFA::13, rest::bitstring>>, length, result),
    do: dec(rest, length - 13, result <> <<64>>)

  defp dec(<<0x21::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<65>>)

  defp dec(<<0x5D::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<66>>)

  defp dec(<<0x5E::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<67>>)

  defp dec(<<0x5F::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<68>>)

  defp dec(<<0x60::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<69>>)

  defp dec(<<0x61::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<70>>)

  defp dec(<<0x62::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<71>>)

  defp dec(<<0x63::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<72>>)

  defp dec(<<0x64::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<73>>)

  defp dec(<<0x65::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<74>>)

  defp dec(<<0x66::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<75>>)

  defp dec(<<0x67::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<76>>)

  defp dec(<<0x68::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<77>>)

  defp dec(<<0x69::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<78>>)

  defp dec(<<0x6A::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<79>>)

  defp dec(<<0x6B::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<80>>)

  defp dec(<<0x6C::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<81>>)

  defp dec(<<0x6D::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<82>>)

  defp dec(<<0x6E::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<83>>)

  defp dec(<<0x6F::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<84>>)

  defp dec(<<0x70::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<85>>)

  defp dec(<<0x71::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<86>>)

  defp dec(<<0x72::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<87>>)

  defp dec(<<0xFC::8, rest::bitstring>>, length, result),
    do: dec(rest, length - 8, result <> <<88>>)

  defp dec(<<0x73::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<89>>)

  defp dec(<<0xFD::8, rest::bitstring>>, length, result),
    do: dec(rest, length - 8, result <> <<90>>)

  defp dec(<<0x1FFB::13, rest::bitstring>>, length, result),
    do: dec(rest, length - 13, result <> <<91>>)

  defp dec(<<0x7FFF0::19, rest::bitstring>>, length, result),
    do: dec(rest, length - 19, result <> <<92>>)

  defp dec(<<0x1FFC::13, rest::bitstring>>, length, result),
    do: dec(rest, length - 13, result <> <<93>>)

  defp dec(<<0x3FFC::14, rest::bitstring>>, length, result),
    do: dec(rest, length - 14, result <> <<94>>)

  defp dec(<<0x22::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<95>>)

  defp dec(<<0x7FFD::15, rest::bitstring>>, length, result),
    do: dec(rest, length - 15, result <> <<96>>)

  defp dec(<<0x3::5, rest::bitstring>>, length, result),
    do: dec(rest, length - 5, result <> <<97>>)

  defp dec(<<0x23::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<98>>)

  defp dec(<<0x4::5, rest::bitstring>>, length, result),
    do: dec(rest, length - 5, result <> <<99>>)

  defp dec(<<0x24::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<100>>)

  defp dec(<<0x5::5, rest::bitstring>>, length, result),
    do: dec(rest, length - 5, result <> <<101>>)

  defp dec(<<0x25::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<102>>)

  defp dec(<<0x26::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<103>>)

  defp dec(<<0x27::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<104>>)

  defp dec(<<0x6::5, rest::bitstring>>, length, result),
    do: dec(rest, length - 5, result <> <<105>>)

  defp dec(<<0x74::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<106>>)

  defp dec(<<0x75::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<107>>)

  defp dec(<<0x28::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<108>>)

  defp dec(<<0x29::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<109>>)

  defp dec(<<0x2A::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<110>>)

  defp dec(<<0x7::5, rest::bitstring>>, length, result),
    do: dec(rest, length - 5, result <> <<111>>)

  defp dec(<<0x2B::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<112>>)

  defp dec(<<0x76::7, rest::bitstring>>, length, result),
    do: dec(rest, length - 7, result <> <<113>>)

  defp dec(<<0x2C::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<114>>)

  defp dec(<<0x8::5, rest::bitstring>>, length, result),
    do: dec(rest, length - 5, result <> <<115>>)

  defp dec(<<0x9::5, rest::bitstring>>, length, result),
    do: dec(rest, length - 5, result <> <<116>>)

  defp dec(<<0x1FF8::13, rest::bitstring>>, length, result),
    do: dec(rest, length - 13, result <> <<0>>)

  defp dec(<<0x7FFFD8::23, rest::bitstring>>, length, result),
    do: dec(rest, length - 23, result <> <<1>>)

  defp dec(<<0xFFFFFE2::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<2>>)

  defp dec(<<0xFFFFFE3::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<3>>)

  defp dec(<<0xFFFFFE4::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<4>>)

  defp dec(<<0xFFFFFE5::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<5>>)

  defp dec(<<0xFFFFFE6::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<6>>)

  defp dec(<<0xFFFFFE7::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<7>>)

  defp dec(<<0xFFFFFE8::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<8>>)

  defp dec(<<0xFFFFEA::24, rest::bitstring>>, length, result),
    do: dec(rest, length - 24, result <> <<9>>)

  defp dec(<<0x3FFFFFFC::30, rest::bitstring>>, length, result),
    do: dec(rest, length - 30, result <> <<10>>)

  defp dec(<<0xFFFFFE9::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<11>>)

  defp dec(<<0xFFFFFEA::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<12>>)

  defp dec(<<0x3FFFFFFD::30, rest::bitstring>>, length, result),
    do: dec(rest, length - 30, result <> <<13>>)

  defp dec(<<0xFFFFFEB::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<14>>)

  defp dec(<<0xFFFFFEC::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<15>>)

  defp dec(<<0xFFFFFED::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<16>>)

  defp dec(<<0xFFFFFEE::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<17>>)

  defp dec(<<0xFFFFFEF::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<18>>)

  defp dec(<<0xFFFFFF0::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<19>>)

  defp dec(<<0xFFFFFF1::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<20>>)

  defp dec(<<0xFFFFFF2::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<21>>)

  defp dec(<<0x3FFFFFFE::30, rest::bitstring>>, length, result),
    do: dec(rest, length - 30, result <> <<22>>)

  defp dec(<<0xFFFFFF3::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<23>>)

  defp dec(<<0xFFFFFF4::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<24>>)

  defp dec(<<0xFFFFFF5::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<25>>)

  defp dec(<<0xFFFFFF6::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<26>>)

  defp dec(<<0xFFFFFF7::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<27>>)

  defp dec(<<0xFFFFFF8::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<28>>)

  defp dec(<<0xFFFFFF9::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<29>>)

  defp dec(<<0xFFFFFFA::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<30>>)

  defp dec(<<0xFFFFFFB::28, rest::bitstring>>, length, result),
    do: dec(rest, length - 28, result <> <<31>>)

  defp dec(<<0x14::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<32>>)

  defp dec(<<0x3F8::10, rest::bitstring>>, length, result),
    do: dec(rest, length - 10, result <> <<33>>)

  defp dec(<<0x3F9::10, rest::bitstring>>, length, result),
    do: dec(rest, length - 10, result <> <<34>>)

  defp dec(<<0xFFA::12, rest::bitstring>>, length, result),
    do: dec(rest, length - 12, result <> <<35>>)

  defp dec(<<0x1FF9::13, rest::bitstring>>, length, result),
    do: dec(rest, length - 13, result <> <<36>>)

  defp dec(<<0x15::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<37>>)

  defp dec(<<0xF8::8, rest::bitstring>>, length, result),
    do: dec(rest, length - 8, result <> <<38>>)

  defp dec(<<0x7FA::11, rest::bitstring>>, length, result),
    do: dec(rest, length - 11, result <> <<39>>)

  defp dec(<<0x3FA::10, rest::bitstring>>, length, result),
    do: dec(rest, length - 10, result <> <<40>>)

  defp dec(<<0x3FB::10, rest::bitstring>>, length, result),
    do: dec(rest, length - 10, result <> <<41>>)

  defp dec(<<0xF9::8, rest::bitstring>>, length, result),
    do: dec(rest, length - 8, result <> <<42>>)

  defp dec(<<0x7FB::11, rest::bitstring>>, length, result),
    do: dec(rest, length - 11, result <> <<43>>)

  defp dec(<<0xFA::8, rest::bitstring>>, length, result),
    do: dec(rest, length - 8, result <> <<44>>)

  defp dec(<<0x16::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<45>>)

  defp dec(<<0x17::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<46>>)

  defp dec(<<0x18::6, rest::bitstring>>, length, result),
    do: dec(rest, length - 6, result <> <<47>>)

  defp dec(<<0x0::5, rest::bitstring>>, length, result),
    do: dec(rest, length - 5, result <> <<48>>)
end
