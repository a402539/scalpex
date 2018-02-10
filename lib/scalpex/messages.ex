defmodule Scalpex.Messages do
  @moduledoc """
  This module provides functions for creating message payloads of the various message types as specified by the BlikTrade API
  """
  def order_book_subscription(state) do
    {:text, 
      %{MsgType: "V",
        MDReqID: state.last_req + 1,
        SubscriptionRequestType: 1,
        MarketDepth: 1,
        MDUpdateType: 1,
        MDEntryTypes: ["0", "1", "2"],
        Instruments: ["BTCBRL"]}
      |> Poison.encode!
    }    
  end

  def login(state) do
    {:text, 
      %{MsgType: "BE",
        UserReqID: state.last_req + 1,
        BrokerID: broker(state.env),
        Username: Application.get_env( :scalpex, :APIKey ),
        Password: Application.get_env( :scalpex, :APIPassword ),
        UserReqTyp: "1",
        FingerPrint: Scalpex.Util.fingerprint()}
      |> Poison.encode!
    }
  end

  def heartbeat do
    {:text, Poison.encode!(%{ "MsgType" => "1", "TestReqID" => "0", "SendTime" => System.system_time(:second)}) }
  end

  defp broker(:test), do: 5 # BlinkTrade Testnet
  defp broker(:prod), do: 4 # FoxBit
end