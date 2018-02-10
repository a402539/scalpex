defmodule Scalpex do
  @moduledoc """
  Scalpex

  A scalping trader bot for BitCoin BlinkTrade platform based exchanges.
  """
  require Logger

  def main(argv) do
    Logger.info "Scalpex initiating..."
    argv
    |> parse_args
    |> process
  end

  @doc """
  Parse the arguments from the command line. 'argv' can be:
  -h or --help, which returns :help.
  -p, to explicitly force the production environment.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean, production: :boolean],
                                     aliases:  [h: :help, p: :production])

    case parse do
      {[help: true], _, _} -> :help

      {[production: true], _, _} -> :production

      _ -> :test
    end
  end

  def process(:help) do
    IO.puts """
    usage: scalpex [ -p | -h ]
    """
    System.halt(0)
  end

  def process(env) do
    Logger.info "Starting the trader in the #{env} environment..."
    exchange = Scalpex.Trader.startup
  end  
end
