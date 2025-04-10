defmodule PricingEngine do
  @moduledoc false
  alias PricingEngine.Product
  alias PricingEngine.Products
  alias PricingEngine.Rule

  @default_rules [
    %Rule{
      name: "CEO discount",
      apply_to_code: "GR1",
      type: :apply_to_quantity,
      quantity: 2,
      percent_off: 50.0
    },
    %Rule{
      name: "COO discount",
      type: :apply_to_whole_group,
      apply_to_code: "SR1",
      quantity: 3,
      percent_off: 10.0
    },
    %Rule{
      name: "CTO discount",
      type: :apply_to_whole_group,
      apply_to_code: "CF1",
      quantity: 3,
      percent_off: 1 / 3 * 100
    }
  ]

  @spec check_out(product_codes :: [String.t()], [Rule.t()]) :: String.t()
  def check_out(product_codes, rules \\ @default_rules) do
    product_code_to_rule = Map.new(rules, &{&1.apply_to_code, &1})

    product_codes
    |> Products.get_products_by_codes()
    |> Enum.group_by(& &1.code)
    |> Enum.reduce(0, fn {product_code, product_list}, acc ->
      sum_by_product =
        product_code_to_rule
        |> Map.get(product_code, nil)
        |> apply_rule_to_product(product_list)

      acc + sum_by_product
    end)
    |> Kernel.*(100)
    |> trunc()
    |> Money.new()
    |> Money.to_string()
  end

  defp apply_rule_to_product(nil, product_list), do: calculate_total_for_products(product_list)

  defp apply_rule_to_product(%Rule{type: :apply_to_quantity} = rule, product_list),
    do: apply_quantity_rule(product_list, rule, 0)

  defp apply_rule_to_product(%Rule{type: :apply_to_whole_group} = rule, product_list),
    do: apply_whole_group_rule(product_list, rule)

  defp apply_quantity_rule([], _rule, acc), do: acc

  defp apply_quantity_rule(product_list, %Rule{} = rule, acc) do
    {products_to_process, product_list} = Enum.split(product_list, rule.quantity)
    products_to_process_count = length(products_to_process)

    case products_to_process_count >= rule.quantity do
      true ->
        new_acc =
          acc + calculate_total_for_products(products_to_process) * (100 - rule.percent_off) / 100

        apply_quantity_rule(product_list, rule, new_acc)

      false ->
        new_acc = acc + calculate_total_for_products(products_to_process)
        apply_quantity_rule([], rule, new_acc)
    end
  end

  defp apply_whole_group_rule(product_list, %Rule{} = rule) do
    products_to_process_count = length(product_list)

    case products_to_process_count >= rule.quantity do
      true ->
        calculate_total_for_products(product_list) * (100 - rule.percent_off) / 100

      false ->
        calculate_total_for_products(product_list)
    end
  end

  defp calculate_total_for_products(product_list),
    do: Enum.reduce(product_list, 0, fn %Product{} = product, acc -> acc + product.price end)
end
