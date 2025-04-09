defmodule PricingEngine.Products do
  @moduledoc """
  This module emulates a table of available products.
  """
  alias PricingEngine.Product

  @available_products [
    %Product{
      code: "GR1",
      name: "Green tea",
      price: 3.11
    },
    %Product{
      code: "SR1",
      name: "Strawberries",
      price: 5.00
    },
    %Product{
      code: "CF1",
      name: "Coffee",
      price: 11.23
    }
  ]

  def get_products_by_codes(codes) do
    codes
    |> Enum.map(fn code ->
      Enum.find(@available_products, fn p -> p.code == code end)
    end)
    |> Enum.reject(&is_nil(&1))
  end
end
