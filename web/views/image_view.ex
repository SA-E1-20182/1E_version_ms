defmodule Versioning.ImageView do
  use Versioning.Web, :view

  def render("index.json", %{images: images}) do
    render_many(images, Versioning.ImageView, "image.json")
  end

  def render("show.json", %{image: image}) do
    render_one(image, Versioning.ImageView, "image.json")
  end

  def render("image.json", %{image: image}) do
    %{image_url: image.image_url,
    inserted_at: image.inserted_at
    }
  end
end
