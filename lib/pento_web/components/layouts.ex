defmodule PentoWeb.Layouts do
  use PentoWeb, :html

  embed_templates "layouts/*"
  embed_sface "layouts/root.sface"
  embed_sface "layouts/app.sface"
end
