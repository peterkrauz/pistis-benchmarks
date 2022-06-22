defmodule LoadGenerator.Instrumentation do
  def can_log(requesting_pid) do
    [{:worker, pid, _, _}] = Supervisor.which_children(LoadGenerator.Supervisor)
    worker_pids = Process.info(pid) |> Keyword.get(:links) |> Enum.sort()
    chosen_pid = Enum.at(worker_pids, length(worker_pids) - 1)
    requesting_pid == chosen_pid
  end
end
