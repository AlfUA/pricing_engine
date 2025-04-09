defmodule PricingEngineTest do
  use ExUnit.Case

  describe "PricingEngine calculates final price" do
    test "with no rules provided" do
      assert PricingEngine.check_out(["GR1", "CF1", "SR1", "CF1", "CF1"], []) == "£41.80"
    end

    test "for list of [GR1, SR1, GR1, GR1, CF1] with standard rules provided" do
      assert PricingEngine.check_out(["GR1", "SR1", "GR1", "GR1", "CF1"]) == "£22.45"
    end

    test "for list of [GR1, GR1] with standard rules provided" do
      assert PricingEngine.check_out(["GR1", "GR1"]) == "£3.11"
    end

    test "for list of [SR1, SR1, GR1, SR1] with standard rules provided" do
      assert PricingEngine.check_out(["SR1", "SR1", "GR1", "SR1"]) == "£16.61"
    end

    test "for list of [GR1, CF1, SR1, CF1, CF1] with standard rules provided" do
      assert PricingEngine.check_out(["GR1", "CF1", "SR1", "CF1", "CF1"]) == "£30.57"
    end

    test "for empty cart" do
      assert PricingEngine.check_out([]) == "£0.00"
    end

    test "for invalid product codes" do
      assert PricingEngine.check_out(["INVALID", "GR1", "UNKNOWN"]) == "£3.11"
    end

    test "for order with exact quantities to trigger rules" do
      assert PricingEngine.check_out([
               # 1 pair of Green tea with 50% off on second item
               "GR1",
               "GR1",
               # 3 Strawberries with 10% off
               "SR1",
               "SR1",
               "SR1",
               # 3 Coffees with 1/3 off
               "CF1",
               "CF1",
               "CF1"
             ]) == "£39.07"
    end
  end
end
