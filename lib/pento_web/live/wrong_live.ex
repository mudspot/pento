defmodule PentoWeb.WrongLive do
  use PentoWeb, :surface_live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket, score: 0, message: "Make a guess: ", time: time(), answer: :rand.uniform(10))}
  end

  def render(assigns) do
    ~F"""
      <h1> Your score: {@score}</h1>
      <h2>
        {@message}
        It's {@time}
      </h2>
      <h2>
        <.link :for={n <- 1..10} href="#" phx-click="guess" phx-value-number={n}>
          {n}
        </.link>
      </h2>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    {message, score, answer} =
      if String.to_integer(guess) == socket.assigns.answer do
        {
          "Your guess: #{guess}. You guess right! New number generated.",
          0,
          :rand.uniform(10)
        }
      else
        {
          "Your guess: #{guess}. You guessed wrong! Try again.",
          socket.assigns.score - 1,
          socket.assigns.answer
        }
      end

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
        time: time(),
        answer: answer
      )
    }
  end

  def time() do
    DateTime.utc_now() |> to_string
  end
end
