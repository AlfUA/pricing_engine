defmodule PricingEngine.Rule do
  @moduledoc """
  This module defines a struct to keep rule data.
  """
  @type discount_type :: :apply_to_quantity | :apply_to_whole_group
  @type t :: %__MODULE__{
          name: String.t(),
          apply_to_code: String.t(),
          type: discount_type(),
          quantity: pos_integer(),
          percent_off: float()
        }

  @enforce_keys [:name, :apply_to_code, :quantity, :type]
  defstruct @enforce_keys ++ [:percent_off]

  @doc "Creates a new rule struct"
  @spec new(%{
          required(:name) => String.t(),
          required(:apply_to_code) => String.t(),
          required(:type) => discount_type(),
          required(:quantity) => pos_integer(),
          optional(:percent_off) => float()
        }) :: t()
  def new(params), do: struct(__MODULE__, params)
end
