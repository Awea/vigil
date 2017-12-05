defmodule Vigil.Scheduler do
  @moduledoc """
  Instead of providing one global Quantum GenServer, every app has to provide its own Scheduler in V2. This module is responsible of that.
  """

  use Quantum.Scheduler, otp_app: :vigil
end