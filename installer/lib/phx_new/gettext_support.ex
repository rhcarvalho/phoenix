defmodule Phx.New.GettextSupport do
  @moduledoc false

  @doc ~S"""
  Translates a message using Gettext if `gettext?` is true.

  The role provides context and determines which syntax should be used.

  ## Examples

      iex> ~s|<tag attr=#{maybe_gettext("Hello", :heex_attr, true)} />|
      ~S|<tag attr={gettext("Hello")} />|

      iex> ~s|<tag attr=#{maybe_gettext("Hello", :heex_attr, false)} />|
      ~S|<tag attr="Hello" />|

      iex> ~s|<tag>#{maybe_gettext("Hello", :text, true)}</tag>|
      ~S|<tag><%= gettext("Hello") %></tag>|

      iex> ~s|<tag>#{maybe_gettext("Hello", :text, false)}</tag>|
      ~S|<tag>Hello</tag>|
  """
  @spec maybe_gettext(binary(), :heex_attr | :text, boolean()) :: binary()
  def maybe_gettext(message, role, gettext?)

  def maybe_gettext(message, :heex_attr, gettext?) do
    if gettext? do
      ~s|{gettext(#{inspect(message)})}|
    else
      inspect(message)
    end
  end

  def maybe_gettext(message, :text, gettext?) do
    if gettext? do
      ~s|<%= gettext(#{inspect(message)}) %>|
    else
      message
    end
  end
end
