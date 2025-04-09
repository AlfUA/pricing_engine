defmodule PricingEngine.Product do
  @moduledoc """
  This module defines a struct to keep product data.
  """
  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          price: float()
        }
  @enforce_keys [:code, :name, :price]
  defstruct @enforce_keys

  @doc "Creates a new product struct"
  @spec new(%{
          required(:code) => String.t(),
          required(:name) => String.t(),
          required(:price) => float()
        }) :: t()
  def new(params), do: struct(__MODULE__, params)
end
